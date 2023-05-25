#!/usr/bin/python3

# importing needed modules
import os,sys
import subprocess


# battery function definition--------------------------------------------------
# getting percentage and state of battery
percentage = subprocess.Popen("upower -i $(upower -e | grep -i \"battery\") | grep \"percentage\" | awk '{print $2}'", shell=True, stdout=subprocess.PIPE)
state = subprocess.Popen("upower -i $(upower -e | grep -i \"battery\") | grep \"state\" | awk '{print $2}'", shell=True, stdout=subprocess.PIPE)
percentage = percentage.communicate()[0].decode().strip()
state = state.communicate()[0].decode().strip()

# getting value of percentage
value = float(percentage.split('%')[0])

# fixing conditions
if value >= 6 and value < 21 and state == "discharging":
    print("%{F#ff0}"+percentage)
    os.system("brightnessctl s 9% > /dev/null")
elif value < 6 and state == "discharging":
    print("%{F#f00}"+percentage)
    os.system("notify-send -u \"critical\" \"Battery down to 5%\"")
    os.system("brightnessctl s 5% > /dev/null")
elif value < 6 and state == "charging":
    print("%{F#00f}"+percentage)
    os.system("dunstctl close-all")
    os.system("brightnessctl s 11% > /dev/null")
elif value < 100 and state == "charging":
    print("%{F#00f}"+percentage)
elif value == 100 and state != "discharging":
    print("%{F#0ff}"+percentage)
    os.system("notify-send -u \"normal\" \"Battery fully charged\"")
else:
    print("%{F#fff}"+percentage)
