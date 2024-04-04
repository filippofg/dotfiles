#!/usr/bin/env bash

if curl -fsLO https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh; then
    chmod +x ./install.sh
    ./install.sh --unattended --keep-zshrc
    rm ./install.sh
fi

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# mcfly
if curl -fsLO https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh; then
    chmod +x ./install.sh
    sudo ./install.sh --git cantino/mcfly
    rm ./install.sh
fi
