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

# Alias
alias d docker
alias ec 'emacsclient -n -a -c "emacs"'
alias g git

set -x EDITOR vim
