#!/bin/bash
# Creates a demo of the dev layout with labeled panes
# Usage: tmux && ~/.tmux/scripts/create-demo-layout.sh

if [ -z "$TMUX" ]; then
    echo "Error: Must be run inside a tmux session"
    echo "Usage: tmux"
    echo "Then run: ~/.tmux/scripts/create-demo-layout.sh"
    exit 1
fi

# Create the dev layout (same as Ctrl-a d)
tmux split-window -h -p 50 -c "#{pane_current_path}"
tmux select-pane -R
tmux split-window -v -p 40 -c "#{pane_current_path}"
tmux select-pane -L

# Send demo text to each pane to show the layout
tmux send-keys -t :.0 "clear && cat << 'EOF'
╔═══════════════════════════════════════╗
║                                       ║
║        CLAUDE CODE PANE               ║
║        (Left - 50% width)             ║
║                                       ║
╚═══════════════════════════════════════╝

This is where you run Claude Code.

Commands to navigate from here:
  Ctrl-a l  →  Go to editor (right)
  Ctrl-a j  →  Go to output (bottom-right)

Try it now!
EOF
" C-m

tmux send-keys -t :.1 "clear && cat << 'EOF'
╔═══════════════════════════════════════╗
║                                       ║
║     EDITOR PANE                       ║
║     (Top-Right - 50% width, 60% ht)   ║
║                                       ║
╚═══════════════════════════════════════╝

This is where you edit code.
Launch: vim, nvim, emacs, nano, etc.

Commands from here:
  Ctrl-a h  →  Go to Claude (left)
  Ctrl-a j  →  Go to output (below)
  Ctrl-a e  →  Zoom this pane

Try: vim test.txt
EOF
" C-m

tmux send-keys -t :.2 "clear && cat << 'EOF'
╔═══════════════════════════════════════╗
║     OUTPUT / LOGS / TESTS PANE        ║
║     (Bottom-Right - 50% width, 40%)   ║
╚═══════════════════════════════════════╝

This is where you run commands and see output.

Examples:
  • npm test
  • python test.py
  • cargo run
  • tail -f logs/app.log

Commands from here:
  Ctrl-a h  →  Go to Claude (left)
  Ctrl-a k  →  Go to editor (above)
  Ctrl-a Shift-O  →  Zoom this pane

Try: ls -la
EOF
" C-m

# Return to Claude pane
tmux select-pane -t :.0

echo ""
echo "✅ Demo layout created!"
echo ""
echo "Navigate with:"
echo "  Ctrl-a h/j/k/l  (vim-style)"
echo ""
echo "Resize with:"
echo "  Ctrl-a Shift-H/J/K/L  (fine)"
echo "  Ctrl-a Shift-Arrow    (coarse)"
echo ""
echo "See full guide: cat ~/.tmux/TMUX_DEV_LAYOUT_GUIDE.md"
