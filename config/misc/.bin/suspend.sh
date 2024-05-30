#!/bin/bash

THIS_FOLDER=$(dirname $0)

playerctl pause
amixer set Master mute
"$THIS_FOLDER"/lockscreen.sh
systemctl suspend
