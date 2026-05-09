#!/bin/bash

set -e

# Dotfiles Installation Script
# Usage: ./install.sh

DOTFILES=$HOME/dotfiles

echo "========================================"
echo "  Dotfiles Installation"
echo "========================================"

# Check OS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only supports macOS."
    exit 1
fi

echo -e "\n📱 Detected: macOS"

# Step 1: Homebrew
echo -e "\n🍺 Step 1/7: Installing Homebrew packages..."
source "$DOTFILES/install/brew.sh"

# Step 2: Node.js toolchain
echo -e "\n🟢 Step 2/7: Installing nvm, Node.js, and Yarn..."
source "$DOTFILES/install/nodejs.sh"

# Step 3: macOS System Preferences
echo -e "\n⚙️  Step 3/7: Configuring macOS system preferences..."
source "$DOTFILES/install/osx.sh"

# Step 4: Oh My Zsh
echo -e "\n🐚 Step 4/7: Setting up Oh My Zsh..."
source "$DOTFILES/install/oh_my_zsh.sh"

# Step 5: Tmux Plugin Manager
echo -e "\n📺 Step 5/7: Installing Tmux Plugin Manager..."
source "$DOTFILES/install/tpm.sh"

# Step 6: Create Symlinks
echo -e "\n🔗 Step 6/7: Creating symlinks..."
source "$DOTFILES/install/link.sh"

# Step 7: Set default shell
echo -e "\n🔧 Step 7/7: Configuring default shell..."
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)" || echo "Warning: Could not change default shell. Please run: chsh -s $(which zsh)"
else
    echo "zsh is already the default shell."
fi

# Create ~/.bash_profile if not found (for compatibility)
if [ ! -e "$HOME/.bash_profile" ]; then
    touch "$HOME/.bash_profile"
fi

echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Install Tmux plugins: Press 'prefix + I' in Tmux (prefix is Ctrl+a)"
echo "  3. Restart applications for all changes to take effect"
echo ""
echo "Happy coding! 🚀"
