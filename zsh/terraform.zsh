#!/bin/zsh

#
# Config de terraform
#

if type terraform &> /dev/null
then
  alias tf=terraform
  complete -o nospace -C ~/.local/bin/terraform terraform
  compdef __start_terraform tf
fi
