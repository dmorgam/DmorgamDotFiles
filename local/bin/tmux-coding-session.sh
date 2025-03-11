#!/bin/sh

# Tmux session for programming

SESSION_NAME="developer"


# Start tmux session
tmux new-session -d -s "$SESSION_NAME"

# Window 1
tmux rename-window -t "$SESSION_NAME":1 'Nvim'
tmux send-keys     -t "$SESSION_NAME":1 'cd ~/Git' C-m
tmux send-keys     -t "$SESSION_NAME":1 'nvim' C-m

# Window 2
tmux new-window -t "$SESSION_NAME":2 -n 'Server'
tmux send-keys  -t "$SESSION_NAME":2 'cd ~/Git && ll' C-m

# Window 3
tmux new-window -t "$SESSION_NAME":3 -n 'Commands'
tmux send-keys  -t "$SESSION_NAME":3 'cd ~/Git && ll' C-m

# Window 3
tmux new-window      -t "$SESSION_NAME":4 -n 'Misc'
tmux split-window -v -t "$SESSION_NAME":4 -p 12 'cmus' C-m
tmux split-window -h -t "$SESSION_NAME":4 'cava' C-m

# Select default pane
tmux select-window -t "$SESSION_NAME":1

# Attach to session
tmux a -t "$SESSION_NAME"
