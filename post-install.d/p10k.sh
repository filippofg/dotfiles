#!/usr/bin/env bash

TMP_DIR="fonts"
DESTINATION_DIR="$HOME/.local/share/fonts"
FONTS=(
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

mkdir $TMP_DIR
cd $TMP_DIR

for font in ${FONTS[*]}; do
    wget "$font"
done

mkdir "$DESTINATION_DIR"
mv ./*.ttf "$DESTINATION_DIR"

fc-cache -f -v

cd ..
rm -r font_tmp
