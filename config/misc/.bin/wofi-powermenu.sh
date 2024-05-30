#!/bin/bash

THIS_FOLDER=$(dirname $0)

ENTRIES="⇠ Logout\n⏾ Suspend\n❆ Hibernate\n⭮ Reboot\n⏻ Shutdown"
SELECTED=$(echo -e $ENTRIES | wofi --width 300 --height 250 --dmenu --prompt Power --insensitive --cache-file /dev/null | awk '{print tolower($2)}')

case $SELECTED in
    "logout")
        hyprctl dispatch exit 1
        ;;
    "suspend")
        "$THIS_FOLDER"/suspend.sh
        ;;
    "hibernate")
        systemctl hibernate
        ;;
    "reboot")
        systemctl reboot
        ;;
    "shutdown")
        systemctl poweroff -i
        ;;
esac
