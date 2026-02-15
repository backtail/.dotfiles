{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    # Niri
    noctalia-shell
    swaybg
    pavucontrol
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
    nautilus
    loupe
    papers
    font-manager
    gnome-disk-utility
    sushi
    polkit_gnome
    file-roller
    decibels

    # GTK icons & themes
    adwaita-icon-theme
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.upower.enable = true;

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
