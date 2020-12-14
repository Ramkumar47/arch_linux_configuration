# arch_linux_configuration
This repository contains my personal ArchLinux configuration files and customization ideas

Each directory will have its own configuration files along with a README.md file individually

* the file "bash_profile" is added to the home directory under hidden state ("."-prefix) so as to enable auto startx to work

* the bashrc file is also similar to bash_profile and can be added after checking the needed.

## applications to install for fresh installation
  * use pkglist.txt generated using pacman hook to install all the needed stuff

## custom scripts folder
* create the custom scripts folder as explained in the **scripts** directory, for accessing custom scripts at any path.

## Things to be configured
* icon fonts in terminals

## pkglist details ##
the file **pkglist.txt** contains the list of all packages that are installed
in the up-to-date system.

* in the file, **rxvt-unicode-patched** will be present instead of **rxvt-unicode**, the former is from AUR.
* **rxvt-unicode-patched** is installed as it has support for ranger image previews.

## No password Option ##
for certain super user options like shutdown, reboot etc can be
made to work without password by adding the following line in the/etc/sudoers file.
> %wheel ALL=(ALL) NOPASSWD: /sbin/shutdown/,/sbin/reboot,/sbin/poweroff
just below the line
> %wheel ALL=(ALL) ALL

## packages for wifi-menu ##
the packages required for wifi-menu to work are as follows
5 packages - iw, wpa_supplicant, netctl, dialog, dhcpcd, iwd
these packages can be installed during pacstrap command at main installation
and enable iwd, dhcpcd for wifi to work when using iwctl
