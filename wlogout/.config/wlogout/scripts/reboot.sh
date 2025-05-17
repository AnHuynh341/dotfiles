#!/bin/bash

NOTIFY_CMD="$(command -v notify-send)"

if [[ -n "$NOTIFY_CMD" ]]; then
    notify-send "Rebooting..." 
fi

if pgrep -f chrome > /dev/null; then
    echo "Chrome is running — closing it..."
    pkill -f chrome
    sleep 2
else
    echo "Chrome is not running."
fi

sleep 1
echo "Rebooting..."
systemctl reboot

