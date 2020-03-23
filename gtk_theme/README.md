# GTK theme #
This folder contains three things
  * gtkrc-2.0 file
  * icon theme "myIcons"
  * gtk theme "myTheme"

## installation procedure ##
  * copy the **gtkrc-2.0 file** to the home directory under hidden state
	  > cp gtkrc-2.0 ~/.gtkrc-2.0
  * copy the **gtk-3.0 folder** to the ~/.config/ directory for gtk3.0 applications
  * make two hidden directories for themes installation ".icons" and ".themes"
	  > mkdir ~/.themes ~/.icons
  * copy the themes to their respective directories; myTheme to .themes and myIcons to .icons directories
	  > cp -r myTheme ~/.themes/ && cp -r myIcons ~/.icons/

These themes are made using oomox gtk theme editor. The source is taken from github
https://github.com/themix-project/oomox#using-with-tiling-wms
