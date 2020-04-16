# configuration file for Alacritty terminal emulator
* copy the configuration file **alacritty.yml** to the folder **$HOME/.config/alacritty/**
* alacritty is configured to launch on **$mod+Shift+Return** keybinding in i3

## notes on alacritty
* this terminal supports terminal image viewing and glyph fonts.
* this is gpu-accelerated terminal, hence appears to be slow on non-gpu based system configurations.
* it requires special command to disable gpu-acceleration and start on non-gpu machines, it is.
> env LIBGL_ALWAYS_SOFTWARE=1 alacritty 
