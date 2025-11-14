#!/bin/bash
# Network status script for tmux (macOS)
# Shows upload/download speeds with NET: label

# Cache file for previous stats
cache_file="/tmp/tmux-net-stats-$(whoami)"

# Auto-detect the active network interface
interface=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
if [ -z "$interface" ]; then
    interface="en0"  # fallback
fi

# Get current network stats from the active interface
# Use the first line that matches the interface and contains Link (raw stats)
# Add space after interface name to avoid matching en1 in en10, en11, etc.
current_stats=$(netstat -ib | awk -v iface="$interface" '$1 == iface && $3 ~ /^<Link/ {print $7,$10; exit}')
rx_bytes=$(echo "$current_stats" | awk '{print $1}')
tx_bytes=$(echo "$current_stats" | awk '{print $2}')
current_time=$(date +%s)

# If cache doesn't exist, create it and exit
if [ ! -f "$cache_file" ]; then
    echo "$current_time $rx_bytes $tx_bytes" > "$cache_file"
    echo "NET: ─ ─"
    exit 0
fi

# Read previous stats
read prev_time prev_rx prev_tx < "$cache_file"

# Calculate time difference
time_diff=$((current_time - prev_time))

# Avoid division by zero
if [ "$time_diff" -eq 0 ]; then
    echo "NET: ─ ─"
    exit 0
fi

# Calculate speeds (bytes per second)
rx_speed=$(( (rx_bytes - prev_rx) / time_diff ))
tx_speed=$(( (tx_bytes - prev_tx) / time_diff ))

# Format speeds
format_speed() {
    local speed=$1
    if [ "$speed" -lt 0 ]; then
        echo "─"
    elif [ "$speed" -lt 1024 ]; then
        echo "${speed}B/s"
    elif [ "$speed" -lt 1048576 ]; then
        echo "$(( speed / 1024 ))K/s"
    else
        echo "$(( speed / 1048576 ))M/s"
    fi
}

down_str=$(format_speed $rx_speed)
up_str=$(format_speed $tx_speed)

# Update cache
echo "$current_time $rx_bytes $tx_bytes" > "$cache_file"

# Output with NET: label
echo "NET: ↓$down_str ↑$up_str"
