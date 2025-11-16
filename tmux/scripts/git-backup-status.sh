#!/bin/bash
# Git backup status script for tmux
# Shows unpushed commits and time since last push

# Navigate to home directory to check all git repos
# You can customize this to check specific project directories
check_dir="${1:-$(pwd)}"

# Change to the directory
cd "$check_dir" 2>/dev/null || { echo "GIT: ─"; exit 0; }

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "GIT: ─"
    exit 0
fi

# Get the current branch
branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")

# Count unpushed commits (commits ahead of remote)
upstream_branch=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
if [ -z "$upstream_branch" ]; then
    # No upstream branch configured
    echo "GIT: no remote"
    exit 0
fi

# Count commits ahead and behind
ahead=$(git rev-list --count HEAD@{upstream}..HEAD 2>/dev/null || echo "0")
behind=$(git rev-list --count HEAD..HEAD@{upstream} 2>/dev/null || echo "0")

# Check for uncommitted changes
uncommitted=""
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    uncommitted="*"
fi

# Get time since last push
last_push_date=$(git log @{push} -1 --format=%ct 2>/dev/null)
if [ -n "$last_push_date" ]; then
    current_time=$(date +%s)
    time_diff=$((current_time - last_push_date))

    # Convert to human readable
    if [ "$time_diff" -lt 3600 ]; then
        time_ago="$((time_diff / 60))m"
    elif [ "$time_diff" -lt 86400 ]; then
        time_ago="$((time_diff / 3600))h"
    else
        time_ago="$((time_diff / 86400))d"
    fi
else
    time_ago="?"
fi

# Build output
output="GIT:"

# Show uncommitted changes indicator
if [ -n "$uncommitted" ]; then
    output="$output ⚡"
fi

# Show ahead/behind counts
if [ "$ahead" -gt 0 ]; then
    output="$output ↑$ahead"
fi
if [ "$behind" -gt 0 ]; then
    output="$output ↓$behind"
fi

# Show time since last push if we have unpushed commits
if [ "$ahead" -gt 0 ]; then
    output="$output ${time_ago}"
fi

# If nothing to report, show clean status
if [ "$ahead" -eq 0 ] && [ "$behind" -eq 0 ] && [ -z "$uncommitted" ]; then
    output="GIT: ✓"
fi

echo "$output"
