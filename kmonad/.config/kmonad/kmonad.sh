#!/bin/env sh

case $1 in
    ergo_860) KBD_DEV=`kbd_ergo_860 /dev/input/(grep -B 1 -A 9 "ERGO 860B Keyboard" /proc/bus/input/devices | grep -o -E 'event[0-9]+')` ;;
    thinkpad) KBD_DEV="platform-i8042-serio-0-event-kbd" ;;
    *) echo "invalid keyboard"; exit 1;;
esac

export KBD_DEV
KBDCFG=$(envsubst < ergo_860.kbd)

kmonad -d <(echo "$KBDCFG")
