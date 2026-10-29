{ ... }:
{
  # Compatibility entry point for the existing /etc/nixos/configuration.nix.
  # New deployments use the host selected from the repository flake.
  imports = [
    ./modules/profiles/base.nix
    ./modules/profiles/workstation.nix
    ./modules/profiles/laptop.nix
  ];
}
