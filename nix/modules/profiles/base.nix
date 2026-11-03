{ ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ../../shell/zsh.nix
    ../../shell/tools.nix
    ../../shell/development.nix
    ../../shell/helix.nix
    ../../shell/tui.nix
    ../../shell/nixos-cli.nix
    ../../os/user.nix
    ../../os/fonts.nix
    ../../os/security.nix
    ../../os/misc.nix
    ../../os/network.nix
  ];
}
