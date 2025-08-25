#!/bin/bash

POWER_FILE=""
STATUS_FILE=""
for file in /sys/class/power_supply/*/power_now; do
    if [ -f "$file" ]; then
        POWER_FILE="$file"
        # Find the corresponding status file in the same directory
        SUPPLY_DIR=$(dirname "$file")
        STATUS_FILE="${SUPPLY_DIR}/status"
        break
    fi
done

if [ -z "$POWER_FILE" ]; then
    echo "{\"percentage\": 0.0, \"status\": \"unknown\"}"
    exit 1
fi

POWER_UW=$(cat "$POWER_FILE" 2>/dev/null)
BATTERY_STATUS=$(cat "$STATUS_FILE" 2>/dev/null)

if [[ "$POWER_UW" =~ ^[0-9]+$ ]]; then
    WHOLE_WATTS=$((POWER_UW / 1000000))
    REMAINDER=$((POWER_UW % 1000000))
    TENTHS=$((REMAINDER * 10 / 1000000))
    
    # Determine the sign based on charging/discharging status
    if [ "$BATTERY_STATUS" = "Charging" ]; then
        SIGN="+"
    elif [ "$BATTERY_STATUS" = "Discharging" ]; then
        SIGN="-"
    else
        SIGN=""  # Unknown or other status
    fi
    
    echo "{\"percentage\": ${WHOLE_WATTS}.${TENTHS}, \"sign\": \"${SIGN}\", \"status\": \"${BATTERY_STATUS}\"}"
else
    echo "{\"percentage\": 0.0, \"sign\": \"\", \"status\": \"unknown\"}"
fi
