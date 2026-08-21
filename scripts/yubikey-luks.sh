#!/usr/bin/env bash

# Enroll the yubikey for LUKS
sudo systemd-cryptenroll \
  --fido2-device=auto \
  --fido2-with-client-pin=false \
  --fido2-with-user-presence=true \
  /dev/the-luks-device

# Add FIDO2 device option
sudo rpm-ostree kargs \
  --append=rd.luks.options=fido2-device=auto

# Enable FIDO2 in initramfs
sudo rpm-ostree initramfs --enable --arg=--add --arg=fido2
