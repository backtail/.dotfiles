{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    # Niri
    waybar
    mako
    swaybg
    hyprlock
    hypridle
    fuzzel
    pavucontrol
    networkmanagerapplet
    waypaper

    libgtop
    brightnessctl
    wireplumber
    bluez
    bluez-tools
    swww

    # GTK apps
    loupe # Image viwer
    papers # PDF viewer
    font-manager
    gnome-disk-utility

    # GTK icons & themes
    adwaita-icon-theme
  ];

  services.blueman.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
