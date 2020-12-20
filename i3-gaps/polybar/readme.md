# Instructions on Siji font
siji has some needed icons,

## to get the siji font
install it from AUR

## to get the list of siji glyphs from which to get glyph codes
* clone the following repository https://github.com/stark/siji
* install the following package **xorg-xfd** from repository
* run the **view.sh** script present inside the git directory of siji
* on top middle, the selected icon's hex code will be shown after *character* word
* for example, the Archlinux icon code is 0x00e00e.
* in the vim editor, go to insert mode and press Ctrl-V to go into special insert mode
* then type "U" followed by the characters starting from 5th in the hex icon code.
* press enter, the icon will be shown in the editor, it might appear differntly
		if the siji font is not configured for vim, but it will appear on Polybar correctly.

## configuration details
there will be two configurations

config2 - this contains mostly custom script modules
config - this contains mostly inbuild modules, it has prefered look
