# =============================================================================
# Oh My Zsh Configuration
# =============================================================================

# Path to Oh My Zsh
export ZSH=$HOME/.oh-my-zsh

# Theme: Spaceship
# https://github.com/spaceship-prompt/spaceship-prompt
ZSH_THEME="spaceship"

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
    autojump
    history
    dirhistory
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# =============================================================================
# Completion
# =============================================================================
# Add Homebrew zsh-completions to fpath
if [[ -d /opt/homebrew/share/zsh-completions ]]; then
    fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi
if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Fix common Homebrew permission issues that trigger compinit prompts.
fix_compinit_permissions() {
    local dir
    for dir in /opt/homebrew/share /usr/local/share; do
        if [[ -d "$dir" && -O "$dir" ]]; then
            chmod go-w "$dir" 2>/dev/null || true
        fi
    done
}

# Initialize completions without interactive prompts.
autoload -Uz compinit compaudit
fix_compinit_permissions
if [[ -n "$(compaudit 2>/dev/null)" ]]; then
    compinit -i
else
    compinit
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
