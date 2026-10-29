HOMECONFIG_DIR := home
HOST ?= $(shell hostname)

NIX_FILES := $(shell find nix -name "*.nix" -type f) flake.nix shell.nix

.PHONY: all home nix fmt check build switch delete

fmt:
	@echo "Formatting Nix files..."
	@for file in $(NIX_FILES); do \
		nixfmt $$file; \
	done

home:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --restow ./

check:
	nix flake check --no-build

build:
	nix build ".#nixosConfigurations.$(HOST).config.system.build.toplevel"

switch:
	sudo nixos-rebuild switch --flake ".#$(HOST)"

nix: switch

all: home switch

delete:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --delete ./
