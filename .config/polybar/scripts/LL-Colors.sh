#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " µ's| Birb| Eli| Honk| Maki| Nico| Nozomi| Pana| Rin| Umi| Birb-dark| Eli-dark| Honk-dark| Maki-dark| Nico-dark| Nozomi-dark| Pana-dark| Rin-dark| Umi-dark")"
            case "$MENU" in
				## Light Colors
				*µ\'s) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Us.png -l -b colorz -a 1;;
				*Birb) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Birb-light.png -l -b colorz -a 2;;
				*Eli) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Eli-light.png -l -b wal ;;
				*Honk) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Honk-light.png -l -b colorz -a 2 ;;
				*Maki) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Maki-light.png -l -b colorz -a 3 ;;
				*Nico) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nico-light.png -l -b wal -a 2;;
				*Nozomi) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nozo-light.png -l -b colorz -a 4 ;;
				*Pana) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Pana-light.png -l -b colorz -a 4 ;;
				*Rin) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Rin-light.png -l -b wal -a 4 ;;
				*Umi) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Umi-light.png -l -b colorz -a 2 ;;
				## Dark Colors
				*Birb-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Birb-dark.png -b wal ;;
				*Eli-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Eli-dark.png -b wal -a 3 ;;
				*Honk-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Honk-dark.png -b wal -a 2 ;;
				*Maki-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Maki-dark.png -b colorz -f 120f18 -a 1 ;;
				*Nico-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nico-dark.png -b colorz -a 5 ;;
				*Nozomi-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nozo-dark.png -b wal ;;
				*Pana-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Pana-dark.png -b wal -a 4;;
				*Rin-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Rin-dark.png -b wal -a 2;;
				*Umi-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Umi-dark.png -b wal -a 2;;
            esac
