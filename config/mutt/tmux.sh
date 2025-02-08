#!/bin/sh

tmux new-session -s Mail -n Gmail -d 'neomutt -F ~/.config/mutt/gmail -F ~/.config/mutt/muttrc'
tmux new-window -t Mail:2 -n Olimed -d 'neomutt -F ~/.config/mutt/olimed -F ~/.config/mutt/muttrc'
tmux attach-session -t Mail
