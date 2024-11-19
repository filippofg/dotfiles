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
POST_INSTALL_SCRIPTS_DIR=$THIS_FOLDER/post-install.d

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
BASE_PACKAGES=(
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
        "fzf"
)
APP_PACKAGES=(
        "firefox"
        "steam"
        "bitwarden"
        "telegram-desktop"
        "mullvad-vpn-bin"
        "megasync-bin"
        "filezilla"
        "armcord-bin"
        "vlc"
)
WAYLAND_PACKAGES=(
	"hyprland"
        "hyprwayland-scanner"
	"hyprpaper"
	"swaylock-effects"
        "swaybg"
	"waybar"
	"wl-clipboard"
        "cliphist"
	"bemenu"
	"bemenu-wayland"
	"mako"
	"grim"
	"slurp"
	"swappy"
	"alacritty"
	"brightnessctl"
        "nwg-look"
        "azote"
        "gammastep"
)

yay -Syu --noconfirm ${BASE_PACKAGES[*]} ${APP_PACKAGES[*]} ${WAYLAND_PACKAGES[*]}

#
# Package configs
#
for script in "$POST_INSTALL_SCRIPTS_DIR"/*.sh; do
	echo "--- Post-install script $script ---"
	chmod +x "$script"
	if ! ./"$script"; then
		echo -e "[ERROR] $script returned $? ---\n"
	else
		echo -e "[SUCCESS] $script\n"
	fi
done
