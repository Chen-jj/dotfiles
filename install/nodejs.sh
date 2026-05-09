#!/bin/bash

set -e

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

latest_nvm_version() {
    curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest \
        | sed -n 's/.*"tag_name": "\(v[0-9.]*\)".*/\1/p' \
        | head -n 1
}

NVM_VERSION="${NVM_VERSION:-$(latest_nvm_version)}"
NVM_VERSION="${NVM_VERSION:-v0.40.3}"

echo "Installing or updating nvm ($NVM_VERSION)..."
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash

if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo "Error: nvm installation failed."
    exit 1
fi

echo "Installing latest stable Node.js..."
nvm install node
nvm alias default node
nvm use default >/dev/null

if command -v corepack >/dev/null 2>&1; then
    echo "Installing latest stable Yarn via Corepack..."
    corepack enable
    corepack prepare yarn@stable --activate
else
    echo "Corepack unavailable, installing latest Yarn via npm..."
    npm install --global yarn@latest
fi

echo "Node toolchain ready:"
echo "  nvm: $(nvm --version)"
echo "  node: $(node --version)"
echo "  yarn: $(yarn --version)"
