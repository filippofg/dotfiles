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

if [ "$EUID" -ne 0 ]; then
    echo -e "Run as root"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    print_usage
    exit
fi

#
# Copy configuration files
#
USER_NAME=$1
USER_HOME=/home/$USER_NAME
USER_CONFIG_DIR=$USER_HOME/.config

cp $THIS_FOLDER/etc/* /etc -r

if [ ! -d $USER_CONFIG_DIR ]; then
    mkdir -p $USER_CONFIG_DIR
fi

cp $THIS_FOLDER/.config/* $USER_CONFIG_DIR -r

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

apt install -y ${PACKAGES[*]}


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

chsh -s /bin/zsh $USER_NAME
