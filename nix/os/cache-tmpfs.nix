{ config, lib, ... }:

let
  cfg = config.services.cacheTmpfs;
in
{
  options.services.cacheTmpfs.username = lib.mkOption {
    type = lib.types.str;
    description = "Username whose .cache directory should be symlinked to tmpfs";
  };

  config = lib.mkIf (cfg.username != null) {
    systemd.tmpfiles.rules = [
      "d /tmp/user-cache-${cfg.username} 0700 ${cfg.username} users -"
    ];

    # Mount tmpfs for user cache
    fileSystems."/tmp/user-cache-${cfg.username}" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [
        "defaults"
        "noatime"
        "nosuid"
        "nodev"
        "mode=0700"
        "uid=${cfg.username}"
        "gid=users"
        "size=2G"
      ];
    };

    # Ensure the mount happens before the symlink service
    systemd.services."setup-${cfg.username}-cache" = {
      description = "Setup ${cfg.username} cache symlink";
      after = [ "local-fs.target" ];
      wants = [ "var-run.mount" ];  # Ensure tmp is available
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = cfg.username;
        Group = "users";
      };

      script = ''
        # Wait a moment for the mount to be ready
        sleep 1
        
        # Get the actual UID at runtime
        USER_UID=$(id -u ${cfg.username})
        CACHE_PATH="/tmp/user-cache-${cfg.username}"
        
        # Ensure the directory exists and has correct ownership
        if [ -d "$CACHE_PATH" ]; then
          chown ${cfg.username}:users "$CACHE_PATH"
          chmod 0700 "$CACHE_PATH"
        fi
        
        # Handle existing .cache directory
        if [ -e /home/${cfg.username}/.cache ]; then
          if [ ! -L /home/${cfg.username}/.cache ]; then
            # Back up existing directory and remove it
            mv /home/${cfg.username}/.cache /home/${cfg.username}/.cache.backup-$(date +%Y%m%d-%H%M%S)
          else
            # Remove existing symlink
            rm /home/${cfg.username}/.cache
          fi
        fi
        
        # Create the symlink
        ln -sfn "$CACHE_PATH" /home/${cfg.username}/.cache
      '';
    };

    # Also run the setup at login via pam to ensure it's always correct
    security.pam.services.${cfg.username}.text = ''
      session optional pam_exec.so /run/current-system/sw/bin/bash -c '
        USER_UID=$(id -u ${cfg.username})
        CACHE_PATH="/tmp/user-cache-${cfg.username}"
        
        # Ensure directory exists with correct permissions at login
        if [ -d "$CACHE_PATH" ]; then
          chown ${cfg.username}:users "$CACHE_PATH"
          chmod 0700 "$CACHE_PATH"
        fi
        
        # Ensure symlink exists
        if [ ! -L /home/${cfg.username}/.cache ] || [ "$(readlink /home/${cfg.username}/.cache)" != "$CACHE_PATH" ]; then
          ln -sfn "$CACHE_PATH" /home/${cfg.username}/.cache
        fi
      '
    '';
  };
}
