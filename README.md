# arch_linux_configuration
This repository contains my personal ArchLinux configuration files and customization ideas

Each directory will have its own configuration files along with a README.md file individually

* the file "bash_profile" is added to the home directory under hidden state ("."-prefix) so as to enable auto startx to work

* the bashrc file is also similar to bash_profile and can be added after checking the needed.

## applications to install for fresh installation
  * use pkglist.txt generated using pacman hook to install all the needed stuff

## Things to be configured
  * zoom settings for urxvt
  * popup calendar settings
  * zathura pdf reader

## pkglist details ##
the file **pkglist.txt** contains the list of all packages that are installed
in the up-to-date system.

* in the file, **rxvt-unicode-patched** will be present instead of **rxvt-unicode**, the former is from AUR.
* **rxvt-unicode-patched** is installed as it has support for ranger image previews.
