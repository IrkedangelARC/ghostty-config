#!/bin/bash
# System uptime and load average for tmux (macOS)
# Shows uptime and load with UP: and LOAD: labels

# Get uptime in a clean format
uptime_info=$(uptime | awk '{print $3}' | tr -d ',')

# Get load average (1-minute)
load_avg=$(uptime | awk -F'load averages:' '{print $2}' | awk '{print $1}')

# Format output with labels
echo "UP: ${uptime_info}d LOAD: ${load_avg}"
