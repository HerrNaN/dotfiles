#!/bin/bash
pidof kanshi >/dev/null
if [ "$?" -ne 0 ]; then
    kanshi &
fi
