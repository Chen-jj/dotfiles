#!/bin/bash

set -e

# Dotfiles Installation Script
# Usage: ./install.sh

DOTFILES=$HOME/dotfiles
INSTALL_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles"
INSTALL_STATE_FILE="$INSTALL_STATE_DIR/install.completed"

mkdir -p "$INSTALL_STATE_DIR"

mark_step_completed() {
    local step_key="$1"

    touch "$INSTALL_STATE_FILE"
    if ! grep -Fxq "$step_key" "$INSTALL_STATE_FILE"; then
        echo "$step_key" >>"$INSTALL_STATE_FILE"
    fi
}

is_step_completed() {
    local step_key="$1"

    [ -f "$INSTALL_STATE_FILE" ] && grep -Fxq "$step_key" "$INSTALL_STATE_FILE"
}

run_script_step() {
    local step_label="$1"
    local step_key="$2"
    local description="$3"
    local script_path="$4"

    echo -e "\n$step_label: $description"
    if is_step_completed "$step_key"; then
        echo "Already completed, skipping."
        return
    fi

    source "$script_path"
    mark_step_completed "$step_key"
}

ensure_profile_file() {
    local profile

    for profile in "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.zprofile" "$HOME/.profile" "$HOME/.bashrc"; do
        if [ -e "$profile" ]; then
            return
        fi
    done

    touch "$HOME/.bash_profile"
}

echo "========================================"
echo "  Dotfiles Installation"
echo "========================================"

# Check OS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only supports macOS."
    exit 1
fi

echo -e "\n📱 Detected: macOS"

# Ensure a shell profile exists before installers that expect one.
ensure_profile_file

# Step 1: Homebrew
run_script_step "🍺 Step 1/7" "brew" "Installing Homebrew packages..." "$DOTFILES/install/brew.sh"

# Step 2: Node.js toolchain
run_script_step "🟢 Step 2/7" "nodejs" "Installing nvm, Node.js, and Yarn..." "$DOTFILES/install/nodejs.sh"

# Step 3: macOS System Preferences
run_script_step "⚙️  Step 3/7" "osx" "Configuring macOS system preferences..." "$DOTFILES/install/osx.sh"

# Step 4: Oh My Zsh
run_script_step "🐚 Step 4/7" "oh_my_zsh" "Setting up Oh My Zsh..." "$DOTFILES/install/oh_my_zsh.sh"

# Step 5: Tmux Plugin Manager
run_script_step "📺 Step 5/7" "tpm" "Installing Tmux Plugin Manager..." "$DOTFILES/install/tpm.sh"

# Step 6: Create Symlinks
run_script_step "🔗 Step 6/7" "links" "Creating symlinks..." "$DOTFILES/install/link.sh"

# Step 7: Set default shell
echo -e "\n🔧 Step 7/7: Configuring default shell..."
if is_step_completed "default_shell"; then
    echo "Already completed, skipping."
elif [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)" || echo "Warning: Could not change default shell. Please run: chsh -s $(which zsh)"
    mark_step_completed "default_shell"
else
    echo "zsh is already the default shell."
    mark_step_completed "default_shell"
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
