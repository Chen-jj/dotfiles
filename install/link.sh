#!/bin/bash

set -e

DOTFILES=$HOME/dotfiles

echo -e "\nCreating symlinks"
echo "=============================="

create_link() {
    local source_file="$1"
    local target_file="$2"

    mkdir -p "$(dirname "$target_file")"

    if [ -e "$target_file" ]; then
        if [ -L "$target_file" ]; then
            local current_link
            current_link=$(readlink "$target_file")
            if [ "$current_link" != "$source_file" ]; then
                echo "~${target_file#$HOME} already exists as a link, updating..."
                ln -sf "$source_file" "$target_file"
            else
                echo "~${target_file#$HOME} already exists as a link... Skipping."
            fi
        else
            echo "~${target_file#$HOME} already exists as a file... Creating backup."
            mv "$target_file" "$target_file.bak.$(date +%Y%m%d%H%M%S)"
            ln -s "$source_file" "$target_file"
            echo "Created symlink: $target_file -> $source_file"
        fi
    else
        echo "Creating symlink: $target_file -> $source_file"
        ln -s "$source_file" "$target_file"
    fi
}

# Find all .symlink files and create symlinks
find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file" ".symlink")
    target="$HOME/.$filename"

    create_link "$file" "$target"
done

# Ghostty uses XDG/macOS application config paths rather than dotfiles in $HOME.
ghostty_source="$DOTFILES/ghostty/config.ghostty"
ghostty_target="$HOME/.config/ghostty/config.ghostty"
if [ -f "$ghostty_source" ]; then
    create_link "$ghostty_source" "$ghostty_target"
fi

echo "Symlinks created."
