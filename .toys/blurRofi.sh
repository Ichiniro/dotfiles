#!/bin/bash

# Wrapper to run rofi with blurred background. Linked to Meta + Space

rofi -location 0 -show drun &
c=0
echo "set c"

while ! xdotool search -class 'rofi' ; do
	echo "looping"
	sleep 0.1
	c=$((c+1))
	if [ $c == 50 ] ; then
		exit
	fi
done
class=$(xdotool search -class 'rofi')
#xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $class
xprop -set _KDE_NET_WM_SHADOW=50,50,50,50 -id $class
