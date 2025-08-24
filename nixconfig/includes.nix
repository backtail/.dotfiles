{ pkgs, ... }:
{
  imports = [
    ./shell/zsh.nix
    ./shell/tools.nix
    ./shell/development.nix
    ./os/user.nix
    ./os/desktop.nix
    ./os/sound.nix
    ./os/fonts.nix
    ./os/apps.nix
    ./os/udev.nix
    ./os/security.nix
    ./os/misc.nix
    ./os/backup.nix
    ./os/vpn.nix
  ];
}
