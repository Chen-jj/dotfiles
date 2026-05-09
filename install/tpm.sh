#!/bin/bash

set -e

## Install Tmux Plugin Manager
tpm_dir="$HOME/.tmux/plugins/tpm"

if [ ! -d "$tpm_dir" ]; then
    echo "Installing Tmux Plugin Manager..."
    mkdir -p "$tpm_dir"
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$tpm_dir"
else
    echo "Tmux Plugin Manager already installed."
fi

echo "TPM setup complete."
