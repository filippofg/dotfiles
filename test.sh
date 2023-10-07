#!/bin/bash
BASE_FONT_URL=https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20
FONT_STYLES=("Regular" "Bold" "Italic" "Bold%20Italic")
for i in ${FONT_STYLES[*]}; do
	curl -fsL "$BASE_FONT_URL$i.ttf" -o "MesloLGS-NF-$i.ttf"
	echo $i
done


