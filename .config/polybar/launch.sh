#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Fix weird font
rm ~/.fonts/waffle.bdf
cp "$DIR"/font/waffle.bdf $HOME/.fonts/

# Rewrite the name of the gpu in the sensor just in case
MFILE="$HOME/.config/polybar/modules.ini"
TEST=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "amdgpu: edge")
TEST=$(echo $TEST | cut -c 14- | sed 's/\//\\\//g')
sed -i -e "1108 s/hwmon-path =.*/hwmon-path = $TEST/g" $MFILE
echo "hOLIES"

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
