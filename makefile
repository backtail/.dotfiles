HOMECONFIG_DIR := home
HOST ?= $(shell hostname)
NIX := nix --extra-experimental-features 'nix-command flakes'

NIX_FILES := $(shell find nix -name "*.nix" -type f) flake.nix shell.nix

.PHONY: all home home-check desktop-font deploy nix fmt check build switch delete

home-check:
	stow --simulate --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --restow ./

fmt:
	@echo "Formatting Nix files..."
	@for file in $(NIX_FILES); do \
		nixfmt $$file; \
	done

home:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --restow ./
	$(MAKE) desktop-font

desktop-font:
	sh home/scripts/apply-desktop-font

check:
	zsh -n home/.zshrc
	zsh -n home/.zprofile
	sh -n home/scripts/apply-desktop-font
	sh -n home/scripts/niri-btop-toggle
	niri validate --config home/.config/niri/config.kdl
	@for config in nix/hosts/*/niri.kdl; do niri validate --config "$$config" || exit $$?; done
	noctalia config validate home/.config/noctalia/config.toml
	$(NIX) flake check --no-build

build:
	$(NIX) build ".#nixosConfigurations.$(HOST).config.system.build.toplevel"

switch:
	sudo nixos-rebuild switch --flake ".#$(HOST)"

nix: switch

deploy:
	$(MAKE) home-check
	$(MAKE) check
	$(MAKE) build
	$(MAKE) switch
	$(MAKE) home

all: deploy

delete:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --delete ./
