#!/bin/sh
numlockx
xset s off
xset -dpms
xset s noblank
xset -dpms s off		# prevents screen to turn off
exec i3
