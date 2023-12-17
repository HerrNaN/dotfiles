#!/bin/env sh
#
# This script enables starting kmonad for different devices using
# only one .kbd file.

case $1 in
    # The bluetooth keyboard doesn't use the same /dev device when it connects
    # so we first need to find it.
    ergo_860)
        KBD_DEV=/dev/input/$(grep -B 1 -A 9 "ERGO 860B Keyboard" /proc/bus/input/devices | grep -o -E 'event[0-9]+') ;;

    # The on board keyboard on my current laptop.
    nembus)
        KBD_DEV="/dev/input/by-path/platform-i8042-serio-0-event-kbd" ;;

    *) echo "invalid keyboard"; exit 1;;
esac

export KBD_DEV
KBDCFG=$(envsubst < ~/.config/kmonad/config.kbd)

kmonad <(echo "$KBDCFG")
