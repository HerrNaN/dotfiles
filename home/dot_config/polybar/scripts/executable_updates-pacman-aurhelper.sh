#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum --aur 2> /dev/null | wc -l); then
    updates_aur=0
fi

arch_updates_label=""
if [ "$updates_arch" -gt 0 ]; then
    arch_updates_label="$updates_arch"
fi

aur_updates_label=""
if [ "$updates_aur" -gt 0 ]; then
    aur_updates_label="# $updates_aur"
fi

if [ "$arch_updates_label" ] && [ "$aur_updates_label" ]; then
    echo "$arch_updates_label $aur_updates_label"
else
    echo "$arch_updates_label$aur_updates_label"
fi
