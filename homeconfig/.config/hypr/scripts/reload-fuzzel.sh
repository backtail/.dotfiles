#!/bin/bash

source "${HOME}/.cache/wal/colors.sh"

FUZZEL_CONFIG="${HOME}/.config/fuzzel/colors.ini"

sed -i \
    -e "s/background=[a-fA-F0-9]*/background=${background#\#}AA/" \
    -e "s/text=[a-fA-F0-9]*/text=${foreground#\#}FF/" \
    -e "s/match=[a-fA-F0-9]*/match=${color5#\#}FF/" \
    -e "s/input=[a-fA-F0-9]*/input=${foreground#\#}FF/" \
    -e "s/prompt=[a-fA-F0-9]*/prompt=${color9#\#}FF/" \
    -e "s/selection=[a-fA-F0-9]*/selection=${color1#\#}99/" \
    -e "s/selection-text=[a-fA-F0-9]*/selection-text=${foreground#\#}FF/" \
    -e "s/selection-match=[a-fA-F0-9]*/selection-match=${color5#\#}FF/" \
    "$FUZZEL_CONFIG"

echo "Fuzzel colors reloaded."
