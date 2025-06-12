#!/bin/bash

# -------- Uptime --------
uptime_seconds=$(cut -d. -f1 /proc/uptime)
uptime_fmt=$(printf '%02d:%02d:%02d\n' $((uptime_seconds/3600)) $((uptime_seconds%3600/60)) $((uptime_seconds%60)))

# -------- Power Info --------
battery_path="/sys/class/power_supply/BAT0"
rapl_path="/sys/class/powercap/intel-rapl:0/energy_uj"

energy_total="?"
energy_unit="?"

# Detect power source
ac_status_file="/sys/class/power_supply/AC0/online"
ac_online=$(cat "$ac_status_file" 2>/dev/null || echo 0)

if [ "$ac_online" -eq 0 ]; then
    # On battery – use battery reading
    energy_now=$(cat "$battery_path/energy_now" 2>/dev/null || echo 0)
    energy_total=$(awk "BEGIN { printf \"%.2f\", $energy_now / 1000000 }")  # mWh -> Wh
    source_icon=" 󱩘 "
    energy_unit="Wh"
else
    # On AC – use RAPL
    if [[ -r "$rapl_path" ]]; then
        energy_uj=$(cat "$rapl_path")
        energy_total=$(awk "BEGIN { printf \"%.2f\", $energy_uj / 3600000000 }")  # µJ -> Wh
        source_icon=" 󱩗 "
        energy_unit="Wh"
    else
        source_icon="❓"
    fi
fi

# -------- Output --------
echo "{\"text\": \"$source_icon $energy_total $energy_unit |   $uptime_fmt \", \"tooltip\": \"Power source: $source_icon\\nTotal Energy: $energy_total $energy_unit\\nUptime: $uptime_fmt\"}"

