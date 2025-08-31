#!/bin/bash

# Get battery percentage
battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Check if battery is discharging and under 20%
if [ "$status" = "Discharging" ] && [ "$battery_level" -lt 20 ]; then
  notify-send -u critical -i battery-caution "🔋 Low Battery" "Battery at ${battery_level}%!"
fi
