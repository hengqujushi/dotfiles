#!/bin/bash

if [ ! "$1" ]; then           session=default
else                          session="$1"
fi

if [ -f ~/tmux.d/$session ]; then  opts_file="$HOME/.tmux/$session"
else                               opts_file="$HOME/.tmux/default"
fi

tmux attach-session -t "$session" &> /dev/null ||
tmux new-session    -s "$session" \; source-file "$opts_file"