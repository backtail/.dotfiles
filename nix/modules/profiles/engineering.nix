{ pkgs, ... }:
{
  imports = [
    ../../os/kicad.nix
    ../../os/udev.nix
  ];

  users.groups.plugdev = { };
  users.users.gax.extraGroups = [ "plugdev" ];

  environment.systemPackages = with pkgs; [
    ltspice
    drawio
    inkscape-with-extensions
    freecad
  ];
}
