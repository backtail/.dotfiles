{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Terminal
    blackbox-terminal

    # Filemanager
    nautilus

    # Apps
    kicad
    thunderbird
    drawio
    inkscape-with-extensions
    spotify
    freecad
    obsidian
    discord
    telegram-desktop
    bottles

    # Audio
    qjackctl
    alsa-scarlett-gui
    reaper
    mixxx
  ];
}
