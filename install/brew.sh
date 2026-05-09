#!/bin/bash

set -e

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for Apple Silicon Macs
    if [[ -d /opt/homebrew/bin ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d /usr/local/bin ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

echo "Updating Homebrew..."
brew update

echo "Installing Homebrew packages..."

# CLI tools
brew install wget
brew install bat      # Modern replacement for cat
brew install eza      # Modern replacement for ls
brew install fd       # Modern replacement for find
brew install ripgrep  # Modern replacement for grep
brew install fzf      # Fuzzy finder (Ctrl+R history, Ctrl+T files)

# Development tools
brew install zsh
brew install zsh-completions
brew install git
brew install autojump
brew install tmux
brew install reattach-to-user-namespace

# Optional: install fzf key bindings
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc 2>/dev/null || true

# Fix Homebrew directory permissions that can trigger compinit warnings.
for dir in /opt/homebrew/share /usr/local/share; do
    if [[ -d "$dir" && -O "$dir" ]]; then
        chmod go-w "$dir" 2>/dev/null || true
    fi
done

echo "Homebrew packages installed."
