#!/usr/bin/zsh

# brightness control for i3
# developed by ramkumar

#######################################################################
# NOTE: for bash terminal, this script will not work and	      #
# throw errors like "invalid arithmetic operator ...". This is	      #
# due to the fact that the bash doent hande floating point operations #
# wheras zsh does.						      #
#######################################################################

# getting current device name
deviceName=`xrandr -q | grep ' connected' | head -n 1 | cut -d ' ' -f1`

# getting current brightness
curr_brightness=`xrandr --current --verbose | grep "Brightness" | cut -d" " -f2`

case $1 in
    increase)
	brightness=$((curr_brightness + 0.1))
	if [[ $brightness > 1.0 ]]
	then
	    brightness=1.0
	fi
	echo $brightness
	;;
    decrease)
	brightness=$((curr_brightness - 0.1))
	if [[ $brightness < 0.1 ]]
	then
	    brightness=0.1
	fi
	echo $brightness
	;;
    reset)
	brightness=0.7
esac

xrandr --output $deviceName --brightness $brightness
