#!/bin/bash
# Git status script for tmux - shows detailed git information
# Usage: git-status.sh [path]

cd "${1:-.}" 2>/dev/null || exit 1

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "─"
    exit 0
fi

# Get branch name
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -z "$branch" ]; then
    echo "─"
    exit 0
fi

# Get ahead/behind count
upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
if [ -n "$upstream" ]; then
    ahead_behind=$(git rev-list --left-right --count HEAD...$upstream 2>/dev/null)
    ahead=$(echo "$ahead_behind" | awk '{print $1}')
    behind=$(echo "$ahead_behind" | awk '{print $2}')
else
    ahead=0
    behind=0
fi

# Count dirty files (modified, added, deleted)
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

# Count stashes
stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')

# Build status string
status=""

# Branch name
status+="$branch"

# Ahead/behind indicators
if [ "$ahead" -gt 0 ]; then
    status+=" ↑$ahead"
fi
if [ "$behind" -gt 0 ]; then
    status+=" ↓$behind"
fi

# Dirty files
if [ "$dirty" -gt 0 ]; then
    status+=" ●$dirty"
fi

# Stashes
if [ "$stashes" -gt 0 ]; then
    status+=" ✦$stashes"
fi

echo "$status"
