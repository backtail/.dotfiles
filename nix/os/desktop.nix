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
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring

    libgtop
    brightnessctl
    libnotify
    wireplumber
    bluez
    bluez-tools
    swww

    # GTK apps
    loupe # Image viwer
    papers # PDF viewer
    font-manager
    gnome-disk-utility
    sushi
    polkit_gnome
    file-roller
    decibels

    # GTK icons & themes
    adwaita-icon-theme
  ];

  services.blueman.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

}
