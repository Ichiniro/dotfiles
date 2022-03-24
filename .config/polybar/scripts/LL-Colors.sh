#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " µ's| Birb| Eli| Honk| Maki| Nico| Nozomi| Pana| Rin| Umi| Birb-dark| Eli-dark| Honk-dark| Maki-dark| Nico-dark| Nozomi-dark| Pana-dark| Rin-dark| Umi-dark")"
            case "$MENU" in
				## Light Colors
				*µ\'s) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Us.png -l -b colorz -n 1;;
				*Birb) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Birb-light.png -l -b colorz -n 2;;
				*Eli) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Eli-light.png -l -b wal ;;
				*Honk) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Honk-light.png -l -b colorz -n 2 ;;
				*Maki) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Maki-light.png -l -b colorz -n 5 ;;
				*Nico) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Nico-light.png -l -b wal -n 2 ;;
				*Nozomi) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Nozo-light.png -l -b colorz -n 4 ;;
				*Pana) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Pana-light.png -l -b colorz -n 4 ;;
				*Rin) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Rin-light.png -l -b wal -n 4 ;;
				*Umi) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Umi-light.png -l -b colorz -n 2 ;;
				## Dark Colors
				*Birb-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Birb-dark.png -b wal ;;
				*Eli-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Eli-dark.png -b wal -n 3 ;;
				*Honk-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Honk-dark.png -b wal -n 2 ;;
				*Maki-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Maki-dark.png -b colorz -f 120f18 -n 1 ;;
				*Nico-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Nico-dark.png -b colorz -n 5 ;;
				*Nozomi-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Nozo-dark.png -b wal ;;
				*Pana-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Pana-dark.png -b wal -n 4;;
				*Rin-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Rin-dark.png -b wal -n 2;;
				*Umi-dark) "$SDIR"/scheme.sh -i $HOME/Pictures/LoveLive/Umi-dark.png -b wal -n 2;;
            esac
