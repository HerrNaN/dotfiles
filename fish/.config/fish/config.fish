set -U fish_greeting

# SSH
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -x SSH_ASKPASS /usr/bin/ksshaskpass

# GPG
set -x GPG_TTY (tty)

# PATH
fish_add_path $HOME/go/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.local/bin

set -x BROWSER /usr/bin/qutebrowser

