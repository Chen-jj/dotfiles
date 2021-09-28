#!/bin/sh

if [ ! -d $HOME/.oh-my-zsh ]; then
    echo -e "\nInstalling Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

DOTFILES=$HOME/dotfiles
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

## theme
if [ ! -d $ZSH_CUSTOM/themes ]; then
    mkdir -p $ZSH_CUSTOM/themes/
fi

ln -s $DOTFILES/oh-my-zsh/themes/bullet-train.zsh-theme $ZSH_CUSTOM/themes/bullet-train.zsh-theme
ln -s $DOTFILES/oh-my-zsh/themes/bullet-train.zsh-theme $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme

## plugins
if [ ! -d $ZSH_CUSTOM/plugins ]; then
    mkdir -p $ZSH_CUSTOM/plugins/
fi

git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
git clone https://github.com/lukechilds/zsh-better-npm-completion $ZSH_CUSTOM/plugins/zsh-better-npm-completion
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
cp -R $DOTFILES/oh-my-zsh/plugins/yarn-autocompletions $ZSH_CUSTOM/plugins/yarn-autocompletions