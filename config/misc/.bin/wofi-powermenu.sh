#!/bin/bash

entries="⇠ Logout\n⏾ Suspend\n❆ Hybernate\n⭮ Reboot\n⏻ Shutdown"

selected=$(echo -e $entries|wofi --width 300 --height 250 --dmenu --prompt Power --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
    logout)
        hyprctl dispatch exit 1;;
    suspend)
        exec systemctl suspend;;
    hybernate)
        exec systemctl hybernate;;
    reboot)
        exec systemctl reboot;;
    shutdown)
        exec systemctl poweroff -i;;
esac
