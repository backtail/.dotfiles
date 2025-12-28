{ pkgs, ... }:
{
  # WM Wrapper for systemd
  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors.hyprland = {
  #     prettyName = "Hyprland";
  #     comment = "Hyprland compositor managed by UWSM";
  #     binPath = "/run/current-system/sw/bin/Hyprland";
  #   };
  # };

  # # Hyprland
  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true;
  #   xwayland.enable = true;
  # };

  programs.niri.enable = true;

  # use wayland for electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Packages
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
    
    # Hyprpanel Deps
    libgtop
    brightnessctl
    # gtksourceview
    # libsoup_3
    # ags
    wireplumber
    bluez
    bluez-tools
    # dart-sass
    # grimblast
    # matugen
    # pywal
    swww

    # Nautilus
    loupe # Image viwer
    papers # PDF viewer
    font-manager
    gnome-disk-utility

    # GTK icons & themes
    adwaita-icon-theme
  ];

  services.blueman.enable = true;

  # Hyprpanel Services
  services.gvfs.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
