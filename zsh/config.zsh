# =============================================================================
# Oh My Zsh Configuration
# =============================================================================

# Path to Oh My Zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE=true

# Theme: Spaceship
# https://github.com/spaceship-prompt/spaceship-prompt
SPACESHIP_PROMPT_ASYNC=true
ZSH_THEME="spaceship"

# Reduce per-command prompt work to avoid post-command input lag.
SPACESHIP_PROMPT_ORDER=(
    time
    user
    dir
    host
    git
    node
    exec_time
    line_sep
    jobs
    exit_code
    char
)

# Git prompt optimization in large repos.
DISABLE_UNTRACKED_FILES_DIRTY=true

# =============================================================================
# Plugins
# =============================================================================
# git: Git aliases and functions
# autojump: Directory jumping
# history: History command enhancements
# dirhistory: Alt+Left/Right for directory history
# zsh-autosuggestions: Fish-like suggestions
# zsh-syntax-highlighting: Syntax highlighting (must be last)

plugins=(
    git
    dirhistory
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# =============================================================================
# Completion
# =============================================================================
# Add Homebrew zsh-completions to fpath before Oh My Zsh initializes compinit.
if [[ -d /opt/homebrew/share/zsh-completions ]]; then
    fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi
if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# =============================================================================
# Load Oh My Zsh
# =============================================================================
source $ZSH/oh-my-zsh.sh

# =============================================================================
# History Configuration
# =============================================================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# =============================================================================
# Editor
# =============================================================================
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-$EDITOR}"
