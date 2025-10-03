#!/bin/bash

current=$(pactl get-default-sink)


sinks=($(pactl list short sinks | awk '{print $2}'))


for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current" ]]; then
        next_index=$(( (i + 1) % ${#sinks[@]} ))
        next_sink="${sinks[$next_index]}"
        break
    fi
done


pactl set-default-sink "$next_sink"


for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "$next_sink"
done

sink_description=$(pactl list sinks | grep -A 20 "$next_sink" | grep "Description:" | head -n1 | cut -d':' -f2- | sed 's/^[ \t]*//')

# Fallback if no description
if [[ -z "$sink_description" ]]; then
    sink_description="$next_sink"
fi

notify-send "Audio Output Changed" "$sink_description"

