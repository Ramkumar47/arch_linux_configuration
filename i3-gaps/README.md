# i3wm configuration file
Note:
* copy the contents of this folder to ~/.config/ folder
* install firefox and pcmanfm filemanager for the configuration to work correctly for now.
* place an image file with name **wallpaper.jpg** in Pictures/ directory to be applied as wallpaper
* "i3exit" script is a manual one for enabling "mod+0" exit commands

## list and overview of contents
"i3/" : i3wm configuration
"rofi/" : configuration and theme chosen for rofi launcher
"polybar/" : configuration for polybar

## things to configure
* pcmanfm manager

## things to install in addition
* rofi <instead of dmenu>
* polybar from AUR, and siji iconic font from AUR
* i3lock-blur from AUR

## things to be installed and play around with
* i3Blocks instead of i3Status

## Notes for Rofi
rofi files in the cache has to be cleared in order to remove the history of searches "~/.cache/"

## notes for polybar ##
  * both polybar and the supporting iconic font *siji* has to be retrieved from AUR
  * i3bar section in i3 configuration file has to be commented and replaced by polybar launch script command
  * by default polybar is enabled due to its quite advanced features than i3bar and i3blocks

# Code snippets
The file "code_snippets" contains small snippets of configuration that have to be added in specific config files so as to implement the need. The details of implementation are given in the same file.
