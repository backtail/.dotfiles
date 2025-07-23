{ pkgs, ... }:
{
  # Login Shell
  services.displayManager.cosmic-greeter.enable = true;

  # Gnome
  services.desktopManager.gnome.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Cosmic
  services.desktopManager.cosmic.xwayland.enable = true;
  services.desktopManager.cosmic.enable = true;

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
  ];
}
