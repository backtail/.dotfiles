{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kopia-ui
  ];

  services.syncthing = {
    enable = true;
    extraFlags = [ "--no-default-folder" ];
  };

  users.users.syncthing.extraGroups = [ "users" ];
  users.users.gax.extraGroups = [ "syncthing" ];
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  systemd.tmpfiles.rules = [
    "d /home/gax 0750 gax syncthing"
  ];
}
