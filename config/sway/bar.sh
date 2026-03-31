#!/bin/bash

while true; do
  time=$(date '+%A %H:%M %d-%m-%Y')

  layout=$(swaymsg -t get_inputs | jq -r '.. | select(.type?=="keyboard") | .xkb_active_layout_name // "us" ' | head -n1 | cut -d' ' -f1)

  volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
  if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "Mute: yes"; then
    volume="MUT"
  fi

  echo " $layout | ${volume}% | $time ^-^"

  sleep 1
done
