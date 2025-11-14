#!/bin/bash
# Python virtual environment status for tmux
# Shows active venv name if one is activated

if [ -n "$VIRTUAL_ENV" ]; then
    venv_name=$(basename "$VIRTUAL_ENV")
    echo "🐍 $venv_name"
else
    echo "─"
fi
