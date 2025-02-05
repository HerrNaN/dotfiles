#!/bin/env bash

set -e

if [[ ! $(which mise) ]]; then
    curl https://mise.run | sh
fi

# Required for completions
mise use -g usage

fish_config="$XDG_CONFIG_HOME/fish/config.fish"
if [[ -f $fish_config ]] || [[ -L $fish_config ]]; then

    activate_line="mise activate fish | source"
    if [[ ! $(grep "$activate_line" "$fish_config") ]]; then
        echo "$activate_line" >> $fish_config
    fi

    completions_file="$XDG_CONFIG_HOME/fish/completions/mise.fish"
    if [[ ! -f $completions_file ]]; then
        mise completion fish > $completions_file
    fi
fi
