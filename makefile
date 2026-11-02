HOMECONFIG_DIR := home
HOST ?= $(shell hostname)

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
	nix flake check --no-build

build:
	nix build ".#nixosConfigurations.$(HOST).config.system.build.toplevel"

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
