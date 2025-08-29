#!/bin/bash

status=$(playerctl status -p spotify)

if [[ "$status" == "Playing" ]]; then
  # Pause icon in green
  echo "%{F#EC7875}%{F-}"
else
  # Play icon in cyan
  echo "%{F#00FFFF}%{F-}"
fi
