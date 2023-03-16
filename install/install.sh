#!/usr/bin/env bash

# Installation script of my essential things

PCK_INST="yay -S"

function isInstalled {
	if pacman -Qi $1 > /dev/null ; then
		echo "$1 installed, skipping..."
	else
		PCK_INST="$PCK_INST $1"
	fi
}

function yes_or_no {
	while true; do
		read -p "$* [y/n]: " yn
		case $yn in
			[Yy]*) return 0  ;;  
			[Nn]*) echo "Aborted" ; return  1 ;;
		esac
	done
}

if [[ -f "/usr/bin/yay" ]]; then

	# check if everything is installed
	isInstalled "python-pywal"
	isInstalled "colorz"
	isInstalled "lightly"
	isInstalled "plasma5-applets-virtual-desktop-bar-git"
	isInstalled "polybar"
	isInstalled "rofi"
	isInstalled "zathura"
	isInstalled "vim"

	if [[ "$PCK_INST" == "yay -S" ]]; then
		echo "Everything is ready..."
	else
		eval $PCK_INST
	fi

	# clone dotfiles
	if [[ ! -d "$HOME/dotfiles" ]]; then
		git clone https://github.com/ichiniro/dotfiles.git
	fi

	# symlink dotfiles

	# Configure spotify & spicetify
	if [[ ! $(yes_or_no "Install spotify? ") ]]; then
		isInstalled "spotify"
	fi

	if [[ ! $(yes_or_no "Configure spicetify") ]]; then
		isInstalled "spicetify-cli"

		sudo chmod a+wr /opt/spotify
		sudo chmod a+wr /opt/spotify/Apps -R

		spicetify
		spicetify backup apply enable-devtool
		spicetify update

		spicetify config current_theme google-spicetify
		ln -s $HOME/dotfiles/spicetify/google-spicetify $HOME/.config/spicetify/Themes/google-spicetify
	fi

	if [[ ! $(yes_or_no "Install discord") ]]; then
		isInstalled "discord"
		# betterdiscord
	fi

	if [[ ! $(yes_or_no "Install steam") ]]; then
		isInstalled "steam"
		isInstalled "python-wal-steam-git"
	fi

	# install oh-my-zsh
	if [[ ! $(yes_or_no "Install zsh & oh-myz-sh") ]]; then
		isInstalled "zsh"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	if [[ ! $(yes_or_no "Install VS Code") ]]; then
		isInstalled "code"
		isInstalled "code-marketplace"
	fi

	# install vim-plug

	# Create a cs with to start doing shit

	# Link konsole-color-scheme
	ln -s $HOME/.cache/wal/colors-konsole.colorscheme $HOME/.local/share/konsole/colors-konsole.colorscheme

	# Copy BetterDiscord theme, BD doesn't support symlinks
	cp .config/BetterDiscord/Slate.theme.css $HOME/.config/BetterDiscord/themes/Slate.theme.css

	# Firefox theme must be symlinked manually due the profile name not being constant

else
	echo "Where yay 🐒"
fi