#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# customization of user@host in terminal
PS1='\e[1;31m[\u\e[1;37m@\e[m\e[1;31m\h\e[m \e[1;37m\W\e[m\e[1;31m]\$\e[m '

#'\e[x;ym $PS1 \e[m'

# custom aliases
alias xclips="xclip -selection \"clipboard\""
