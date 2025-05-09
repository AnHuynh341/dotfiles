#!/bin/bash

current_mode=$(powerprofilesctl get)

if [[ "$current_mode" == "power-saver" ]]; then
    powerprofilesctl set balanced
elif [[ "$current_mode" == "balanced" ]]; then
    powerprofilesctl set performance
else
    powerprofilesctl set power-saver
fi

