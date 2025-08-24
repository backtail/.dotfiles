#!/bin/bash

# Path to the wal colors file
WAL_COLORS_FILE="$HOME/.cache/wal/colors.css"
# Path to your GTK theme colors file
GTK_COLORS_FILE="$HOME/.themes/Gax/gtk-3.0/colors.css"

# Check if the wal colors file exists
if [ ! -f "$WAL_COLORS_FILE" ]; then
    echo "Error: Wal colors file not found at $WAL_COLORS_FILE"
    echo "Please run 'wal' first to generate a scheme."
    exit 1
fi

# Extract the color values using sed
BACKGROUND=$(sed -n 's/.*--background: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
FOREGROUND=$(sed -n 's/.*--foreground: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR0=$(sed -n 's/.*--color0: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR1=$(sed -n 's/.*--color1: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR2=$(sed -n 's/.*--color2: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR3=$(sed -n 's/.*--color3: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR4=$(sed -n 's/.*--color4: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR5=$(sed -n 's/.*--color5: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR6=$(sed -n 's/.*--color6: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR7=$(sed -n 's/.*--color7: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR8=$(sed -n 's/.*--color8: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR9=$(sed -n 's/.*--color9: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR10=$(sed -n 's/.*--color10: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR11=$(sed -n 's/.*--color11: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR12=$(sed -n 's/.*--color12: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR13=$(sed -n 's/.*--color13: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR14=$(sed -n 's/.*--color14: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")
COLOR15=$(sed -n 's/.*--color15: \([^;]*\);.*/\1/p' "$WAL_COLORS_FILE")


# Verify we got some values
if [ -z "$BACKGROUND" ]; then
    echo "Error: Could not extract colors from wal file."
    exit 1
fi

# Map the wal colors to your GTK theme variables
cat > "$GTK_COLORS_FILE" << EOF
/* This file is auto-generated from wal colors. Do not edit directly. */

@define-color theme_bg_color $BACKGROUND;
@define-color theme_fg_color $FOREGROUND;
@define-color theme_selected_bg_color $COLOR2;
@define-color theme_selected_fg_color $FOREGROUND;
@define-color theme_base_color $BACKGROUND;
@define-color theme_text_color $FOREGROUND;
EOF

echo "Successfully updated GTK theme colors from wal!"
echo "File written to: $GTK_COLORS_FILE"

if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface gtk-theme 'Default'
    sleep 0.5
    gsettings set org.gnome.desktop.interface gtk-theme 'Gax'
    echo "GTK theme reloaded."
else
    echo "gsettings not found. Please reload your theme manually."
fi
