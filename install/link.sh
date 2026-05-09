#!/bin/bash

set -e

DOTFILES=$HOME/dotfiles

echo -e "\nCreating symlinks"
echo "=============================="

# Find all .symlink files and create symlinks
find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file" ".symlink")
    target="$HOME/.$filename"

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            # Update existing symlink to point to the correct location
            current_link=$(readlink "$target")
            if [ "$current_link" != "$file" ]; then
                echo "~${target#$HOME} already exists as a link, updating..."
                ln -sf "$file" "$target"
            else
                echo "~${target#$HOME} already exists as a link... Skipping."
            fi
        else
            echo "~${target#$HOME} already exists as a file... Creating backup."
            mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S)"
            ln -s "$file" "$target"
            echo "Created symlink: $target -> $file"
        fi
    else
        echo "Creating symlink: $target -> $file"
        ln -s "$file" "$target"
    fi
done

echo "Symlinks created."