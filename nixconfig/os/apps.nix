{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal
    cosmic-term

    # Filemanager
    nautilus

    # Apps
    firefox
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

    # GTK look UI
    nwg-look
  ];
}
