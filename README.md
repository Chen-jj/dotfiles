# Dotfiles

Personal macOS dotfiles for quick development environment setup.

![dotfiles](https://cloud.githubusercontent.com/assets/6262943/19597521/ba234cca-97c7-11e6-9f9f-473f103e1f6f.jpeg)

## Quick Start

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Clone this repo
git clone git@github.com:Chen-jj/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Review and customize if needed
# - Edit git/gitconfig.symlink with your name/email
# - Edit zsh/zshrc.symlink for any custom paths

# 4. Run the installer
./install.sh
```

## What's Included

### Modern CLI Tools

| Tool | Description |
|------|-------------|
| [bat](https://github.com/sharkdp/bat) | Modern `cat` with syntax highlighting |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [fd](https://github.com/sharkdp/fd) | Fast `find` alternative |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast `grep` alternative |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |

### Development Tools

- **zsh** with [Oh My Zsh](https://ohmyz.sh/)
- **tmux** with [TPM](https://github.com/tmux-plugins/tpm)
- **git** with useful aliases
- **autojump** for quick directory navigation

### Zsh Plugins

- `dirhistory` (Oh My Zsh built-in) - Navigate directory history with keyboard shortcuts
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Syntax highlighting

### Node.js Toolchain

- Automatically installs the latest `nvm`
- Automatically installs the latest stable `Node.js`
- Automatically installs the latest stable `Yarn`

### Theme

[Spaceship](https://github.com/spaceship-prompt/spaceship-prompt) - Minimalistic, customizable Zsh prompt theme

## macOS Configuration

The installer configures various macOS system preferences:

- Show all filename extensions
- Show hidden files in Finder (toggle with Cmd+Shift+.)
- Show Path bar in Finder
- Disable auto-correct, smart quotes, smart dashes
- Enable tap to click
- Enable Safari debug menu
- And more...

## Symlinks Created

| Source | Target |
|--------|--------|
| `gemrc.symlink` | `~/.gemrc` |
| `gitconfig.symlink` | `~/.gitconfig` |
| `tmux.conf.symlink` | `~/.tmux.conf` |
| `zshrc.symlink` | `~/.zshrc` |

## Customization

### Machine-Specific Settings

Add your personal configurations to `~/.bash_profile`:

```bash
# Example: Custom Java version
export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home

# Example: Company VPN/proxy settings
export HTTP_PROXY=http://proxy.company.com:8080
```

### Git Configuration

Remember to update your name and email in `git/gitconfig.symlink` before running the installer.

## Post-Installation

1. **Restart your terminal** or run `source ~/.zshrc`
2. **Install Tmux plugins**: Open tmux and press `Ctrl+a` then `I` (capital i)
3. **Install fzf key bindings**: Already done during brew installation
4. **Use dirhistory**: Press `Alt+Left` and `Alt+Right` to go backward and forward through directory history

## Aliases

### General
- `cat` → `bat` (syntax highlighting)
- `ls` → `eza` (modern listing)
- `ll` → detailed listing
- `..` → `cd ..`

### Tmux
- `ta` → attach to last session
- `tat <name>` → attach to named session
- `tns <name>` → new session
- `tls` → list sessions

### Git
- `quickp` → add, commit "quick commit", and push
- `git ls` → pretty log with file status
- `git lt` → pretty log (tree only)

## Credits

Forked from [chuyik/dotfiles](https://github.com/chuyik/dotfiles) with modern updates.
