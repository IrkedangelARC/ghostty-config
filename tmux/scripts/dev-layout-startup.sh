#!/bin/bash
# Tmux Dev Layout Auto-Startup Script
# This script automatically creates the three-pane Claude Code workflow layout
#
# Usage:
# 1. Make executable: chmod +x ~/.tmux/scripts/dev-layout-startup.sh
# 2. Add to shell rc file (.zshrc or .bashrc):
#    if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#        ~/.tmux/scripts/dev-layout-startup.sh
#    fi

# Check if we're already in a tmux session
if [ -n "$TMUX" ]; then
    echo "Already in a tmux session"
    exit 0
fi

# Session name for the dev layout
SESSION_NAME="dev"

# Check if the session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? != 0 ]; then
    # Session doesn't exist, create it with the dev layout

    # Create new session detached
    tmux new-session -d -s "$SESSION_NAME" -c "$HOME/projects"

    # Split right (50% width for editor/output panes)
    tmux split-window -h -p 50 -t "$SESSION_NAME:1" -c "#{pane_current_path}"

    # Select right pane and split it vertically (40% height for output pane)
    tmux select-pane -t "$SESSION_NAME:1.1" -R
    tmux split-window -v -p 40 -t "$SESSION_NAME:1" -c "#{pane_current_path}"

    # Return focus to the left pane (Claude Code)
    tmux select-pane -t "$SESSION_NAME:1.0" -L

    # Optional: Start applications in specific panes
    # Uncomment and customize these lines based on your workflow:

    # Start Claude Code in left pane
    # tmux send-keys -t "$SESSION_NAME:1.0" "claude" C-m

    # Start your editor in top-right pane (examples for different editors)
    # For nvim:
    # tmux send-keys -t "$SESSION_NAME:1.1" "nvim" C-m
    # For vim:
    # tmux send-keys -t "$SESSION_NAME:1.1" "vim" C-m
    # For emacs:
    # tmux send-keys -t "$SESSION_NAME:1.1" "emacs -nw" C-m

    # Keep bottom-right pane as a regular shell for output/logs/tests
    # (no command needed, it's already a shell)
fi

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
