#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Maki| Maki-dark| Umi| Umi-dark")"
            case "$MENU" in
				## Light Colors
				*Maki) "$SDIR"/pywal_Complete.sh -i $HOME/Pictures/Wallpapers/Maki-Light.png -l ;;
				*Umi) "$SDIR"/pywal_Complete.sh -i $HOME/Pictures/Wallpapers/Umi-Light.png -l ;;
				## Dark Colors
				*Maki-dark) "$SDIR"/pywal_Complete.sh -i $HOME/Pictures/Wallpapers/Maki-dark.png ;;
				*Umi-dark) "$SDIR"/pywal_Complete.sh -i $HOME/Pictures/Wallpapers/Umi-dark.png ;;
            esac
