{ pkgs, ... }:
{
  # Login
  services.displayManager.ly.enable = true;

  # Gnome
  services.desktopManager.gnome.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [

    # Gnome
    gnome-tweaks
    gnomeExtensions.forge
    gnomeExtensions.dynamic-panel
    gnomeExtensions.tweaks-in-system-menu
    gnomeExtensions.thinkpad-battery-threshold

    # Hyprland
    hyprpanel
    fuzzel
    swaybg
  ];
}
