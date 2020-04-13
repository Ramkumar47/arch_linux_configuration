# rxvt-unicode configuration
In this directory, there will be a file called **URxvt.config**, this is the configuration file for the terminal.

## Procedure for placemenet of configuration
* copy the contents of **URxvt.config** file to the  **~/.Xdefaults** hidden file
* copy the **resize-font** perl-extension file to the folder **/usr/lib64/urxvt/perl/** for the font-resizing to work
* edit the file for further configuration
* this procedure is done because the Xdfaults file is used for other applications as well

## rxvt-unicode vs rxvt-unicode-patched
* rxvt-unicode-patched is installed from AUR instead of rxvt-unicode from official repos.
* this is done as the patched version has support for image previews in ranger.
* this patched version doesnt have support for FontAwesome icons. And for now, it is not needed to have FontAwesome icons in terminal.
* For including icons in the text, the **gvim** can be used, as it has the support for icons.
