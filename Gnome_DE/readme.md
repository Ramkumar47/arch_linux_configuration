# instructions to install gnome desktop environment
after the minimal installation of Archlinux with zsh environment,
- install the packages **xorg, xorg-xinit**
- then install **gnome** group, this will install all the required packages, except gnome-tweaks, which has to be manually installed
- else using the hook file **pkglist.txt** in the current directory (not the one outside), install all the packages.
- then in the shell, enable gnome display manager with command
> systemctl enable gdm
- then reboot, the gnome environment will be started

# aft DE install, configuration instructions
- after gnome DE installation, the manual configuration for terminal, vim, zsh etc.. are to be done.
- gnome-terminal is used by default for now, but later kitty is planned to install.
- the shortcut for gnome-terminal has to be configured manually.
- the themes for gnome can be taken from your configured theme present at ../gtk_theme/ folder

# instructions to install "dash-to-dock"
- install the package **chrome-gnome-shell** (it will be installed if hook is used)
- then go to the site https://extensions.gnome.org
- then search for "dash to dock" after that the procedure to add is easily understandable.
