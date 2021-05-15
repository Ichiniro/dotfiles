#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Birb| Eli| Honk| Maki| Nico| Nozomi| Pana| Rin| Umi| Birb-dark| Eli-dark| Honk-dark| Maki-dark| Nico-dark| Nozomi-dark| Pana-dark| Rin-dark| Umi-dark")"
            case "$MENU" in
				## Light Colors
				*Birb) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Birb-light.png -l -b colorz ;;
				*Eli) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Eli-light.png -l -b wal ;;
				*Honk) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Honk-light.png -l -b colorz ;;
				*Maki) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Maki-light.png -l -b colorz ;;
				*Nico) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nico-light.png -l -b wal ;;
				*Nozomi) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nozo-light.png -l -b colorz ;;
				*Pana) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Pana-light.png -l -b colorz ;;
				*Rin) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Rin-light.png -l -b colorz ;;
				*Umi) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Umi-light.png -l -b colorz ;;
				## Dark Colors
				*Birb-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Birb-dark.png -b colorz ;;
				*Eli-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Eli-dark.png -b haishoku ;;
				*Honk-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Honk-dark.png -b wal ;;
				*Maki-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Maki-dark.png -b wal ;;
				*Nico-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nico-dark.png -b wal ;;
				*Nozomi-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Nozo-dark.png -b wal ;;
				*Pana-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Pana-dark.png -b wal ;;
				*Rin-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Rin-dark.png -b wal ;;
				*Umi-dark) "$SDIR"/rice.sh -i $HOME/Pictures/Wallpapers/LoveLive/Umi-dark.png -b wal ;;
            esac
