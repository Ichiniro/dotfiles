#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/colors.ini"
RFILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"

# Get colors
pywal_get() {
	wal -i "$1" -q -t -b 191919
}

# Change colors
change_color() {
	# polybar
	sed -i -e "s/background = #.*/background = $BG/g" $PFILE
	sed -i -e "s/background-alt = #.*/background-alt = $BGA/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = $FGA/g" $PFILE
	sed -i -e "s/primary = #.*/primary = $AC/g" $PFILE
	sed -i -e 's/red = #.*/red = #B71C1C/g' $PFILE
	sed -i -e 's/yellow = #.*/yellow = #F57F17/g' $PFILE

	# rofi
	cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:   #00000000;
	  bg:   ${BG}FF;
	  bga:  ${BGA}FF;
	  fga:  ${FGA}FF;
	  fg:   ${FG}FF;
	  ac:   ${AC}FF;
	}
	EOF
}

# Main
#if [[ -f "/usr/bin/wal" ]]; then
if [[ -f "/home/korewagian/.local/bin/wal" ]]; then
	if [[ "$1" ]]; then
		pywal_get "$1"

		# Source the pywal color file
		. "$HOME/.cache/wal/colors.sh"

		BG=`printf "%s\n" "$background"`
		FG=`printf "%s\n" "$background"`
		BGA=`printf "%s\n" "$color7"`
		FGA=`printf "%s\n" "$color7"`
		AC=`printf "%s\n" "$color1"`

		change_color
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
