{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Apps
    firefox
    kicad
    thunderbird
    qjackctl
    drawio
    vlc
    inkscape-with-extensions
    spotify
    freecad
    obsidian
    discord
    telegram-desktop
    bottles

    # Audio
    alsa-scarlett-gui
    reaper
    mixxx
  ];
}
