#!/bin/bash

# get the environment
source /home/abdo/.zshenv
source /home/abdo/.aliases

# KILL_CMD="(progn (setq kill-emacs-hook 'nil) (kill-emacs))"
KILL_CMD="(client-save-kill-emacs)"

case "$1" in 
    start)   /usr/bin/emacs --daemon > /dev/null ;;
    stop)    /usr/bin/emacsclient --eval "$KILL_CMD" ;;
    restart)  ;;
esac
        