{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/base.nix
    ../../modules/profiles/workstation.nix
    ../../modules/profiles/engineering.nix
    ../../modules/profiles/audio-workstation.nix
    ../../modules/profiles/laptop.nix
  ];

  networking.hostName = "x1-carbon";
  services.openssh.enable = true;

  environment.etc."niri/host.kdl".source = ./niri.kdl;

  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-driver
    ];
  };

  services.udev.extraRules = ''
    KERNEL=="midisport", ATTRS{idVendor}=="0763", ATTRS{idProduct}=="1020", MODE="0666", GROUP="users"
  '';

  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/home/gax/backup-vault" = {
    device = "//backupvault/gax_backup";
    fsType = "cifs";
    options = [
      "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"
    ];
  };

  system.stateVersion = "25.05";
}
