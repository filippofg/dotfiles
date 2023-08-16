#!/usr/bin/env bash

set -e
set -u
set -o pipefail

#
# setup.sh
#

THIS_FOLDER=$(dirname $0)

print_usage() 
{
    echo -e "Usage:\t$0 username"
    echo -e ""
    echo -e "Remember to edit the script with correct distro-dependent settings!"
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         print_usage
         exit
	 ;;
   esac
done

CONFIG_DIR=$THIS_FOLDER/config

#
# Copy configuration files
#
sudo cp $CONFIG_DIR/etc/* /etc -r
cp $CONFIG_DIR/.config $HOME -r
cp $CONFIG_DIR/{.zsh,.zshrc,.p10k.zsh,.start-page} $HOME -r

#
# Install packages
#
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
    "unzip"
    "zip"
    "rsync"
    "tree"
)

sudo apt install -y ${PACKAGES[*]}

#
# ZSH config
#
# oh-my-zsh
if curl -fsLO https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
then
    sed -i 's/exec zsh -l/#exec zsh -l/g' ./install.sh
    sh ./install.sh
    rm ./install.sh
fi

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chsh -s /bin/zsh

