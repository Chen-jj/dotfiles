#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# cli tools
brew install ack
brew install tree
brew install wget

# development server setup
brew install nginx

# development tools
brew install zsh
brew install zsh-completions
brew install git
brew install git-lfs
brew install autojump
brew install tmux
brew install reattach-to-user-namespace
brew install ccat
brew install android-platform-tools
# brew install antigen