#!/bin/bash
# CPU usage script for tmux (macOS)
# Shows CPU usage percentage with CPU: label

# Get CPU usage using top (fast method for macOS)
# top -l 1 runs once, we grab CPU idle from the output
cpu_line=$(top -l 1 | grep "CPU usage:")

# Extract idle percentage and calculate usage
cpu_idle=$(echo "$cpu_line" | awk '{print $7}' | tr -d '%')
cpu_usage=$(echo "100 - $cpu_idle" | bc | awk '{printf "%.0f", $1}')

# Validate we got a number, otherwise show 0%
if ! [[ "$cpu_usage" =~ ^[0-9]+$ ]]; then
    cpu_usage="0"
fi

# Format output with CPU: label
echo "CPU: ${cpu_usage}%"
