{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pop-gtk-theme
    nwg-look
  ];
}

