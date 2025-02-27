#!/bin/zsh

#
# Config de eza
#

if type eza &> /dev/null
then
  alias ls="eza --icons=always" &&
  alias ll="eza --icons=always --long --git"

  # Desactivo los icons en caso de tty
  if (( IS_TTY ))
  then
    alias ls="eza --icons=never" &&
    alias ll="eza --icons=never --long --git"
  fi
fi
