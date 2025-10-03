#!/usr/bin/env bash
set -euo pipefail

# Show "ID<TAB>TEXT" directly, let the user choose one full line
line="$(cliphist list | rofi -dmenu -i -p 'Clipboard')"
[ -z "${line:-}" ] && exit 0

# Extract the ID (cliphist uses a TAB between ID and text)
id="$(printf '%s' "$line" | cut -f1 -d $'\t')"
# Fallback in case the separator isn't a tab on your system:
[ -n "$id" ] || id="${line%% *}"

# Decode and set CLIPBOARD (no trailing newline)
cliphist decode "$id" | wl-copy -n

# Optional: also set PRIMARY for middle-click paste
# data="$(cliphist decode "$id")"
# printf '%s' "$data" | wl-copy -n
# printf '%s' "$data" | wl-copy -n -p

