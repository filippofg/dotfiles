#!/usr/bin/env bash

command -v hyprpm >/dev/null 2>&1 || exit 0

hyprpm update -v
yes | hyprpm add https://github.com/outfoxxed/hy3
hyprpm enable hy3
