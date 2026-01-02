{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

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
    qpwgraph
    alsa-scarlett-gui
    reaper
    mixxx
  ];
}
