#!/usr/bin/env bash

# Installation script for things I'll probably need

PCK_INST="yay -S"

function isInstalled {
	if pacman -Qi $1 > /dev/null ; then
		echo "$1 installed, skipping..."
	else
		PCK_INST="$PCK_INST $1"
	fi
}

if [[ -f "usr/bin/yay" ]]; then

	isInstalled "spotify"
	isInstalled "spicetify-cli"
	isInstalled "python-wal-steam-git"
	isInstalled "colorz"
	isInstalled "code"
	isInstalled "code-marketplace"
	isInstalled "plasma5-applets-virtual-desktop-bar-git"
	isInstalled "discord"
	isInstalled "vim"
	isInstalled "zathura"
	isInstalled "lightly"
	isInstalled "zsh"
	isInstalled "polybar"
	isInstalled "python-pywal"
	isInstalled "rofi"
	isInstalled "wine"

	if [[ "$PCK_INST" == "yay -S" ]]; then
		echo "Everything is ready..."
	else
		eval $PCK_INST
	fi
else
	echo "Where yay 🐒"
fi