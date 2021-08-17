# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme: Bullet Train
# https://github.com/caiogondim/bullet-train-oh-my-zsh-theme
ZSH_THEME="bullet-train"
export BULLETTRAIN_NVM_SHOW=true

# Plugins

# config for zsh-nvm
# export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

plugins=(zsh-nvm git autojump sublime history dirhistory zsh-better-npm-completion zsh-autosuggestions yarn-autocompletions)

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh