#!/usr/bin/env bash

#SESSSION=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
#if [[ $SESSSION -eq "wayland" ]]; then
#    rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/scripts/rofi/launcher.rasi
#else
#    rofi -no-config -no-lazy-grab -show drun -modi window -theme ~/.config/polybar/scripts/rofi/launcher.rasi
#fi

# Xorg
rofi -no-config -no-lazy-grab -show drun -modi window  -theme ~/.config/polybar/scripts/rofi/launcher.rasi

# Wayland
#rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/scripts/rofi/launcher.rasi
