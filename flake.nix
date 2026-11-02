{
  description = "NixOS configurations for gax's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli = {
      url = "github:nix-community/nixos-cli/0.15.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mkHost =
        hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ hostModule ];
        };
    in
    {
      nixosConfigurations.x1-carbon = mkHost ./nix/hosts/x1-carbon;

      nixosModules = {
        base = import ./nix/modules/profiles/base.nix;
        workstation = import ./nix/modules/profiles/workstation.nix;
        engineering = import ./nix/modules/profiles/engineering.nix;
        audio-workstation = import ./nix/modules/profiles/audio-workstation.nix;
        laptop = import ./nix/modules/profiles/laptop.nix;
        server = import ./nix/modules/profiles/server.nix;
      };

      formatter.${system} = pkgs.nixfmt;

      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          gnumake
          nixfmt
          stow
          zsh
          niri
          noctalia
        ];
      };
    };
}
