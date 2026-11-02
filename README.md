# gax dotfiles

This repository deliberately keeps user configuration and NixOS system
configuration separate:

- `home/` contains ordinary dotfiles deployed with GNU Stow.
- `nix/` contains shared NixOS modules and per-host compositions.
- `flake.nix` pins external inputs and exposes each complete machine by
  hostname.

## Home configuration

Zsh is a prerequisite. Enter the development shell, then restow the files into
the current user's home directory:

```sh
nix develop
make home
```

The files remain normal writable `.config` files linked to this checkout; Home
Manager is not used.

Noctalia v5 reads the curated configuration from
`home/.config/noctalia/config.toml`. Changes made through its settings UI are
stored separately in `~/.local/state/noctalia/settings.toml`; promote settings
that should be shared between machines into the tracked TOML file. Check the
result with:

```sh
noctalia config validate
noctalia config export merged
```

## NixOS configuration

Hosts import small combinations of shared profiles:

- `base`: user account, shell, CLI tools, development tools and common system
  settings.
- `workstation`: graphical desktop, audio, applications and workstation
  peripherals.
- `laptop`: power management and the tmpfs user cache.
- `server`: headless pinentry, Syncthing and Immich.

Build and activate the configuration matching the current hostname:

```sh
nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
sudo nixos-rebuild switch --flake ".#$(hostname)"
```

The Makefile provides the equivalent commands and accepts an explicit host:

```sh
make check
make build HOST=x1-carbon
make switch HOST=x1-carbon
```

`nix/includes.nix` remains as a compatibility entry point for the existing
legacy `/etc/nixos/configuration.nix`. New machines should use the flake host
layout documented in `nix/hosts/README.md`.
