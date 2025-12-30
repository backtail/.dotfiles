#!/bin/sh

# Battery script for ThinkPad with power_now support
battery_path="/sys/class/power_supply/BAT0"

if [ ! -d "$battery_path" ]; then
    echo '{"text": "󰂑", "tooltip": "No battery", "class": "error"}'
    exit 0
fi

# Read basic info
capacity=$(cat "$battery_path/capacity" 2>/dev/null)
status=$(cat "$battery_path/status" 2>/dev/null)

# Default values if reading fails
[ -z "$capacity" ] && capacity="0"
[ -z "$status" ] && status="Unknown"

# Get power in watts from power_now (in μW)
wattage_str=""
if [ -f "$battery_path/power_now" ]; then
    power_now=$(cat "$battery_path/power_now" 2>/dev/null)
    
    # Check if it's a valid number
    if echo "$power_now" | grep -q '^[0-9][0-9]*$' && [ "$power_now" -gt 0 ]; then
        # Convert μW to W with 1 decimal place
        # Method: multiply by 10, divide by 10000000 to get tenths of watts
        watts_tenths=$((power_now * 10 / 1000000))
        watts_whole=$((watts_tenths / 10))
        watts_tenth=$((watts_tenths % 10))
        
        if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
            if [ "$watts_tenth" -eq 0 ]; then
                wattage_str="+${watts_whole}W"
            else
                wattage_str="+${watts_whole}.${watts_tenth}W"
            fi
        else
            if [ "$watts_tenth" -eq 0 ]; then
                wattage_str="-${watts_whole}W"
            else
                wattage_str="-${watts_whole}.${watts_tenth}W"
            fi
        fi
    fi
fi

# Choose battery icon
if [ "$status" = "Charging" ]; then
    # Charging icons
    if [ "$capacity" -ge 95 ]; then icon="󰂅"
    elif [ "$capacity" -ge 90 ]; then icon="󰂋"
    elif [ "$capacity" -ge 80 ]; then icon="󰂊"
    elif [ "$capacity" -ge 70 ]; then icon="󰂉"
    elif [ "$capacity" -ge 60 ]; then icon="󰂈"
    elif [ "$capacity" -ge 50 ]; then icon="󰂆"
    elif [ "$capacity" -ge 40 ]; then icon="󰂇"
    elif [ "$capacity" -ge 30 ]; then icon="󰂆"
    elif [ "$capacity" -ge 20 ]; then icon="󰂅"
    elif [ "$capacity" -ge 10 ]; then icon="󰂄"
    else icon="󰢟"
    fi
elif [ "$status" = "Full" ]; then
    icon="󱊣"
    wattage_str=""  # Don't show wattage when full
else
    # Discharging icons
    if [ "$capacity" -ge 95 ]; then icon="󰁹"
    elif [ "$capacity" -ge 90 ]; then icon="󰂂"
    elif [ "$capacity" -ge 80 ]; then icon="󰂁"
    elif [ "$capacity" -ge 70 ]; then icon="󰂀"
    elif [ "$capacity" -ge 60 ]; then icon="󰁿"
    elif [ "$capacity" -ge 50 ]; then icon="󰁾"
    elif [ "$capacity" -ge 40 ]; then icon="󰁽"
    elif [ "$capacity" -ge 30 ]; then icon="󰁼"
    elif [ "$capacity" -ge 20 ]; then icon="󰁻"
    elif [ "$capacity" -ge 10 ]; then icon="󰁺"
    else icon="󰂎"
    fi
fi

# Determine CSS class
if [ "$capacity" -le 10 ] && [ "$status" != "Charging" ]; then
    class="critical"
elif [ "$capacity" -le 20 ] && [ "$status" != "Charging" ]; then
    class="warning"
elif [ "$status" = "Charging" ]; then
    class="charging"
elif [ "$status" = "Full" ]; then
    class="full"
else
    class="normal"
fi

# Create output
if [ -n "$wattage_str" ]; then
    text="$icon ${capacity}% $wattage_str"
    # Get voltage for tooltip if available
    voltage_info=""
    if [ -f "$battery_path/voltage_now" ]; then
        voltage_now=$(cat "$battery_path/voltage_now" 2>/dev/null)
        if echo "$voltage_now" | grep -q '^[0-9][0-9]*$'; then
            # Convert μV to V with 2 decimal places
            volts_hundredths=$((voltage_now * 100 / 1000000))
            volts_whole=$((volts_hundredths / 100))
            volts_hundredth=$((volts_hundredths % 100))
            if [ "$volts_hundredth" -lt 10 ]; then
                voltage_info="\nVoltage: ${volts_whole}.0${volts_hundredth}V"
            else
                voltage_info="\nVoltage: ${volts_whole}.${volts_hundredth}V"
            fi
        fi
    fi
    tooltip="Status: $status\nCapacity: ${capacity}%\nPower: $wattage_str${voltage_info}"
else
    text="$icon ${capacity}%"
    tooltip="Status: $status\nCapacity: ${capacity}%"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
