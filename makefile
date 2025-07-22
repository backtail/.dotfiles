all:
	stow --verbose --dotfiles --dir=files --target=$$HOME --restow ./

delete:
	stow --verbose --dotfiles --dir=files --target=$$HOME --delete ./
