#!/bin/bash

HDMI_STATUS=$(cat /sys/class/drm/card1-HDMI-A-1/status)

if [[ "$HDMI_STATUS" == "connected" ]]; then
    echo "HDMI connected – setting layout: Laptop left, HDMI right"
    hyprctl keyword monitor "eDP-1,preferred,0x0,1"
    hyprctl keyword monitor "HDMI-A-1,1920x1080,1920x0,1"
else
    echo "HDMI disconnected – disabling external monitor"
    hyprctl keyword monitor "eDP-1,preferred,0x0,1"
    hyprctl keyword monitor "HDMI-A-1,disable"
fi
