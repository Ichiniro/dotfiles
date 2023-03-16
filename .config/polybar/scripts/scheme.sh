#!/usr/bin/env bash

# Color files
DDFILE="$HOME/.config/BetterDiscord/themes/Moddeka.theme.css"					# Discord file
FFILE="$HOME/.mozilla/firefox/fom8fblo.default-release/chrome/userChrome.css"	# Firefox file
GFILE="$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk.css"					# Gtk file - light mode
KFILE="$HOME/.config/kdeglobals"												# Kglobal file
LFILE="$HOME/.local/share/color-schemes/Lightly-Wal.colors"						# Lightly dark file
PFILE="$HOME/.config/polybar/colors.ini"										# Polybar file
RFILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"							# Rofi file
SFILE="$HOME/.config/spicetify/Themes/Ziro/color.ini"							# Spotify file
VFILE="$HOME/.config/Code - OSS/User/settings.json"								# VS Code file
ZFILE="$HOME/.config/zathura/zathurarc"											# Zathura file
ZSHFILE="$HOME/.zshrc"															# Zshrc file

# Convert HEX color to rgb
# hex_to_rgb: 1 param = converts HEX to rgb normally
#			 2 param = converts HEX to a darker version
#			 3 param = Converts HEX to and lighter version
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
			r=$((r - 8))
			g=$((g - 8))
			b=$((b - 8))
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

function rgb_to_hex {

	case "$2"
		in
		"normal")
			RGB=$1
		;;
		"light")
			RGB=$(hex_to_rgb "${NEW_GTKBG:1}" "2")
		;;
		"dark")
			RGB=$(hex_to_rgb "${NEW_GTKBG:1}" "2" "3")
		;;
	esac

	IFS=',' read -ra FINAL <<< "$RGB"

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
	if [[ "$2" ]]; then
		wal -i "$1" "$2" -q -t -n -e --backend $3 #--backend colorz
	else
		wal -i "$1" -q -t -n -e --backend $3 #--backend colorz
	fi
}

pywal_get_custom() {
	wal -i "$1" -t -n -e --backend "$3" -b "$4"

	if [[ "$2" ]]; then
		wal -i "$1" "$2" -t -n -e --backend $3 -b "$4"
	fi
}

pywal_steam() {
	#wal -i "$1" -q -t -n -e --backend "$2" -b 202022
	wal --theme $HOME/.config/polybar/color-scheme/colors.json -e -q -b 30302c
	wal_steam -w > /dev/null 2>&1
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
	sed -i -e "s/fg-act = #.*/fg-act = $FAC/g" $PFILE

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

	# Spotify [Ziro]
	sed -i -e "251 s/main =.*/main = $NH_Background/g" $SFILE
	sed -i -e "252 s/sidebar =.*/sidebar = $NH_Background/g" $SFILE
	sed -i -e "253 s/player =.*/player = $NH_Background/g" $SFILE
	sed -i -e "263 s/misc =.*/misc = $NH_Background/g" $SFILE

	sed -i -e "254 s/card =.*/card = ${WH_bg_alt:1}/g" $SFILE
	sed -i -e "255 s/shadow =.*/shadow = ${WH_bg_alt:1}/g" $SFILE
	sed -i -e "259 s/button-disabled =.*/button-disabled = ${WH_bg_alt:1}/g" $SFILE
	sed -i -e "261 s/notification =.*/notification = ${WH_bg_alt:1}/g" $SFILE

	sed -i -e "256 s/selected-row =.*/selected-row = $NH_accent_1/g" $SFILE
	sed -i -e "257 s/button =.*/button = $NH_accent_1/g" $SFILE
	sed -i -e "258 s/button-active =.*/button-active = $NH_accent_1/g" $SFILE
	sed -i -e "260 s/tab-active =.*/tab-active = $NH_accent_1/g" $SFILE

	sed -i -e "249 s/text =.*/text = $NH_Foreground/g" $SFILE
	sed -i -e "249 s/subtext =.*/subtext = $NH_Foreground/g" $SFILE

	# Discord
	sed -i -e "s/--accent:.*/--accent: $RGB_accent_1;/g" $DFILE
	sed -i -e "s/--background:.*/--background: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-alt:.*/--background-alt: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-light:.*/--background-light: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-dark:.*/--background-dark: $WH_Background;/g" $DFILE
	sed -i -e "s/--background-sidebar:.*/--background-sidebar: $WH_bg_alt;/g" $DFILE
	sed -i -e "s/--background-modifier-hover:.*/--background-modifier-hover: ${WH_accent_1}30;/g" $DFILE
	sed -i -e "s/--background-modifier-active:.*/--background-modifier-active: ${WH_accent_1}30;/g" $DFILE
	sed -i -e "s/--toolbar-background:.*/--toolbar-background: $WH_Background;/g" $DFILE
	sed -i -e "s/--base-border:.*/--base-border: $WH_Background;/g" $DFILE
	sed -i -e "s/--toolbar-border:.*/--toolbar-border: $WH_Background;/g" $DFILE
	sed -i -e "s/--text-normal:.*/--text-normal: $WH_Foreground;/g" $DFILE
	sed -i -e "s/--text-focus:.*/--text-focus: $WH_accent_1;/g" $DFILE
	#sed -i -e "s/--text-muted:.*/--text-muted: $WH_accent_2;/g" $DFILE
	sed -i -e "s/--sidebar-rgb:.*/--sidebar-rgb: $rgb_Background_alt;/g" $DFILE

	# Set the new kwin border color
	#sed -i -e "s/frame=.*/frame=$RGB_accent_1/g" $KFILE # Use RGB_accent_1 to put accent color
	#sed -i -e "s/inactiveFrame=.*/inactiveFrame=$rgb_Background_alt/g" $KFILE #Alternative

	sed -i -e "s/frame=.*/frame=${rgb_Background}205/g" $KFILE # Use rgb_background to no to use accent color
	sed -i -e "s/inactiveFrame=.*/inactiveFrame=${rgb_Background}205/g" $KFILE #Same color as window

	# In order to just have one border we need to set the title bar,
	# title foreground, etc in the same color as the background
	sed -i -e "s/activeBackground=.*/activeBackground=$rgb_Background/g" $KFILE
	sed -i -e "s/inactiveBackground=.*/inactiveBackground=$rgb_Background/g" $KFILE
	sed -i -e "s/activeBlend=.*/activeBlend=$rgb_Background/g" $KFILE
	sed -i -e "s/inactiveBlend=.*/inactiveBlend=$rgb_Background/g" $KFILE
	sed -i -e "s/activeForeground=.*/activeForeground=$rgb_Foreground/g" $KFILE
	sed -i -e "s/inactiveForeground=.*/inactiveForeground=$rgb_Foreground/g" $KFILE

	# Lightly colors
	sed -i -e "s/activeBackground=.*/activeBackground=$rgb_Background/g" $LFILE
	sed -i -e "s/activeForeground=.*/activeForeground=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveBackground=.*/inactiveBackground=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveBlend=.*/inactiveBlend=$rgb_Background/g" $LFILE
	sed -i -e "s/inactiveForeground=.*/inactiveForeground=$rgb_Background/g" $LFILE

	# Lightly background
	sed -i -e "s/BackgroundNormal=.*/BackgroundNormal=$rgb_Background/g" $LFILE
	sed -i -e "79 s/BackgroundNormal=.*/BackgroundNormal=${rgb_Background_alt},230/g" $LFILE
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
	# Change SVG fill colors
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi1.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi1X2.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi2.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi2X2.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi3.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbi3X2.svg
	sed -i -e "s/$OLD_DECOL/$WH_accent_1/g" $HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/assets/guanbiX2.svg

	sed -i -e "s/old_decolors=.*/old_decolors='$WH_accent_1'/g" $DECOLORS

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

	# Update colorscheme

	if [[ "$LIGHT" == "-l" ]]; then # Light mode
		SCHEME="$HOME/.config/polybar/color-scheme/colors.json"
	else # Dark mode
		SCHEME="$HOME/.config/polybar/color-scheme/colors-dark.json"
	fi

	sed -i -e "s/\"background\":.*/\"background\": \"$background\",/g" $SCHEME
	#sed -i -e "s/\"foreground\":.*/\"foreground\": \"$foreground\",/g" $SCHEME
	sed -i -e "s/\"color0\":.*/\"color0\": \"$background\",/g" $SCHEME
	sed -i -e "s/\"color1\":.*/\"color1\": \"$WH_accent_1\",/g" $SCHEME
	#sed -i -e "s/\"color7\":.*/\"color7\": \"$foreground\",/g" $SCHEME #8367C7
	sed -i -e "s/\"color9\":.*/\"color9\": \"$WH_accent_1\",/g" $SCHEME
	#sed -i -e "s/\"color15\":.*/\"color15\": \"$foreground\"/g" $SCHEME

	#VS Code?
	sed -i -e "s/\"variables\":.*/\"variables\": \"$WH_accent_1\",/g" "$VFILE"
	sed -i -e "s/\"statusBar.background\":.*/\"statusBar.background\": \"$WH_accent_1\",/g" "$VFILE"
	sed -i -e "s/\"statusBar.foreground\":.*/\"statusBar.foreground\": \"$WH_Background\",/g" "$VFILE"
	sed -i -e "s/\"statusBar.noFolderBackground\":.*/\"statusBar.noFolderBackground\": \"$WH_accent_1\",/g" "$VFILE"
	sed -i -e "s/\"statusBar.noFolderForeground\":.*/\"statusBar.noFolderForeground\": \"$WH_Background\",/g" "$VFILE"
}

# Main
if [[ -f "/usr/bin/wal" ]]; then

	BACKEND="wal"
	ACCENT=1
	CUSTOMBG=""
	CUSTOMAC=""

	while getopts n:a:i:b:c:f:l option
		do
		case "${option}"
			in
			n) ACCENT=${OPTARG};;
			i) SOURCE=${OPTARG};;
			b) BACKEND="${OPTARG}";;
			c) THEME="${OPTARG}";;
			f) CUSTOMBG="${OPTARG}";;
			a) CUSTOMAC="${OPTARG}";;
			l) LIGHT="-l";;
		esac
	done

	if [[ -n "$SOURCE" ]]; then

		if [[ -n $CUSTOMBG ]]; then
			#pywal_get "$SOURCE" "$LIGHT" "$BACKEND"
			pywal_get_custom "$SOURCE" "$LIGHT" "$BACKEND" "$CUSTOMBG"
		else
			pywal_get "$SOURCE" "$LIGHT" "$BACKEND"
		fi

		# Source the pywal color file
		. "$HOME/.cache/wal/colors.sh"

		# Source old gtk colors
		. "$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/decolors.sh"
		DECOLORS=$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/decolors.sh
		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			. "$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk-colors.sh"
		else # Dark mode
			# Gtk file - dark mode
			. "$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk-colors-dark.sh"
		fi

		# Get all color with Hash
		WH_Background=`printf "%s\n" "$background"`
		WH_Foreground=`printf "%s\n" "$foreground"`

		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			WH_Foreground="#505053"
			NH_Foreground="505053"
		else # Dark mode
			WH_Foreground="#e4e4e4"
			NH_Foreground="e4e4e4"
		fi

		# Get color with no hash
		NH_Background=`printf "%s\n" "${background:1}"`
		#NH_Foreground=`printf "%s\n" "${foreground:1}"`

		# On RGB, send colors with no hash
		rgb_Background=$(hex_to_rgb "$NH_Background")
		rgb_Foreground=$(hex_to_rgb "$NH_Foreground")

		# Case to change the accent color
		WH_accent_1=`printf "%s\n" "$color1"`
		WH_accent_2=`printf "%s\n" "$color6"`
		WH_accent_3=`printf "%s\n" "$color7"`

		NH_accent_1=`printf "%s\n" "${color1:1}"`
		NH_accent_2=`printf "%s\n" "${color6:1}"`
		NH_accent_3=`printf "%s\n" "${color7:1}"`

		RGB_accent_1=$(hex_to_rgb "${color1:1}")
		RGB_accent_2=$(hex_to_rgb "${color6:1}")
		RGB_accent_3=$(hex_to_rgb "${color7:1}")

		# Get old gtk colors
		OLD_GTKAC=`printf "%s\n" "$old_gtk_accent"`
		OLD_GTKBG=`printf "%s\n" "$old_gtk_background"`
		OLD_GTKBG_2=`printf "%s\n" "$old_gtk_secondary_background"`
		OLD_GTKBG_3=`printf "%s\n" "$old_gtk_third_background"`
		OLD_DECOL=`printf "%s\n" "$old_decolors"`

		if [[ -n $CUSTOMAC ]]; then
			WH_accent_1=\#$CUSTOMAC
			NH_accent_1=$CUSTOMAC
			RGB_accent_1=$(hex_to_rgb "$CUSTOMAC")
		else
			case "${ACCENT}"
				in
				2)
					WH_accent_1=`printf "%s\n" "$color2"`
					NH_accent_1=`printf "%s\n" "${color2:1}"`
					RGB_accent_1=$(hex_to_rgb "${color2:1}")
				;;
				3)
					WH_accent_1=`printf "%s\n" "$color3"`
					NH_accent_1=`printf "%s\n" "${color3:1}"`
					RGB_accent_1=$(hex_to_rgb "${color3:1}")
				;;
				4)
					WH_accent_1=`printf "%s\n" "$color4"`
					NH_accent_1=`printf "%s\n" "${color4:1}"`
					RGB_accent_1=$(hex_to_rgb "${color4:1}")
				;;
				5)
					WH_accent_1=`printf "%s\n" "$color5"`
					NH_accent_1=`printf "%s\n" "${color5:1}"`
					RGB_accent_1=$(hex_to_rgb "${color5:1}")
				;;
				6)
					WH_accent_1=`printf "%s\n" "$color6"`
					WH_accent_2=`printf "%s\n" "$color1"`
					NH_accent_1=`printf "%s\n" "${color6:1}"`
					NH_accent_2=`printf "%s\n" "${color1:1}"`
					RGB_accent_1=$(hex_to_rgb "${color6:1}")
					RGB_accent_2=$(hex_to_rgb "${color1:1}")
				;;
				7)
					WH_accent_1=`printf "%s\n" "$color7"`
					WH_accent_3=`printf "%s\n" "$color1"`
					NH_accent_1=`printf "%s\n" "${color7:1}"`
					NH_accent_3=`printf "%s\n" "${color1:1}"`
					RGB_accent_1=$(hex_to_rgb "${color7:1}")
					RGB_accent_3=$(hex_to_rgb "${color1:1}")
				;;
				8)
					WH_accent_1=`printf "%s\n" "$color8"`
					NH_accent_1=`printf "%s\n" "${color8:1}"`
					RGB_accent_1=$(hex_to_rgb "${color8:1}")
				;;
				9)
					WH_accent_1=`printf "%s\n" "$color9"`
					NH_accent_1=`printf "%s\n" "${color9:1}"`
					RGB_accent_1=$(hex_to_rgb "${color9:1}")
				;;
				10)
					WH_accent_1=`printf "%s\n" "$color10"`
					NH_accent_1=`printf "%s\n" "${color10:1}"`
					RGB_accent_1=$(hex_to_rgb "${color10:1}")
				;;
				11)
					WH_accent_1=`printf "%s\n" "$color11"`
					NH_accent_1=`printf "%s\n" "${color11:1}"`
					RGB_accent_1=$(hex_to_rgb "${color11:1}")
				;;
				12)
					WH_accent_1=`printf "%s\n" "$color12"`
					NH_accent_1=`printf "%s\n" "${color12:1}"`
					RGB_accent_1=$(hex_to_rgb "${color12:1}")
				;;
			esac
		fi

		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			OLD_GTK=$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk-colors.sh

			rgb_Background_alt=$(hex_to_rgb "${WH_Background:1}" "1" "2")
			WH_Background_alt_2=`printf "%s\n" "$old_gtk_background"`
			WH_Background_alt_3=`printf "%s\n" "$old_gtk_background"`

			BGA=`printf "%s\n" "$WH_accent_1"` # 7 if dark, 1 if light
			FGA=`printf "%s\n" "$WH_accent_1"`
			FAC=`printf "%s\n" "$color7"` # 1 if dark, 7 if light
			AC=`printf "%s\n" "$WH_accent_1"` # 1 if dark, 7 if light

			kwriteconfig5 --file lightlyrc --group Common --key ShadowStrength 26
            #plasma-apply-desktoptheme Fluent
		else # Dark mode
			GFILE="$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk-dark.css"
			OLD_GTK=$HOME/.themes/ABCDE-white-refined-duck/gtk-3.0/gtk-colors-dark.sh

			rgb_Background_alt=$(hex_to_rgb "${WH_Background:1}" "1")
			WH_Background_alt_2=$(rgb_to_hex "${NEW_GTKBG:1}" "light")
			WH_Background_alt_3=$(rgb_to_hex "${NEW_GTKBG:1}" "dark")

			BGA=`printf "%s\n" "$WH_accent_3"` # 7 if dark, 1 if light
			FGA=`printf "%s\n" "$WH_accent_3"`
			AC=`printf "%s\n" "$WH_accent_1"` # 1 if dark, 7 if light
			FAC=`printf "%s\n" "$WH_accent_1"` # 1 if dark, 7 if light

			kwriteconfig5 --file lightlyrc --group Common --key ShadowStrength 200
            #plasma-apply-desktoptheme spectrum-malice
		fi

		WH_bg_alt=$(rgb_to_hex "${rgb_Background_alt}" "normal")

		#qdbus org.kde.KWin /KWin reconfigure
		cp $DDFILE /tmp/Moddeka_tmp.css
		DFILE="/tmp/Moddeka_tmp.css"

		change_color

		cp $DFILE $DDFILE
		rm $DFILE

		# Reload Gtk theme on the fly uncomment until I can modify the theme
		dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Default'
		# Reload plasma color scheme
		plasma-apply-colorscheme BreezeLight > /dev/null 2>&1
		plasma-apply-colorscheme Lightly-Wal > /dev/null 2>&1

		dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:ABCDE-white-refined-duck'

		pywal_steam # Generate steam exclusive theme

		# execute wal once again to regenerate legible cs for vs code and konsole
		if [[ "$LIGHT" == "-l" ]]; then # Light mode
			wal --theme $HOME/.config/polybar/color-scheme/colors.json -e -q
		else # Dark mode
			wal --theme $HOME/.config/polybar/color-scheme/colors-dark.json -e -q
		fi

		#sh $HOME/.config/polybar/launch.sh

		plasma-apply-wallpaperimage $SOURCE
		touch -r $HOME/.cache/wal/colors $HOME/.config/BetterDiscord/themes/Moddeka.theme.css
		echo -e "[!] You may need to restart some programs to see the changes"

        #notify-send "Done"

	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
