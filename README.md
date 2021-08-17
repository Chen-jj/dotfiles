Dotfiles
---
This dotfiles is fork from [chuyik/dotfiles](https://github.com/chuyik/dotfiles) and with some of my customization.

![dotfiles](https://cloud.githubusercontent.com/assets/6262943/19597521/ba234cca-97c7-11e6-9f9f-473f103e1f6f.jpeg)

## Setup

```bash
# Install required Xcode Command Line Tools
xcode-select --install

# Clone this repo to your personal dir
git clone git@github.com:Chen-jj/dotfiles.git ~/dotfiles

# Better checkout install.sh and customize it before start
# Run install.sh
./dotfiles/install.sh
```

## Brewing

### Install homebrew packages

* ack
* tree
* wget
* nginx
* zsh
* zsh-completions
* git
* git-lfs
* autojump
* tmux
* reattach-to-user-namespace
* ccat

## OSX Configuration

### finder

* Show all filename extensions
* Show hidden files by default
* Show the ~/Library folder in Finder
* Disable window animations and Get Info animations
* Allow text selection in Quick Look
* When performing a search, search the current folder by default
* Disable the warning when changing a file extension
* Avoid creating .DS_Store files on network volumes
* Enable subpixel font rendering on non-Apple LCDs
* Show Path bar in Finder

### Safari & WebKit

* Enable Safari’s debug menu

### OS

* Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
* Enable tap to click (Trackpad)
* Disable Dashboard
* Don’t show Dashboard as a Space
* Disable auto correction
* Disable smart quotes
* Disable smart dashes
* For TextEdit
* For Notes
* Kill affected applications

## Symlinks

* ~/.gemrc
* ~/.gitconfig
* ~/.tmux.conf
* ~/.zshrc

### .gemrc

* Only using the sources of **ruby-china**.
* Enable **verbose mode** which can help us check the progress of installation while gem installing package.
* **Remove the ri and rdoc** when installing new gems to speed up the gem installations and have less clutter in the system.

### .gitconfig

<mark>Waring</mark>: you should check and modify the user name and email.

* Setup the global Git hooks for [Git LFS](https://github.com/git-lfs/git-lfs).
* Alias:
   
   ls
   
   ```bash
   git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset' --abbrev-commit --date=relative --name-status
   ```
   
   lt
   
   ```bash
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset' --abbrev-commit --date=relative
   ```

* set **osxkeychain model** of credential to remember the user and pwd for https connection.
* color the git ui
* pull with rebase

### .tumx.conf

You can binding your favor prefix key which value is C-a as default here.

Also, you can tap C-r to reload tmux after editing ~/.tmux.conf.

### .zshrc

#### Themes

[Bullet Train](https://github.com/caiogondim/bullet-train-oh-my-zsh-theme)

#### Plugins

* [zsh-nvm](https://github.com/lukechilds/zsh-nvm): Zsh plugin for installing, updating and loading nvm.
* [zsh-better-npm-completion](https://github.com/lukechilds/zsh-better-npm-completion): Better completion for npm.
* [zsh-yarn-autocompletions](https://github.com/g-plane/zsh-yarn-autocompletions): Better completion for yarn.
* [git](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#git): Adds a lot of git aliases and functions.
* [autojump](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#autojump): Enables autojump if installed with homebrew.
* [sublime](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#sublime): Provides two commands, `st [file_name]` to open a specified file in Sublime Text and `stt`	to open the current directory in Sublime Text.
* [history](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#history): Provides some aliases for using the `history` command.
* [dirhistory](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#dirhistory): Allows us to navigate the history of previous current-working-directories using ALT-LEFT and ALT-RIGHT.

#### Aliases

* cls`clear`
* ofd: `open .`
* zshrc: `st ~/.zshrc`
* tmrc: `st ~/.tmux.conf`
* hosts: `st /etc/hosts`
* quickp: `git add . & git commit -m 'quick commit' & git push`
* ta: `tmux attach`
* tls: `tmux ls`
* tat: `tmux attach -t`
* tns: `tmux new-session -s`

## Others

### iTerm2

Color scheme: [Oceanic Dark](https://github.com/mhartington/oceanic-next-iterm)

### bin

* tm: Helping to attach tmux session or create a new named tmux session.
