#!/bin/bash

set -e

DOTFILES=$HOME/dotfiles
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install Oh My Zsh core files without running the upstream installer,
# because this repo manages ~/.zshrc itself via symlink.
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo -e "\nInstalling Oh My Zsh..."
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR"
else
    echo "Oh My Zsh already installed, skipping core clone."
fi

# Create custom directories
mkdir -p "$ZSH_CUSTOM/themes"
mkdir -p "$ZSH_CUSTOM/plugins"

## Theme
clone_theme() {
    local repo=$1
    local name=$2
    local target="$ZSH_CUSTOM/themes/$name"

    if [ ! -d "$target" ]; then
        echo "Installing zsh theme: $name"
        git clone --depth=1 "$repo" "$target"
    else
        echo "Theme $name already installed, skipping."
    fi
}

clone_theme "https://github.com/spaceship-prompt/spaceship-prompt.git" "spaceship-prompt"

theme_target="$ZSH_CUSTOM/themes/spaceship.zsh-theme"
if [ -L "$theme_target" ] || [ -e "$theme_target" ]; then
    rm -f "$theme_target"
fi
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$theme_target"

## Plugins - only clone if not exists
clone_plugin() {
    local repo=$1
    local name=$2
    local target="$ZSH_CUSTOM/plugins/$name"

    if [ ! -d "$target" ]; then
        echo "Installing zsh plugin: $name"
        git clone --depth=1 "$repo" "$target"
    else
        echo "Plugin $name already installed, skipping."
    fi
}

clone_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
clone_plugin "https://github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting"

remove_plugin() {
    local name=$1
    local target="$ZSH_CUSTOM/plugins/$name"

    if [ -d "$target" ]; then
        echo "Removing unused zsh plugin: $name"
        rm -rf "$target"
    fi
}

remove_plugin "zsh-nvm"
remove_plugin "zsh-better-npm-completion"
remove_plugin "yarn-autocompletions"

echo "Oh My Zsh setup complete."
