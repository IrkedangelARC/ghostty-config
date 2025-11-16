#!/bin/bash
# Active process monitoring script for tmux
# Shows status of key applications: DaVinci Resolve, Python scripts, ffmpeg

# Check for active processes
processes=()

# DaVinci Resolve
if pgrep -x "Resolve" > /dev/null 2>&1; then
    processes+=("🎬")
fi

# Python scripts (only show if there are Python processes running)
python_count=$(pgrep -x "python3" 2>/dev/null | wc -l | tr -d ' ')
if [ "$python_count" -gt 0 ]; then
    processes+=("🐍$python_count")
fi

# ffmpeg processes
ffmpeg_count=$(pgrep -x "ffmpeg" 2>/dev/null | wc -l | tr -d ' ')
if [ "$ffmpeg_count" -gt 0 ]; then
    processes+=("🎞️$ffmpeg_count")
fi

# Build output
if [ ${#processes[@]} -eq 0 ]; then
    echo "PROC: ─"
else
    # Join array elements with space
    output=$(IFS=' '; echo "${processes[*]}")
    echo "PROC: $output"
fi
