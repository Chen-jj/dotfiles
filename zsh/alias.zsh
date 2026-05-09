# =============================================================================
# Modern CLI Replacements
# =============================================================================

# Use bat instead of cat (with fallback)
if command -v bat &>/dev/null; then
    alias cat="bat"
    alias catp="bat --plain"  # Plain mode for piping
elif command -v batcat &>/dev/null; then
    alias cat="batcat"
    alias catp="batcat --plain"
fi

# Use eza instead of ls (with fallback to ls)
if command -v eza &>/dev/null; then
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -la"
    alias lt="eza --tree"
    alias l="eza -lbF --git"
else
    alias ll="ls -la"
    alias la="ls -la"
fi

# Fuzzy finders
if command -v fd &>/dev/null; then
    alias find="fd"
fi

if command -v rg &>/dev/null; then
    alias grep="rg"
fi

# =============================================================================
# General Aliases
# =============================================================================
alias cls="clear"
alias ofd="open ."
alias zshrl="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
alias tmrc="$EDITOR ~/.tmux.conf"
alias hosts="sudo $EDITOR /etc/hosts"

# Quick git commit
alias quickp="git add . && git commit -m 'quick commit' && git push"

# Ensure git uses UTF-8
alias git='LANG=en_US.UTF-8 git'

# =============================================================================
# Tmux Aliases
# =============================================================================
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias tkill='tmux kill-session -t'

# =============================================================================
# Navigation
# =============================================================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# =============================================================================
# Development
# =============================================================================
alias serve="python3 -m http.server"
alias ports="lsof -i -P | grep LISTEN"