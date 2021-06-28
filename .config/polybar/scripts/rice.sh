#!/usr/bin/env bash

# Color files
DFILE="$HOME/.config/BetterDiscord/themes/Slate.theme.css"						# Discord file
FFILE="$HOME/.mozilla/firefox/t89kxbn9.default-release/chrome/userChrome.css"	# Firefox file
GFILE="$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk.css"								# Gtk file - light mode
KFILE="$HOME/.config/kdeglobals"												# Kglobal file
LFILE="$HOME/.local/share/color-schemes/Lightly-Wal.colors"						# Lightly dark file
PFILE="$HOME/.config/polybar/colors.ini"										# Polybar file
RFILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"							# Rofi file
SFILE="$HOME/.config/spicetify/Themes/google-spicetify/color.ini"				# Spotify file
ZFILE="$HOME/.config/zathura/zathurarc"											# Zathura file
ZSHFILE="$HOME/.zshrc"															# Zshrc file

function set_wallpaper {
	dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:

	var Desktops = desktops();
	for (i=0;i<Desktops.length;i++) {
			d = Desktops[i];
			d.wallpaperPlugin = "org.kde.image";
			d.currentConfigGroup = Array("Wallpaper",
										"org.kde.image",
										"General");
			d.writeConfig("Image", "file:'$1'");
	}'
	#echo "Wallpaper set!"
}

# Convert HEX color to rgb
# hex_to_rgb: 1 param = converts HEX to rgb normally
#			 2 param = converts HEX to a darker version
#			 3 param = Converts HEX to and enlighted version
function hex_to_rgb {
	hexinput=`echo $1 | tr '[:lower:]' '[:upper:]'`  # uppercase-ing
	a=`echo $hexinput | cut -c-2`
	b=`echo $hexinput | cut -c3-4`
	c=`echo $hexinput | cut -c5-6`

	r=`echo "ibase=16; $a" | bc`
	g=`echo "ibase=16; $b" | bc`
	b=`echo "ibase=16; $c" | bc`

	if [[ "$2" ]]; then
		if [[ "$3" ]]; then # Light mode
			#echo "Iluminar 3"
			r=$((r - 12))
			g=$((g - 12))
			b=$((b - 12))
			if [[ $r -lt 0 ]]; then
				r=0
			fi

			if [[ $g -lt 0 ]]; then
				g=0
			fi

			if [[ $b -lt 0 ]]; then
				b=0
			fi
		else # Dark mode
			#echo "Iluminar 2"
			r=$((r + 17))
			g=$((g + 17))
			b=$((b + 17))
			if [[ $r -gt 255 ]]; then
				r=255
			fi

			if [[ $g -gt 255 ]]; then
				g=255
			fi

			if [[ $b -gt 255 ]]; then
				b=255
			fi
		fi

		final=$r","$g","$b
		echo $final
	else # Sin argumentos entra aqui
		final=$r","$g","$b
		echo $final
	fi
}

# Convert RGB to HEX
# rgb_to_hex: 1 param: Endarks
#			 2 param: Enlights
function rgb_to_hex {
	if [[ "$2" ]]; then # Light mode
		#echo "Light"
		RGB=$(hex_to_rgb "${NEW_GTKBG:1}" "2")
	else # Dark mode
		#echo "Dark"
		RGB=$(hex_to_rgb "${NEW_GTKBG:1}" "2" "3")
	fi

	#echo $RGB

	IFS=',' read -ra FINAL <<< "$RGB"
	# Print the values
	#for i in "${FINAL[@]}"
	#do
	#	echo $i
	#done

	R=`echo "${FINAL[0]}" | xargs printf '%x\n' | tr '[:lower:]' '[:upper:]'`
	G=`echo "${FINAL[1]}" | xargs printf '%x\n' | tr '[:lower:]' '[:upper:]'`
	B=`echo "${FINAL[2]}" | xargs printf '%x\n' | tr '[:lower:]' '[:upper:]'`

	if [[ `echo $R | wc -c` < 3 ]]; then
		R="0$R"
	fi

	if [[ `echo $G | wc -c` < 3 ]]; then
		G="0$G"
	fi

	if [[ `echo $B | wc -c` < 3 ]]; then
		B="0$B"
	fi

	echo "#$R$G$B"
}

# Get colors
pywal_get() {
	wal -i "$1" -q -t -n -e --backend "$3"
	wal_steam -w > /dev/null 2>&1

	if [[ "$2" ]]; then
		wal -i "$1" "$2" -q -t -n -e --backend $3 #--backend colorz
	fi
}

# Get scheme
pywal_get_scheme() {
	wal --theme "$1" -q -t -n
	wal_steam -w > /dev/null 2>&1

	if [[ "$2" ]]; then
		wal --theme "$1" "$2" -q -t -n
	fi
}

pywal_get_custom() {
	wal -i "$1" -t -n -e --backend "$3" -b "$4"
	wal_steam -w > /dev/null 2>&1

	if [[ "$2" ]]; then
		wal -i "$1" "$2" -t -n -e --backend $3 -b "$4"
	fi
}

# Change colors
change_color() {
	# polybar
	sed -i -e "s/background = #.*/background = $WH_Background/g" $PFILE
	sed -i -e "s/background-alt = #.*/background-alt = $BGA/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $WH_Background/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = $FGA/g" $PFILE
	sed -i -e "s/primary = #.*/primary = $AC/g" $PFILE
	sed -i -e 's/red = #.*/red = #B71C1C/g' $PFILE
	sed -i -e 's/yellow = #.*/yellow = #F57F17/g' $PFILE

	# rofi
	cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:   #00000000;
	  bg:   ${WH_Background}FF;
	  bga:  ${BGA}FF;
	  fga:  ${FGA}FF;
	  fg:   ${WH_Background}FF;
	  ac:   ${AC}FF;
	}
	EOF

	# Spotify
	sed -i -e "s/main_fg = .*/main_fg = $NH_accent_1/g" $SFILE
	sed -i -e "s/secondary_fg = .*/secondary_fg = $NH_accent_1/g" $SFILE
	sed -i -e "s/main_bg = .*/main_bg = $NH_Background/g" $SFILE
	sed -i -e "s/sidebar_and_player_bg = .*/sidebar_and_player_bg = $NH_Background/g" $SFILE
	sed -i -e "s/indicator_fg_and_button_bg = .*/indicator_fg_and_button_bg = $NH_accent_1/g" $SFILE
	sed -i -e "s/slider_bg = .*/slider_bg = $NH_accent_3/g" $SFILE
	sed -i -e "s/sidebar_indicator_and_hover_button_bg = .*/sidebar_indicator_and_hover_button_bg = $NH_accent_3/g" $SFILE
	sed -i -e "s/miscellaneous_bg = .*/miscellaneous_bg = $NH_accent_3/g" $SFILE #HBB
	sed -i -e "s/miscellaneous_hover_bg = .*/miscellaneous_hover_bg = $NH_Background/g" $SFILE #HB
	sed -i -e "s/preserve_1 = .*/preserve_1 = $NH_accent_3/g" $SFILE

	# Firefox
	sed -i -e "s/--light-color:.*/--light-color: $rgb_Foreground;/g" $FFILE
	sed -i -e "s/--dark-color:.*/--dark-color: $rgb_Background;/g" $FFILE
	sed -i -e "s/--accent-color:.*/--accent-color: $rgb_Background_alt;/g" $FFILE
	sed -i -e "s/--secondary-accent-color:.*/--secondary-accent-color: $rgb_Foreground;/g" $FFILE
	sed -i -e "s/--third-accent-color:.*/--third-accent-color: $rgb_Foreground;/g" $FFILE

	# Discord
	sed -i -e "s/--accent:.*/--accent: $RGB_accent_1;/g" $DFILE
	sed -i -e "s/--background:.*/--background: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-alt:.*/--background-alt: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-light:.*/--background-light: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-dark:.*/--background-dark: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-modifier-hover:.*/--background-modifier-hover: ${WH_accent_1}30;/g" $DFILE
	sed -i -e "s/--background-modifier-active:.*/--background-modifier-active: ${WH_accent_1}30;/g" $DFILE
	sed -i -e "s/--toolbar-background:.*/--toolbar-background: $WH_Background;/g" $DFILE
	sed -i -e "s/--base-border:.*/--base-border: $WH_Background;/g" $DFILE
	sed -i -e "s/--toolbar-border:.*/--toolbar-border: $WH_Background;/g" $DFILE
	sed -i -e "s/--text-normal:.*/--text-normal: $WH_Foreground;/g" $DFILE
	sed -i -e "s/--text-focus:.*/--text-focus: $WH_accent_1;/g" $DFILE
	sed -i -e "s/--text-muted:.*/--text-muted: $WH_accent_2;/g" $DFILE

	# Set the new kwin border color
	sed -i -e "s/frame=.*/frame=$RGB_accent_1/g" $KFILE # Use RGB_accent_1 to put accent color
	#sed -i -e "s/frame=.*/frame=$rgb_Background/g" $KFILE # Use RGB_accent_1 to put accent color
	sed -i -e "s/inactiveFrame=.*/inactiveFrame=$rgb_Background/g" $KFILE #Same color as window
	#sed -i -e "s/inactiveFrame=.*/inactiveFrame=$NEW_GTKAA/g" $KFILE #Alternative

	# In order to just have one border we need to set the title bar,
	# title foreground, etc in the same color as the background
	sed -i -e "s/activeBackground=.*/activeBackground=$rgb_Background/g" $KFILE
	sed -i -e "s/inactiveBackground=.*/inactiveBackground=$rgb_Background/g" $KFILE
	sed -i -e "s/activeBlend=.*/activeBlend=$rgb_Background/g" $KFILE
	sed -i -e "s/inactiveBlend=.*/inactiveBlend=$rgb_Background/g" $KFILE
	sed -i -e "s/activeForeground=.*/activeForeground=$rgb_Background/g" $KFILE
	sed -i -e "s/inactiveForeground=.*/inactiveForeground=$rgb_Background/g" $KFILE

	# Lightly colors
	sed -i -e "s/activeBackground=.*/activeBackground=$rgb_Background/g" $LFILE
	sed -i -e "s/activeForeground=.*/activeForeground=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveBackground=.*/inactiveBackground=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveBlend=.*/inactiveBlend=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveForeground=.*/inactiveForeground=$rgb_Background/g" $LFILE
	# Lightly background
	sed -i -e "s/BackgroundNormal=.*/BackgroundNormal=$rgb_Background/g" $LFILE
	sed -i -e "64 s/BackgroundAlternate=.*/BackgroundAlternate=$rgb_Background/g" $LFILE
	# Lightly foreground
	sed -i -e "s/ForegroundNormal=.*/ForegroundNormal=$rgb_Foreground/g" $LFILE
	sed -i -e "45 s/ForegroundNormal=.*/ForegroundNormal=$rgb_Background/g" $LFILE
	# Lightly accent
	sed -i -e "s/DecorationFocus=.*/DecorationFocus=$RGB_accent_1/g" $LFILE
	sed -i -e "37 s/BackgroundNormal=.*/BackgroundNormal=$RGB_accent_1/g" $LFILE
	# Lightly DecoHovers
	sed -i -e "67 s/DecorationHover=.*/DecorationHover=$RGB_accent_1/g" $LFILE
	sed -i -e "25 s/DecorationHover=.*/DecorationHover=$RGB_accent_1/g" $LFILE
	# Lighlty button background
	sed -i -e "23 s/BackgroundNormal=.*/BackgroundNormal=$rgb_Background_alt/g" $LFILE

	# Change GTK colors
	sed -i -e "s/$OLD_GTKBG/$WH_Background/g" $GFILE
	sed -i -e "s/$OLD_GTKAC/$WH_accent_1/g" $GFILE
	sed -i -e "s/$OLD_GTKBG_2/$WH_Background_alt_2/g" $GFILE
	sed -i -e "s/$OLD_GTKBG_3/$WH_Background_alt_3/g" $GFILE
	# Save this colors to replace later
	sed -i -e "s/old_gtk_background=.*/old_gtk_background='$WH_Background'/g" $OLD_GTK
	sed -i -e "s/old_gtk_accent=.*/old_gtk_accent='$WH_accent_1'/g" $OLD_GTK
	sed -i -e "s/old_gtk_secondary_background=.*/old_gtk_secondary_background='$WH_Background_alt_2'/g" $OLD_GTK
	sed -i -e "s/old_gtk_third_background=.*/old_gtk_third_background='$WH_Background_alt_3'/g" $OLD_GTK

	# Zathura colors
	sed -i -e "s/set default-bg \"#.*/set default-bg \"$WH_Background\"/g" $ZFILE
	sed -i -e "s/set default-fg \"#.*/set default-fg \"$WH_Foreground\"/g" $ZFILE
	sed -i -e "s/set recolor-lightcolor \"#.*/set recolor-lightcolor \"$WH_Background\"/g" $ZFILE
	sed -i -e "s/set recolor-darkcolor \"#.*/set recolor-darkcolor \"$WH_Foreground\"/g" $ZFILE
	sed -i -e "s/set statusbar-bg \"#.*/set statusbar-bg \"$WH_accent_1\"/g" $ZFILE
	sed -i -e "s/set statusbar-fg \"#.*/set statusbar-fg \"$WH_Background\"/g" $ZFILE
	sed -i -e "s/set inputbar-bg \"#.*/set inputbar-bg \"$WH_accent_1\"/g" $ZFILE
	sed -i -e "s/set inputbar-fg \"#.*/set inputbarbar-fg \"$WH_Foreground\"/g" $ZFILE
	sed -i -e "s/set index-bg \"#.*/set index-bg \"$WH_Background\"/g" $ZFILE
	sed -i -e "s/set index-fg \"#.*/set index-fg \"$WH_Foreground\"/g" $ZFILE
	sed -i -e "s/set index-active-bg \"#.*/set index-active-bg \"$WH_Background\"/g" $ZFILE
	sed -i -e "s/set index-active-fg \"#.*/set index-active-fg \"$WH_Foreground\"/g" $ZFILE
	sed -i -e "s/set highlight-color \"#.*/set highlight-color \"$WH_accent_2\"/g" $ZFILE
	sed -i -e "s/set highlight-active-color \"#.*/set highlight--activecolor \"$WH_accent_1\"/g" $ZFILE

	# ZSH highlight colors
	sed -i -e "s/ZSH_HIGHLIGHT_STYLES\[alias\]=.*/ZSH_HIGHLIGHT_STYLES\[alias\]='fg=$WH_accent_1'/g" $ZSHFILE
	sed -i -e "s/ZSH_HIGHLIGHT_STYLES\[command\]=.*/ZSH_HIGHLIGHT_STYLES\[command\]='fg=$WH_accent_1'/g" $ZSHFILE
	sed -i -e "s/ZSH_HIGHLIGHT_STYLES\[builtin\]=.*/ZSH_HIGHLIGHT_STYLES\[builtin\]='fg=$WH_accent_1'/g" $ZSHFILE
	sed -i -e "s/ZSH_HIGHLIGHT_STYLES\[precommand\]=.*/ZSH_HIGHLIGHT_STYLES\[precommand\]='fg=$WH_accent_1'/g" $ZSHFILE
	sed -i -e "s/ZSH_HIGHLIGHT_STYLES\[unknown-token\]=.*/ZSH_HIGHLIGHT_STYLES\[unknown-token\]='fg=$WH_Foreground'/g" $ZSHFILE

}

# Main
if [[ -f "/usr/bin/wal" ]]; then
	BACKEND="wal"
	ACCENT=1
	CUSTOMBG=""
	while getopts a:i:b:c:f:l option
		do
		case "${option}"
			in
			a) ACCENT=${OPTARG};;
			i) SOURCE=${OPTARG};;
			b) BACKEND="${OPTARG}";;
			c) THEME="${OPTARG}";;
			f) CUSTOMBG="${OPTARG}";;
			l) LIGHT="-l";;
		esac
	done

	if [[ -n "$SOURCE" ]]||[[ -n "$THEME" ]]; then

		if [[ "$THEME" ]]; then
			pywal_get_scheme "$THEME" "$LIGHT"
		elif [[ -n $CUSTOMBG ]]; then #new
			pywal_get_custom "$SOURCE" "$LIGHT" "$BACKEND" "$CUSTOMBG" #new
		else
			pywal_get "$SOURCE" "$LIGHT" "$BACKEND"
		fi

		# Source the pywal color file
		. "$HOME/.cache/wal/colors.sh"

		# Source old gtk colors
		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			. "$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk-colors.sh"
		else # Dark mode
			# Gtk file - dark mode
			. "$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk-colors-dark.sh"
		fi

		#######################################################################

		# Get all color with Hash
		WH_Background=`printf "%s\n" "$background"`
		WH_Foreground=`printf "%s\n" "$foreground"`
		WH_color1=`printf "%s\n" "$color1"`
		WH_color2=`printf "%s\n" "$color2"`
		WH_color3=`printf "%s\n" "$color3"`
		WH_color4=`printf "%s\n" "$color4"`
		WH_color5=`printf "%s\n" "$color5"`
		WH_color6=`printf "%s\n" "$color6"`
		WH_color7=`printf "%s\n" "$color7"`
		WH_color8=`printf "%s\n" "$color8"`

		# Get color with no hash
		NH_Background=`printf "%s\n" "${background:1}"`
		NH_Foreground=`printf "%s\n" "${foreground:1}"`

		# On RGB, send colors with no hash
		rgb_Background=$(hex_to_rgb "$NH_Background")
		rgb_Foreground=$(hex_to_rgb "$NH_Foreground")
		rgb_color1=$(hex_to_rgb "${color1:1}")
		rgb_color2=$(hex_to_rgb "${color2:1}")
		rgb_color3=$(hex_to_rgb "${color3:1}")
		rgb_color4=$(hex_to_rgb "${color4:1}")
		rgb_color5=$(hex_to_rgb "${color5:1}")
		rgb_color6=$(hex_to_rgb "${color6:1}")
		rgb_color7=$(hex_to_rgb "${color7:1}")
		rgb_color8=$(hex_to_rgb "${color8:1}")

		#######################################################################

		# Case to change the accent color
		WH_accent_1=${WH_color1}
		WH_accent_2=${WH_color6}
		WH_accent_3=${WH_color7}

		NH_accent_1=${WH_color1:1}
		NH_accent_2=${WH_color6:1}
		NH_accent_3=${WH_color7:1}

		RGB_accent_1=${rgb_color1}
		RGB_accent_2=${rgb_color6}
		RGB_accent_3=${rgb_color7}

		# Get old gtk colors
		OLD_GTKAC=`printf "%s\n" "$old_gtk_accent"`
		OLD_GTKBG=`printf "%s\n" "$old_gtk_background"`
		OLD_GTKBG_2=`printf "%s\n" "$old_gtk_secondary_background"`
		OLD_GTKBG_3=`printf "%s\n" "$old_gtk_third_background"`

		case "${ACCENT}"
			in
			1)
				WH_accent_1=${WH_color1}
				NH_accent_1=${WH_color1:1}
				RGB_accent_1=${rgb_color1}
			;;
			2)
				WH_accent_1=${WH_color2}
				NH_accent_1=${WH_color2:1}
				RGB_accent_1=${rgb_color2}
			;;
			3)
				WH_accent_1=${WH_color3}
				NH_accent_1=${WH_color3:1}
				RGB_accent_1=${rgb_color3}
			;;
			4)
				WH_accent_1=${WH_color4}
				NH_accent_1=${WH_color4:1}
				RGB_accent_1=${rgb_color4}
			;;
			5)
				WH_accent_1=${WH_color5}
				NH_accent_1=${WH_color5:1}
				RGB_accent_1=${rgb_color5}
			;;
			6)
				WH_accent_1=${WH_color6}
				WH_accent_2=${WH_color1}
				NH_accent_1=${WH_color6:1}
				NH_accent_2=${WH_color1:1}
				RGB_accent_1=${rgb_color6}
				RGB_accent_2=${rgb_color1}
			;;
			7)
				WH_accent_1=${WH_color7}
				WH_accent_3=${WH_color1}
				NH_accent_1=${WH_color7:1}
				NH_accent_3=${WH_color1:1}
				RGB_accent_1=${rgb_color7}
				RGB_accent_3=${rgb_color1}
			;;
			8)
				WH_accent_1=${WH_color8}
				NH_accent_1=${WH_color8:1}
				RGB_accent_1=${rgb_color8}
			;;
		esac

		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			OLD_GTK=$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk-colors.sh

			rgb_Background_alt=$(hex_to_rgb "${WH_Background:1}" "1" "2")
			WH_Background_alt_2=`printf "%s\n" "$old_gtk_background"`
			WH_Background_alt_3=`printf "%s\n" "$old_gtk_background"`

			BGA=`printf "%s\n" "$WH_accent_1"` # 7 if dark, 1 if light
			FGA=`printf "%s\n" "$WH_accent_1"`
			AC=`printf "%s\n" "$color7"` # 1 if dark, 7 if light

			kwriteconfig5 --file lightlyrc --group Common --key ShadowStrength 35
			qdbus org.kde.KWin /KWin reconfigure
		else # Dark mode
			GFILE="$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk-dark.css"
			OLD_GTK=$HOME/.themes/Bigsur-gtk/gtk-3.0/gtk-colors-dark.sh

			rgb_Background_alt=$(hex_to_rgb "${WH_Background:1}" "1")
			WH_Background_alt_2=$(rgb_to_hex "${NEW_GTKBG:1}" "2")
			WH_Background_alt_3=$(rgb_to_hex "${NEW_GTKBG:1}")

			BGA=`printf "%s\n" "$WH_accent_3"` # 7 if dark, 1 if light
			FGA=`printf "%s\n" "$WH_accent_3"`
			AC=`printf "%s\n" "$WH_accent_1"` # 1 if dark, 7 if light

			kwriteconfig5 --file lightlyrc --group Common --key ShadowStrength 180
			qdbus org.kde.KWin /KWin reconfigure
		fi

		# Reload Gtk theme on the fly uncomment until I can modify the theme
		dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Default'
		change_color
		dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Bigsur-gtk'

		if [[ -n "$SOURCE" ]]; then
			set_wallpaper $SOURCE
		fi

		# Reload color scheme, manually until I find a workaround
		echo -e "[!] You may need to restart some programs to see the changes"
		echo -e "[!] Press Ctrl+Shift+r to reload the spotify theme"
		echo -e "[!] Reapply Lightly-wal to reload the colors without errors"

		kcmshell5 colors > /dev/null 2>&1
		sh $HOME/.config/autostart-scripts/launch.sh
		spicetify update > /dev/null 2>&1

	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
