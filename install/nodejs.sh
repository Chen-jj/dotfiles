#!/bin/bash

set -e

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
export PROFILE="${PROFILE:-$HOME/.bash_profile}"

latest_nvm_version() {
    curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest \
        | sed -n 's/.*"tag_name": "\(v[0-9.]*\)".*/\1/p' \
        | head -n 1
}

ensure_profile_contains_nvm() {
    mkdir -p "$(dirname "$PROFILE")"
    touch "$PROFILE"

    grep -Fqx 'export NVM_DIR="$HOME/.nvm"' "$PROFILE" || \
        printf '\nexport NVM_DIR="$HOME/.nvm"\n' >>"$PROFILE"
    grep -Fqx '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' "$PROFILE" || \
        printf '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n' >>"$PROFILE"
}

install_or_update_nvm() {
    if [ -d "$NVM_DIR/.git" ]; then
        echo "Updating nvm to $NVM_VERSION..."
        git -C "$NVM_DIR" fetch --tags origin >/dev/null 2>&1 || true
        git -C "$NVM_DIR" checkout --quiet "$NVM_VERSION"
    elif [ -s "$NVM_DIR/nvm.sh" ]; then
        echo "nvm files already exist, keeping current installation."
    else
        echo "Installing nvm ($NVM_VERSION)..."
        rm -rf "$NVM_DIR"
        git clone --depth=1 --branch "$NVM_VERSION" https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    fi
}

load_nvm() {
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        . "$NVM_DIR/nvm.sh"
    else
        echo "Error: nvm installation failed."
        exit 1
    fi
}

ensure_node() {
    local default_version

    default_version="$(nvm version default 2>/dev/null || true)"
    if [ -n "$default_version" ] && [ "$default_version" != "N/A" ]; then
        echo "Default Node.js already configured: $default_version"
        nvm use default >/dev/null
        return
    fi

    echo "Installing latest stable Node.js..."
    nvm install node
    nvm alias default node
    nvm use default >/dev/null
}

ensure_yarn() {
    if command -v yarn >/dev/null 2>&1; then
        echo "Yarn already installed: $(yarn --version)"
        return
    fi

    if command -v corepack >/dev/null 2>&1; then
        echo "Installing latest stable Yarn via Corepack..."
        corepack enable
        corepack prepare yarn@stable --activate
    else
        echo "Corepack unavailable, installing latest Yarn via npm..."
        npm install --global yarn@latest
    fi
}

NVM_VERSION="${NVM_VERSION:-$(latest_nvm_version)}"
NVM_VERSION="${NVM_VERSION:-v0.40.3}"

ensure_profile_contains_nvm
install_or_update_nvm
load_nvm
ensure_node
ensure_yarn

echo "Node toolchain ready:"
echo "  nvm: $(nvm --version)"
echo "  node: $(node --version)"
echo "  yarn: $(yarn --version)"
