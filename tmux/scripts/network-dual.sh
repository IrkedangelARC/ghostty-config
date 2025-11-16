#!/bin/bash
# Dual network monitoring for tmux (macOS)
# Shows separate WiFi (en1) and Ethernet (en14) upload/download speeds

# Cache file for previous stats
cache_file="/tmp/tmux-net-dual-stats-$(whoami)"

# Define interfaces
wifi_if="en1"
eth_if="en14"

# Get current network stats for both interfaces
get_interface_stats() {
    local iface=$1
    # Use netstat to get raw byte counts (column 7=rx, 10=tx)
    netstat -ib | awk -v iface="$iface" '$1 == iface && $3 ~ /^<Link/ {print $7,$10; exit}'
}

wifi_stats=$(get_interface_stats "$wifi_if")
wifi_rx=$(echo "$wifi_stats" | awk '{print $1}')
wifi_tx=$(echo "$wifi_stats" | awk '{print $2}')

eth_stats=$(get_interface_stats "$eth_if")
eth_rx=$(echo "$eth_stats" | awk '{print $1}')
eth_tx=$(echo "$eth_stats" | awk '{print $2}')

current_time=$(date +%s)

# If cache doesn't exist, create it and exit
if [ ! -f "$cache_file" ]; then
    echo "$current_time $wifi_rx $wifi_tx $eth_rx $eth_tx" > "$cache_file"
    echo "WiFi: ─ ─ │ ETH: ─ ─"
    exit 0
fi

# Read previous stats
read prev_time prev_wifi_rx prev_wifi_tx prev_eth_rx prev_eth_tx < "$cache_file"

# Calculate time difference
time_diff=$((current_time - prev_time))

# Avoid division by zero
if [ "$time_diff" -eq 0 ]; then
    echo "WiFi: ─ ─ │ ETH: ─ ─"
    exit 0
fi

# Calculate speeds (bytes per second)
wifi_rx_speed=$(( (wifi_rx - prev_wifi_rx) / time_diff ))
wifi_tx_speed=$(( (wifi_tx - prev_wifi_tx) / time_diff ))
eth_rx_speed=$(( (eth_rx - prev_eth_rx) / time_diff ))
eth_tx_speed=$(( (eth_tx - prev_eth_tx) / time_diff ))

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

wifi_down=$(format_speed $wifi_rx_speed)
wifi_up=$(format_speed $wifi_tx_speed)
eth_down=$(format_speed $eth_rx_speed)
eth_up=$(format_speed $eth_tx_speed)

# Update cache
echo "$current_time $wifi_rx $wifi_tx $eth_rx $eth_tx" > "$cache_file"

# Output both interfaces
echo "WiFi: ↓$wifi_down ↑$wifi_up │ ETH: ↓$eth_down ↑$eth_up"
