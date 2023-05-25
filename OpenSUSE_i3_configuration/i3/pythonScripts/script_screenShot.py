#!/bin/python3
"""----------------------------------------------------------------------------
code to take screenshots
using "import" command from imagemagick
----------------------------------------------------------------------------"""

import subprocess,os
import sys

# getting argument to determine screenshot mode
mode = sys.argv[1]
print(mode)

# getting current datetime
out = subprocess.run(["date"], stdout=subprocess.PIPE)
datetime = out.stdout.decode().strip().replace(" ","_")

# preparing filename for screenshot
fname = "Screenshot_"+datetime+".png"

# preparing location
location = "~/Pictures/Screenshots/"
os.system("mkdir -p "+location)

# getting screenshot
if mode == "fullScreen":
    os.system("maim "+location+fname)
elif mode == "window":
    os.system("maim --window $(xdotool getactivewindow) "+location+fname)
elif mode == "select":
    os.system("maim --select "+location+fname)

# sending notification
os.system(f"notify-send -u \"normal\" \"screenshot saved to {location}{fname}\"")
