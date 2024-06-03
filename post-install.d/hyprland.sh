#!/bin/bash

hyprpm update -v
yes | hyprpm add https://github.com/outfoxxed/hy3
hyprpm enable hy3
