# hook for creating package list #
This hook runs when a package is installed.
The list file is placed in the file "/etc/pkglist.txt"

The hook file should be placed in the directory "/usr/share/libalpm/hooks/"

The packages can be reinstalled using the command
"pacman -S --needed - < pkglist.txt"

to filter out the packages that are not installed from Arch repository, like
from AUR and local compilations, the enriched version of above command can be
used as given below.
"pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))"
