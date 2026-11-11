#!/bin/zsh

#
# Herdr: C-h/j/k/l mueven entre panes, como vim-tmux-navigator en tmux.
# Nvim hace lo mismo desde su lado (plugins/vim-tmux-navigator.lua).
# Solo dentro de un terminal de herdr (app: $HC_TERMINAL_ID, TUI: $HERDR_ENV)
# y fuera de tmux.
#

if [[ -z "$TMUX" ]] && {
  { [[ -n "$HC_TERMINAL_ID" ]] && (( $+commands[herdr-app] )) } ||
  { [[ "$HERDR_ENV" == 1 ]] && (( $+commands[herdr] )) }
}
then
  _herdr_pane_go () {
    if [[ -n "$HC_TERMINAL_ID" ]]
    then
      herdr-app do pane.go --direction "$1" &> /dev/null
    else
      herdr pane focus --direction "$1" &> /dev/null
    fi
  }

  herdr-pane-left ()  { _herdr_pane_go left }
  herdr-pane-down ()  { _herdr_pane_go down }
  herdr-pane-up ()    { _herdr_pane_go up }
  herdr-pane-right () { _herdr_pane_go right }

  zle -N herdr-pane-left
  zle -N herdr-pane-down
  zle -N herdr-pane-up
  zle -N herdr-pane-right

  for keymap in viins vicmd
  do
    bindkey -M "$keymap" '^H' herdr-pane-left
    bindkey -M "$keymap" '^J' herdr-pane-down
    bindkey -M "$keymap" '^K' herdr-pane-up
    bindkey -M "$keymap" '^L' herdr-pane-right
  done
  unset keymap
fi
