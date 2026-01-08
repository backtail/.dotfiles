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
    thunderbird
    ltspice
    drawio
    inkscape-with-extensions
    spotify
    freecad
    obsidian
    discord
    telegram-desktop

    # Audio
    qpwgraph
    alsa-scarlett-gui
    reaper
    mixxx
  ];
}
