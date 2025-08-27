{ pkgs, ... }:
{
  # WM Wrapper for systemd
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {      
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # Hyprland
    hyprpanel
    hyprlock
    hypridle
    fuzzel

    # Hyprpanel Deps
    brightnessctl
    wireplumber
    bluez-tools
    dart-sass
    grimblast
    matugen
    pywal
    swww
  ];

  # Hyprpanel Services
  services.gvfs.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
