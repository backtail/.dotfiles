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

GTK 3 and GTK 4 settings are tracked, including `DejaVu Sans 11` for interface
text. `make home` also applies that font to the desktop's GSettings database
using `home/scripts/apply-desktop-font`. Run it as your normal user from a
desktop session with `gsettings` available. Fully quit and reopen VS Code
after changing the interface font; editor and terminal fonts are separate.

On first deployment, existing regular GTK `settings.ini` files can conflict
with Stow. Run `make home-check`, compare those files with the tracked copies,
and back up conflicting files before restowing. Do not use `stow --adopt`
blindly: it would replace the tracked settings with machine-local contents.

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

## Deployment

`make check` validates Zsh startup files, the desktop-font helper's shell syntax,
the shared Niri config and each host display fragment, the tracked Noctalia
configuration, and the Nix flake. Run it in `nix develop` to use pinned validators.
The shared Niri config may warn about its optional host include on machines
where the system configuration has not yet been deployed; host fragments are
also validated individually.

Deploy from the permanent `~/.files` checkout. Stow links point back into that
checkout, so do not deploy home files from a temporary worktree.

```sh
cd ~/.files
git pull --ff-only
nix develop
make home-check
make deploy HOST=x1-carbon
```

`make deploy` previews Stow, checks the flake, builds the system, switches it,
then restows home files and applies the desktop font. These steps run in order
even with parallel make. Deployment is not atomic: if a step fails, fix it
and rerun the remaining steps.

- Home-only changes: `make home` (no NixOS rebuild).
- System-only changes: `make build` then `make switch`.
- Changes spanning both, such as a Noctalia major upgrade: `make deploy`.

`nixos-rebuild switch` does not deploy `home/`. Updating an already linked file
can take effect immediately, but new files still require restowing. Niri's
startup commands run on session startup; log out and back in after changing
them. Reboot after a kernel update; that also starts a fresh desktop session.

On the second laptop use the same home deployment. Full system deployment with
`HOST=thinkpad-x1c6` requires completing its flake host and hardware module
first; currently only its Niri display fragment is tracked.
