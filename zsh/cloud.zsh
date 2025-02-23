#!/bin/zsh

#
# Config de los cli de cloud
#

# Aws cli autocomplete
type aws_completer &> /dev/null &&
  complete -C '~/.local/bin/aws_completer' aws
