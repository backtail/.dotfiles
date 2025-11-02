{ ... }:
{
  imports = [
    ./shell/zsh.nix
    ./shell/tools.nix
    ./shell/development.nix
    ./shell/helix.nix
    ./shell/tui.nix
    ./shell/nixos-cli.nix
    ./os/user.nix
    ./os/desktop.nix
    ./os/sound.nix
    ./os/fonts.nix
    ./os/apps.nix
    ./os/udev.nix
    ./os/security.nix
    ./os/misc.nix
    ./os/backup.nix
    ./os/network.nix
    ./os/printing.nix
  ];
}
