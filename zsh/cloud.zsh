#!/bin/zsh

#
# Config de los cli de cloud
#

# Aws cli autocomplete
type aws_completer &> /dev/null &&
  complete -C 'aws_completer' aws
