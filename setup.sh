#!/usr/bin/env bash

set -e
set -u
set -o pipefail

#
# setup.sh
#

function link-config-dir() {
	SOURCE=$1
	DESTINATION=$2
	echo "Linking $SOURCE configs"
	
	shopt -s dotglob # set dotglob to match hidden files
	
	for file in "$SOURCE"/*; do
		if ! ln -s "$(realpath $file)" "$DESTINATION" > /dev/null 2>&1; then
			echo "Skipping $file"
		fi
	done
	
	shopt -u dotglob # unset dotglob
}

THIS_FOLDER="$(dirname $0)"
SOURCE_CONFIG_DIR=$THIS_FOLDER/config
DESTINATION_CONFIG_DIR=$HOME/.config

#
# Copy configuration files
#

# shell
link-config-dir "$SOURCE_CONFIG_DIR/shell" "$HOME"
# tmux
link-config-dir "$SOURCE_CONFIG_DIR/tmux" "$DESTINATION_CONFIG_DIR"
# session
link-config-dir "$SOURCE_CONFIG_DIR/session" "$DESTINATION_CONFIG_DIR"
# editor
link-config-dir "$SOURCE_CONFIG_DIR/editor" "$DESTINATION_CONFIG_DIR"
# misc
link-config-dir "$SOURCE_CONFIG_DIR/misc" "$HOME"

# konsole profile
mkdir -p "$HOME/.local/share/konsole"
ln -s "$SOURCE_CONFIG_DIR/Personal.profile" "$HOME/.local/share/konsole"

#
# Install packages
#
PACKAGES=(
	"git"
	"curl"
	"make"
	"cmake"
	"htop"
	"tmux"
	"zsh"
	"vim"
	"neovim"
	"unzip"
	"zip"
	"rsync"
	"tree"
	"tldr"
	"s-tui"
	"stress"
)
# WAYLAND_PACKAGES=(
# 	"sway"
# 	"swayidle"
# 	"swaybg"
# 	"swayimg"
# 	"swaylock"
# 	"waybar"
# 	"wl-clipboard"
# 	"bemenu"
# 	"bemenu-wayland"
# 	"mako"
# 	"grim"
# 	"slurp"
# 	"swappy"
# 	"kitty"
# 	"gammastep"
# )

sudo pacman -Syu --noconfirm ${PACKAGES[*]} # ${WAYLAND_PACKAGES[*]}

#
# ZSH config
#
# oh-my-zsh
if curl -fsLO https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh; then
	sed -i 's/exec zsh -l/#exec zsh -l/g' ./install.sh
	sh ./install.sh
	rm ./install.sh
fi

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

#
# Package configs
#
tldr -u
