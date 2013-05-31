#!/bin/zsh

# if running from local tty, start systemd user session
if [ ! "$DISPLAY" ]; then
    sudo systemctl start user-session@$USER.service
fi
