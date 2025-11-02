{ config, system, pkgs, ...}:

let
  # In pure evaluation mode, always use a full Git commit hash instead of a branch name.
  nixos-cli-url = "https://github.com/nix-community/nixos-cli/archive/refs/tags/0.14.0.tar.gz";
  nixos-cli = import "${builtins.fetchTarball nixos-cli-url}" {inherit pkgs;};
in {
  imports = [
    nixos-cli.module
  ];

  services.nixos-cli = {
    enable = true;
    config = {
      # Other configuration for nixos-cli
    };
  };

  nix.settings = {
    substituters = [ "https://watersucks.cachix.org" ];
    trusted-public-keys = [
      "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
    ];
  };

  # ... rest of config
}
