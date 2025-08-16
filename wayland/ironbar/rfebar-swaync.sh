#! /usr/bin/env bash

IFS=
swaync-client -s | jq --unbuffered -r '
  "\(
    if .visible then "󰂜 "
    elif .dnd then "󰂛 "
    elif .count > 0 then "󱅫 "
    else "󰂚 "
    end
  ) \(.count)"
'
