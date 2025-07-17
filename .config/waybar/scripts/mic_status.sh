#!/bin/bash
MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
if [ "$MUTED" = "yes" ]; then
  echo " Muted"
else
  VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '/Volume:/{print $5}' | head -n1)
  echo " $VOL"
fi

