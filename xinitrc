#!/bin/sh
numlockx
exec i3
xset s off
xset -dpms
xset s noblank
xset -dpms s off		# prevents screen to turn off
