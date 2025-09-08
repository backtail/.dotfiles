HOMECONFIG_DIR := homeconfig
NIXCONFIG_DIR := nixconfig

NIX_FILES := $(shell find $(NIXCONFIG_DIR) -name "*.nix" -type f)

.PHONY: all home nix fmt delete

fmt:
	@echo "Formatting .nix files in $(NIXCONFIG_DIR)..."
	@for file in $(NIX_FILES); do \
		nixfmt $$file; \
	done

home:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --restow ./

nix:
	sudo stow --verbose --dotfiles --dir=$(NIXCONFIG_DIR) --target=/etc/nixos/  --restow ./

all: home fmt nix

delete:
	stow --verbose --dotfiles --dir=$(HOMECONFIG_DIR) --target=$$HOME --delete ./
	sudo stow --verbose --dotfiles --dir=$(NIXCONFIG_DIR) --target=/etc/nixos/ --delete ./
