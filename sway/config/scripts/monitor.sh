#!/bin/sh
if [[ $(swaymsg -t get_outputs --raw | jq 'map(select(.name != "eDP-1")) | length') == 0 ]]; then
    swaymsg output 'eDP-1' enable
else
    swaymsg output 'eDP-1' disable
fi
