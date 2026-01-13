{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

    # Apps
    thunderbird
    ltspice
    drawio
    inkscape-with-extensions
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
