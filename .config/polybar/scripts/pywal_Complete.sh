#!/usr/bin/env bash

# Color files
DFILE="$HOME/.config/discord/Themes/gruvbox.css"                                # Discord file
FFILE="$HOME/.mozilla/firefox/5pqkp5gj.default-release/chrome/userChrome.css"   # Firefox file
KFILE="$HOME/.config/kdeglobals"                                                # Kglobal file
LFILE="$HOME/.local/share/color-schemes/Lightly-Wal.colors"                     # Lightly dark file
PFILE="$HOME/.config/polybar/colors.ini"                                        # Polybar file
RFILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"                          # Rofi file
SFILE="$HOME/.config/spicetify/Themes/google-spicetify/color.ini"               # Spotify file
#WFILE="$HOME/.config/kwinrc"                                                   # Kwinrc file
ZFILE="$HOME/.config/zathura/zathurarc"                                         # Zathura file

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
    echo "Wallpaper set!"
}

# Convert HEX color to rgb
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
            r=$((r - 12))
            g=$((g - 12))
            b=$((b - 12))
        else # Dark mode
            r=$((r + 24))
            g=$((g + 24))
            b=$((b + 24))
        fi
        final=$r","$g","$b
        echo $final
    else
        final=$r","$g","$b
        echo $final
    fi
}

# Get colors
pywal_get() {
	#wal -i "$1" -q -t -e -n  --backend colorz
    wal -i "$1" -q -t -n  #--backend colorz
    wal_steam -w

    if [[ "$2" ]]; then
        echo "Light"
        wal -i "$1" "$2" -q -t -n # --backend colorz
    #else
        #echo "Dark"
        #wal -i "$1" -q -t -n  #--backend colorz
    fi
}

# Change colors
change_color() {
	# polybar
    echo "Set polybar colors"
	sed -i -e "s/background = #.*/background = $BG/g" $PFILE
	sed -i -e "s/background-alt = #.*/background-alt = $BGA/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = $FGA/g" $PFILE
	sed -i -e "s/primary = #.*/primary = $AC/g" $PFILE
	sed -i -e 's/red = #.*/red = #B71C1C/g' $PFILE
	sed -i -e 's/yellow = #.*/yellow = #F57F17/g' $PFILE

	# rofi
    echo "Set rofi colors"
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

    # Spotify
    echo "Set Spotify colors"
    sed -i -e "s/main_fg = .*/main_fg = $SFG/g" $SFILE
    sed -i -e "s/secondary_fg = .*/secondary_fg = $SFGA/g" $SFILE
    sed -i -e "s/main_bg = .*/main_bg = $SBG/g" $SFILE
    sed -i -e "s/sidebar_and_player_bg = .*/sidebar_and_player_bg = $SBG/g" $SFILE
    sed -i -e "s/indicator_fg_and_button_bg = .*/indicator_fg_and_button_bg = $SBT/g" $SFILE
    sed -i -e "s/slider_bg = .*/slider_bg = $SSD/g" $SFILE
    sed -i -e "s/sidebar_indicator_and_hover_button_bg = .*/sidebar_indicator_and_hover_button_bg = $SSB/g" $SFILE
    sed -i -e "s/miscellaneous_bg = .*/miscellaneous_bg = $SHBB/g" $SFILE #HBB
    sed -i -e "s/miscellaneous_hover_bg = .*/miscellaneous_hover_bg = $SBG/g" $SFILE #HB
    sed -i -e "s/preserve_1 = .*/preserve_1 = $SPR/g" $SFILE

    # Firefox
    echo "Set firefox colors"
    sed -i -e "s/--light-color:.*/--light-color: $FFG;/g" $FFILE
    sed -i -e "s/--dark-color:.*/--dark-color: $FBG;/g" $FFILE
    sed -i -e "s/--accent-color:.*/--accent-color: $FAC;/g" $FFILE
    sed -i -e "s/--secondary-accent-color:.*/--secondary-accent-color: $FFG;/g" $FFILE
    sed -i -e "s/--third-accent-color:.*/--third-accent-color: $FFG;/g" $FFILE

    # Discord
    echo "Set Discord colors"
    sed -i -e "s/--bg1: #.*/--bg1: $BG;/g" $DFILE
    sed -i -e "s/--bg2: #.*/--bg2: $BG;/g" $DFILE
    sed -i -e "s/--bg3: #.*/--bg3: $COLDOS;/g" $DFILE
    sed -i -e "s/--fg1: #.*/--fg1: $FGB;/g" $DFILE
    sed -i -e "s/--fg2: #.*/--fg2: $COLDOS;/g" $DFILE
    sed -i -e "s/--accent3: #.*/--accent3: $COLONCE;/g" $DFILE

    # Set the new kwin border color
    echo "Set kwin border color"
    sed -i -e "s/frame=.*/frame=$KBC/g" $KFILE # Use KBC to put accent color
    sed -i -e "s/inactiveFrame=.*/inactiveFrame=$KBI/g" $KFILE
    # In order to just have one border we need to set the title bar,
    # title foreground, etc in the same color as the background
    sed -i -e "s/activeBackground=.*/activeBackground=$KBI/g" $KFILE
    sed -i -e "s/inactiveBackground=.*/inactiveBackground=$KBI/g" $KFILE
    sed -i -e "s/activeBlend=.*/activeBlend=$KBI/g" $KFILE
    sed -i -e "s/inactiveBlend=.*/inactiveBlend=$KBI/g" $KFILE
    sed -i -e "s/activeForeground=.*/activeForeground=$KBI/g" $KFILE
    sed -i -e "s/inactiveForeground=.*/inactiveForeground=$KBI/g" $KFILE

    # Lightly colors
    echo "Set Plasma color scheme"
    sed -i -e "s/activeBackground=.*/activeBackground=$LBG/g" $LFILE
    sed -i -e "s/activeForeground=.*/activeForeground=$LBG/g" $LFILE
    sed -i -e "s/inactiveBackground=.*/inactiveBackground=$LBG/g" $LFILE
    sed -i -e "s/inactiveBlend=.*/inactiveBlend=$LBG/g" $LFILE
    sed -i -e "s/inactiveForeground=.*/inactiveForeground=$LBG/g" $LFILE
    # Lightly background
    sed -i -e "s/BackgroundNormal=.*/BackgroundNormal=$LBG/g" $LFILE
    sed -i -e "64 s/BackgroundAlternate=.*/BackgroundAlternate=$LBG/g" $LFILE
    # Lightly foreground
    sed -i -e "s/ForegroundNormal=.*/ForegroundNormal=$LFG/g" $LFILE
    sed -i -e "45 s/ForegroundNormal=.*/ForegroundNormal=$LBG/g" $LFILE
    # Lightly accent
    sed -i -e "s/DecorationFocus=.*/DecorationFocus=$LAC/g" $LFILE
    sed -i -e "37 s/BackgroundNormal=.*/BackgroundNormal=$LAC/g" $LFILE
    # Lightly DecoHovers
    sed -i -e "67 s/DecorationHover=.*/DecorationHover=$LAC/g" $LFILE
    sed -i -e "25 s/DecorationHover=.*/DecorationHover=$LAC/g" $LFILE

    # Zathura colors
    echo "Set Zathura colors"
	sed -i -e "s/set default-bg \"#.*/set default-bg \"$BG\"/g" $ZFILE
	sed -i -e "s/set default-fg \"#.*/set default-fg \"$FGB\"/g" $ZFILE
	sed -i -e "s/set recolor-lightcolor \"#.*/set recolor-lightcolor \"$BG\"/g" $ZFILE
	sed -i -e "s/set recolor-darkcolor \"#.*/set recolor-darkcolor \"$FGB\"/g" $ZFILE
	sed -i -e "s/set statusbar-bg \"#.*/set statusbar-bg \"$COLDOS\"/g" $ZFILE
	sed -i -e "s/set statusbar-fg \"#.*/set statusbar-fg \"$FGB\"/g" $ZFILE
	sed -i -e "s/set inputbar-bg \"#.*/set inputbar-bg \"$COLDOS\"/g" $ZFILE
	sed -i -e "s/set inputbar-fg \"#.*/set inputbarbar-fg \"$FGB\"/g" $ZFILE
	sed -i -e "s/set index-bg \"#.*/set index-bg \"$BG\"/g" $ZFILE
	sed -i -e "s/set index-fg \"#.*/set index-fg \"$FGB\"/g" $ZFILE
	sed -i -e "s/set index-active-bg \"#.*/set index-active-bg \"$BG\"/g" $ZFILE
	sed -i -e "s/set index-active-fg \"#.*/set index-active-fg \"$FGB\"/g" $ZFILE
	sed -i -e "s/set highlight-color \"#.*/set highlight-color \"$COLCUATRO\"/g" $ZFILE
	sed -i -e "s/set highlight-active-color \"#.*/set highlight--activecolor \"$COLDOS\"/g" $ZFILE

    spicetify update

    echo "Colors updated!"
}

# Main
#if [[ -f "/usr/bin/wal" ]]; then
if [[ -f "$HOME/.local/bin/wal" ]]; then
	if [[ "$1" ]]; then

        # test start
        SOURCE="$HOME/Pictures/Wallpapers/83442302_p0_1.png"
        while getopts i: option
        do
            case "${option}"
                in
                i) SOURCE=${OPTARG};;
                #l) LIGHT="-l";;
            esac
        done

        for var in "$@"
        do
            if [[ "$var" == "-l" ]]; then
                LIGHT="-l"
            fi
        done

        pywal_get "$SOURCE" "$LIGHT"
        # test end

		# Source the pywal color file
        . "$HOME/.cache/wal/colors.sh"

        # Color to be used with hash
		BG=`printf "%s\n" "$background"` 
		FG=`printf "%s\n" "$background"` 
        FGB=`printf "%s\n" "$foreground"`
		BGA=`printf "%s\n" "$color7"` # 7 if dark, 1 if light
		FGA=`printf "%s\n" "$color7"`
		AC=`printf "%s\n" "$color2"` # 1 if dark, 7 if light

        if [[ "$LIGHT" == "-l" ]]; then
		    BGA=`printf "%s\n" "$color2"` # 7 if dark, 1 if light
		    FGA=`printf "%s\n" "$color2"`
		    AC=`printf "%s\n" "$color7"` # 1 if dark, 7 if light
        fi
        COLDOS=`printf "%s\n" "$color2"` 
        COLCUATRO=`printf "%s\n" "$color4"`
        COLONCE=`printf "%s\n" "$color11"`

        # Without hash
        BG_1=`printf "%s\n" "${background:1}"` # SBG ; FHEXBG ; FHEXAC ; KBHEX ; LHEXBG ; LHEXHV
        FG_1=`printf "%s\n" "${foreground:1}"` # FHEXFG ; FHEXACD ; FHEXACT ; LHEXFG
        COL2_1=`printf "%s\n" "${color2:1}"` # SFG ; SFGA ; SBT ; KHEX ; LHEXAC
        col7_1=`printf "%s\n" "${color7:1}"` # SSD ; SSB
        COL14_1=SHB=`printf "%s\n" "${color14:1}"` # SHB ;
        COL15_1=SHBB=`printf "%s\n" "${color15:1}"` # SPR ; SHBB ; 

        # On RGB
        BGrgb=$(hex_to_rgb "$BG_1")
        FGrgb=$(hex_to_rgb "$FG_1")



        # TODO: Optimize this shit later
        # Colors for spicetify
        SBG=`printf "%s\n" "${background:1}"`
        SFG=`printf "%s\n" "${color2:1}"`
        SFGA=`printf "%s\n" "${color2:1}"`
        SBT=`printf "%s\n" "${color2:1}"`
        SSD=`printf "%s\n" "${color7:1}"`
        SSB=`printf "%s\n" "${color7:1}"`
        SPR=`printf "%s\n" "${color15:1}"`
        SHB=`printf "%s\n" "${color14:1}"`
        SHBB=`printf "%s\n" "${color15:1}"`

        # Get firefox colors
        FHEXBG=`printf "%s\n" "${background:1}"` # Background
        FHEXFG=`printf "%s\n" "${foreground:1}"` # Foreground
        FHEXAC=`printf "%s\n" "${background:1}"` # Accent color
        FHEXACD=`printf "%s\n" "${foreground:1}"` # Second accent color
        FHEXACT=`printf "%s\n" "${foreground:1}"` # Third accent color
        # Convert them into rgb
        FBG=$(hex_to_rgb "$FHEXBG")
        FFG=$(hex_to_rgb "$FHEXFG")
        if [[ "$LIGHT" == "-l" ]]; then # Light mode
            FAC=$(hex_to_rgb "$FHEXAC" "1" "2")
        else # Dark mode
            FAC=$(hex_to_rgb "$FHEXAC" "1")
        fi

        # Color for the border kwin - whe need to convert to rgb first
        KHEX=`printf "%s\n" "${color2:1}"`
        KBHEX=`printf "%s\n" "${background:1}"`
        KBC=$(hex_to_rgb "$KHEX")
        KBI=$(hex_to_rgb "$KBHEX")

        # Change KDE color scheme colors (Lightly)
        # This needs to be converted to rgb too
        LHEXBG=`printf "%s\n" "${background:1}"`
        LHEXFG=`printf "%s\n" "${foreground:1}"`
        LHEXHV=`printf "%s\n" "${background:1}"`
        LHEXAC=`printf "%s\n" "${color2:1}"`
		# Color for the color scheme in rgb
        LBG=$(hex_to_rgb "$LHEXBG")
        LAC=$(hex_to_rgb "$LHEXAC")
        LFG=$(hex_to_rgb "$LHEXFG")

		change_color
        sh $HOME/.config/autostart-scripts/launch.sh
        set_wallpaper $SOURCE

        # Reload color scheme, manually until I find a workaround
        echo -e "[!] You may need to restart some programs to see the changes"
        echo -e "[!] Press Ctrl+Chift+r to reload the spotify theme"
        echo -e "[!] Reapply Lightly-Dark to load the colors without errors"
        kcmshell5 colors > /dev/null 2>&1
        # Reload Gtk theme on the fly uncomment until I can modify the theme
        dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Default'
        dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Bigsur-gtk'
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
