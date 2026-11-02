{ pkgs, ... }:
{
  imports = [ ../../os/musnix.nix ];

  environment.systemPackages = with pkgs; [
    qpwgraph
    alsa-scarlett-gui
    reaper
    mixxx
  ];
}
