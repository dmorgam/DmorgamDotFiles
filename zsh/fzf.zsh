#!/bin/zsh

#
# Config de fzf
#

if type fzf &> /dev/null
then
  source <(fzf --zsh)

  type bat &> /dev/null &&
    alias fzf='fzf --preview="bat --color=always {}"' ||
    alias fzf='fzf --preview="cat {}"'
fi

# Reverse history search like bash (only when not fzf installed)
type fzf &> /dev/null ||
  bindkey '^R' history-incremental-search-backward
