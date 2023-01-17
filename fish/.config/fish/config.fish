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
fish_add_path $HOME/proj/doomemacs/bin
fish_add_path $HOME/.ghcup/bin
fish_add_path $HOME/.nim/bin

set -x BROWSER /usr/bin/qutebrowser

alias ec 'emacsclient -c -a "emacs"'
alias g git
alias d docker

if test $INSIDE_EMACS
    fish_default_key_bindings
else
    fish_vi_key_bindings
end
