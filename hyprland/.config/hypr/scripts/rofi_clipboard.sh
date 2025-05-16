#!/bin/bash

# Create a temporary map file
mapfile=$(mktemp)

# Build the list: clipboard content → store ID in a file
cliphist list | while read -r id rest; do
    echo "$rest" >> "$mapfile"
done

# Let the user choose an entry
selected=$(cat "$mapfile" | rofi -dmenu -i -p "Clipboard")

# Get the corresponding ID
id=$(cliphist list | awk -v sel="$selected" '$0 ~ sel {print $1; exit}')

# Decode and copy it
[ -n "$id" ] && cliphist decode "$id" | wl-copy

# Clean up
rm "$mapfile"
