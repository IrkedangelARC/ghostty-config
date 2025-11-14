# ============================================================================
# ARC Event Productions - ZSH Configuration
# ============================================================================

# API Keys
# OPENAI_API_KEY removed - now managed via .env files in each project

# ============================================================================
# Auto-Suggestions (type to see history suggestions)
# ============================================================================
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Press → (right arrow) to accept suggestion
# Press Ctrl+→ to accept one word at a time

# ============================================================================
# Git-Aware Prompt
# ============================================================================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' [%b]'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f%F{yellow}${vcs_info_msg_0_}%f %F{green}❯%f '

# ============================================================================
# Useful Aliases
# ============================================================================

# Event Workflow Shortcuts
alias workflow='python3 ~/projects/arc-events/event_workflow.py --create-calendar'
alias workflow-test='python3 ~/projects/arc-events/event_workflow.py --create-calendar --confirm'
alias workflow-extract='python3 ~/projects/arc-events/event_workflow.py'

# Directory Navigation
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git Shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'

# Quick Navigation
alias events='cd ~/projects/arc-events'
alias payroll='cd ~/projects/arc-payroll'
alias projects='cd ~/projects'
alias avtools='cd ~/projects/arc-av-tools'
alias pdftools='cd ~/projects/pdf-tools'
alias caltools='cd ~/projects/calendar-tools'
alias invoices='cd ~/projects/invoice-tools'
alias mediatools='cd ~/projects/media-tools'
alias archive='cd ~/projects/archive'

# System
alias reload='source ~/.zshrc'
alias zshconfig='nano ~/.zshrc'
alias cheat='cat ~/projects/arc-events/TERMINAL_CHEATSHEET.md'
alias cheatsheet='cat ~/projects/arc-events/TERMINAL_CHEATSHEET.md'

# ============================================================================
# History Settings
# ============================================================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
alias checkbg='python3 /Users/michaelgodinez/projects/check_background_tasks.py'

# Clipboard sync with Mac mini
alias clip-to-mini='pbpaste | ssh mini pbcopy'
alias clip-from-mini='ssh mini pbpaste | pbcopy'


# Mac mini automation helpers
alias mini-sync='rsync -av --exclude ".git" --exclude "__pycache__" --exclude "*.pyc" ~/projects/arc-events/ mini:~/projects/arc-events/'

# Run Python scripts on mini
mini-py() {
    if [ -z "$1" ]; then
        echo "Usage: mini-py <script.py> [args...]"
        return 1
    fi
    ssh mini "cd ~/projects/arc-events && python3 $@"
}

# Run Python scripts on mini in background
mini-py-bg() {
    if [ -z "$1" ]; then
        echo "Usage: mini-py-bg <script.py> [args...]"
        return 1
    fi
    ssh mini "cd ~/projects/arc-events && nohup python3 $@ > ~/mini-py-bg.log 2>&1 &"
    echo "Script running in background on mini. Check with: mini-log"
}

# View mini background log
alias mini-log='ssh mini "tail -f ~/mini-py-bg.log"'
alias mini-log-full='ssh mini "cat ~/mini-py-bg.log"'

# Mini system status
alias mini-status='ssh mini "uptime && df -h / && free -h 2>/dev/null || vm_stat"'

