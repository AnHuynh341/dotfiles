#!/bin/bash

# Get battery capacity and charging state
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Get current power profile
power_mode=$(powerprofilesctl get)

# Define icons (adjust as desired)
icon_charging="󰂄 "
icon_full="󰁹 "
icon_saver="󱤅 "       # Example icon for power-saver
icon_balanced=" "    # Example icon for balanced
icon_performance="󰓅 " # Example icon for performance

# Select icon based on power mode
case $power_mode in
    power-saver) icon="$icon_saver" ;;
    balanced)    icon="$icon_balanced" ;;
    performance) icon="$icon_performance" ;;
    *)           icon="󰂄" ;;
esac

# Override icon if charging/full
#if [ "$status" = "Charging" ]; then
#    icon="$icon_charging"
#elif [ "$capacity" -ge 98 ]; then
#    icon="$icon_full"
#fi

# Output JSON
echo " $icon $capacity% "
