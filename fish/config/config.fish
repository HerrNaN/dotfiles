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


if status --is-interactive
    mise activate fish | source
end

# Connect to gnome-keyring ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# Alias
alias d docker
alias ec 'emacsclient -n -a -c "emacs"'
alias g git

if type -q hx
    set -x EDITOR hx
else
    set -x EDITOR vim
end

if type -q nvim
    alias vim nvim
end

if type -q bat
    alias cat bat
end
