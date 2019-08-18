#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx;
fi

export PS1='\e[1;31m[\u\e[1;37m@\e[m\e[1;31m\h\e[m \e[1;37m\W\e[m\e[1;31m]\$\e[m '