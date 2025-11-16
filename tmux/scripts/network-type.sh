#!/bin/bash
# Network connection type detection for tmux (macOS)
# Shows: Ethernet, Wi-Fi (with network name), VPN, or offline status

# Check VPN first (highest priority for live streaming awareness)
vpn_active=""
# Check common VPN interfaces: utun (macOS built-in VPN), ppp (legacy), ipsec
if ifconfig | grep -E "utun[0-9]:|ppp[0-9]:|ipsec[0-9]:" | grep -q "inet"; then
    vpn_active="🔒VPN"
fi

# Get default route interface
default_if=$(route get default 2>/dev/null | grep interface | awk '{print $2}')

if [ -z "$default_if" ]; then
    # No default route - offline
    if [ -n "$vpn_active" ]; then
        echo "NET: $vpn_active (no route)"
    else
        echo "NET: ⚠️ offline"
    fi
    exit 0
fi

# Determine connection type based on interface name
connection_type=""
network_name=""

case "$default_if" in
    en0|en1|en2|en3|en4|en5)
        # Could be Wi-Fi or Ethernet - need to check
        # Check if it's a Wi-Fi interface by seeing if we can get SSID
        ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I 2>/dev/null | awk '/ SSID/ {print $2}')

        if [ -n "$ssid" ] && [ "$ssid" != "SSID" ]; then
            # Wi-Fi connection
            connection_type="📡$ssid"
        else
            # Likely Ethernet (or Wi-Fi not associated)
            # Check if interface is up and has carrier
            if ifconfig "$default_if" 2>/dev/null | grep -q "status: active"; then
                connection_type="🔌ETH"
            else
                connection_type="⚠️ $default_if"
            fi
        fi
        ;;
    bridge*|vlan*)
        connection_type="🔌ETH"
        ;;
    utun*|ppp*|ipsec*)
        connection_type="🔒VPN"
        ;;
    *)
        connection_type="❓$default_if"
        ;;
esac

# Build final output
output="NET: $connection_type"
if [ -n "$vpn_active" ] && [ "$connection_type" != "🔒VPN" ]; then
    output="$output + VPN"
fi

echo "$output"
