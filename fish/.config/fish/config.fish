# Disable the default greeting behaviour
set -U fish_greeting

# SSH
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -x SSH_ASKPASS /usr/bin/ksshaskpass

# GPG
set -x GPG_TTY (tty)

# PATH
fish_add_path \
    ~/.ghcup/bin \
    ~/.local/bin \
    ~/.nim/bin \
    ~/.npm-global/bin \
    ~/.yarn/bin \
    ~/go/bin \
    ~/proj/doomemacs/bin

# Some programs use the BROWSER variable to decide on which
# browser to open links in
set -x BROWSER /usr/bin/qutebrowser

# Replacements
alias cat bat # A cat replacement with wings
alias ls exa # A modern replacement for ls

# Alias
alias d docker
alias ec 'emacsclient -n -a -c "emacs"'
alias g git

# Bluetooth devices get a new input device every time they are connected.
# This finds the input device for the "ERGO 860B Keyboard".
set kbd_ergo_860 /dev/input/(grep -B 1 -A 9 "ERGO 860B Keyboard" /proc/bus/input/devices | grep -o -E 'event[0-9]+')
# Since KMonad cannot read this variable we need to insert it into the
# config directyly.
sed -i -E (printf 's|/dev/input/event[0-9]+|%s|' $kbd_ergo_860) $HOME/.config/kmonad/config.kbd
sed -i (printf 's|<insert_kbd_input_device_here>|%s|' $kbd_ergo_860) $HOME/.config/kmonad/config.kbd


# When using a terminal from within emacs I already have vi(m)
# bindings. Let's not have 2 layers of them.
#
# NOTE: this doesn't work as intended atm since these functions
# seem to set the mode globally, meaning if I have a ordinary
# and an emacs terminal runnin at the same time they will share
# keybindings.
if test $INSIDE_EMACS
    fish_default_key_bindings
else
    fish_vi_key_bindings
end
