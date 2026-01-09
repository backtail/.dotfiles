#!/usr/bin/env bash

# Power menu script using fuzzel with icons

OPTIONS="󰐥 Poweroff\n󰜉 Reboot\n󰒲 Suspend\n󰗼 Logout\n󰌾 Lock"

CHOICE=$(echo -e "$OPTIONS" | fuzzel --dmenu --lines=5)

# Execute the chosen command
case "$CHOICE" in
    *Poweroff*)
        systemctl poweroff
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Logout*)
        loginctl kill-user "$USER"
        ;;
    *Lock*)
        hyprlock
        ;;
esac
