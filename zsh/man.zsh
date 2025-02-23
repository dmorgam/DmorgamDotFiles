#!/bin/zsh

#
# Config del man
#

if type bat &> /dev/null
then
  alias man="MANPAGER='bat -p -l man' man"
else
  alias man="LESS_TERMCAP_mb=$'\e[1;31m' \
             LESS_TERMCAP_md=$'\e[1;33m' \
             LESS_TERMCAP_so=$'\e[01;42;30m' \
             LESS_TERMCAP_us=$'\e[01;37m' \
             LESS_TERMCAP_me=$'\e[0m' \
             LESS_TERMCAP_se=$'\e[0m' \
             LESS_TERMCAP_ue=$'\e[0m' \
             GROFF_NO_SGR=1 \
             MANPAGER='less -s -M +Gg' man"
fi
