#!/usr/bin/env bash

makoctl dismiss -g 2>/dev/null || true

# Function with pkexec
run_tlp() {
    pkexec tlp "$@"
}

# Main menu
CHOICE=$(echo -e "Full Charge\n40-80%\n60-90%\n45-50%" | \
    fuzzel --dmenu --lines=4 --prompt="Battery: ")

case "$CHOICE" in
    "Full Charge")
        pkexec tlp fullcharge && notify-send "Battery" "Full charging enabled"
        ;;
    "20-80%")
        pkexec tlp setcharge 20 80 && notify-send "Battery" "Set to 20-80%"
        ;;
    "60-90%")
        pkexec tlp setcharge 60 90 && notify-send "Battery" "Set to 60-90%"
        ;;
    "45-50%")
        pkexec tlp setcharge 45 50 && notify-send "Battery" "Set to 45-50%"
        ;;
esac
