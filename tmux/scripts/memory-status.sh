#!/bin/bash
# Memory status script for tmux (macOS)
# Shows RAM usage percentage and available memory with RAM: label

# Get memory info using vm_stat (macOS specific)
vm_stat_output=$(vm_stat)

# Parse pages (page size is 4096 bytes on macOS)
page_size=$(pagesize)
pages_free=$(echo "$vm_stat_output" | grep "Pages free" | awk '{print $3}' | tr -d '.')
pages_active=$(echo "$vm_stat_output" | grep "Pages active" | awk '{print $3}' | tr -d '.')
pages_inactive=$(echo "$vm_stat_output" | grep "Pages inactive" | awk '{print $3}' | tr -d '.')
pages_speculative=$(echo "$vm_stat_output" | grep "Pages speculative" | awk '{print $3}' | tr -d '.')
pages_wired=$(echo "$vm_stat_output" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')

# Calculate used and free memory
used_pages=$((pages_active + pages_wired))
free_pages=$((pages_free + pages_inactive + pages_speculative))
total_pages=$((used_pages + free_pages))

# Calculate percentage
if [ "$total_pages" -gt 0 ]; then
    used_percent=$((used_pages * 100 / total_pages))
else
    used_percent=0
fi

# Convert free pages to GB
free_gb=$(echo "scale=1; $free_pages * $page_size / 1073741824" | bc)

# Format output with RAM: label
echo "RAM: ${used_percent}% (${free_gb}G free)"
