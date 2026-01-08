#!/bin/bash

# --- Zsh History Cleanup Script ---
# This script removes duplicate entries from your Zsh history file (.histfile).
# It preserves the order of the first occurrence of each unique command.

# Default Zsh history file location. Adjust if yours is different.
HISTFILE="${ZDOTDIR:-$HOME}/.histfile"

# Check if the history file exists
if [ ! -f "$HISTFILE" ]; then
    echo "Error: History file not found at $HISTFILE"
    echo "Please ensure you're running this script where your .zsh_history file exists or update the HISTFILE variable."
    exit 1
fi

echo "--- Zsh History Cleanup ---"
echo "History file: $HISTFILE"

# Create a backup of the current history file
BACKUP_HISTFILE="${HISTFILE}.$(date +%Y%m%d%H%M%S).bak"
cp "$HISTFILE" "$BACKUP_HISTFILE"
echo "Backup created: $BACKUP_HISTFILE"

# Process the history file to remove duplicates
# Using awk to extract commands and store unique ones.
# The Zsh history format is typically ": <timestamp>:<history_length>;<command>"
# We want to ignore the ": <timestamp>:<history_length>;" part.
#
# Explanation of awk command:
#   - FS=';': Sets the field separator to a semicolon. This helps us split the line
#             into the timestamp/length part and the command part.
#   - /^: [0-9]+:[0-9]+;/: Matches lines that start with the Zsh history prefix.
#   - seen[$2]++: Uses the second field (the command) as an index in an associative array 'seen'.
#                 If the command hasn't been seen before, seen[$2] will be 0, and ++ makes it 1.
#                 The '!' negates this, so it's true only for the first occurrence.
#   - { print $0 } : Prints the entire line for unique entries.
#   - !/^\#/: Filters out lines that start with '#' (comments, if any, though rare in default hist).
#   - Alternatively, for simpler history formats, `awk '!a[$0]++'` might work,
#     but the Zsh format needs special handling.

# This awk command handles the specific Zsh history format where
# each entry starts with `: <timestamp>:<length>;<command>`
# It uses the command part (field 2 after splitting by ';') for uniqueness.
# It also includes the full original line, including the timestamp, for unique entries.
awk -F';' '
    /^\: [0-9]+:[0-9]+;/ { # Only process lines that look like Zsh history entries
        cmd = substr($0, index($0, ";") + 1); # Extract the command part after the first semicolon
        if (!(cmd in seen)) {
            print $0; # Print the full line if the command is not yet seen
            seen[cmd] = 1; # Mark the command as seen
        }
    }
    !/^\: [0-9]+:[0-9]+;/ { # For lines that are not in the standard Zsh history format (e.g., old entries or corrupted)
        if (!($0 in seen)) {
            print $0; # Print the full line if the line itself is unique
            seen[$0] = 1; # Mark the full line as seen
        }
    }
' "$HISTFILE" > "${HISTFILE}.new"

# Replace the original history file with the new, cleaned version
mv "${HISTFILE}.new" "$HISTFILE"
echo "History cleaned successfully. Unique entries are now in $HISTFILE"

# Inform the user to restart Zsh or reload history
echo ""
echo "To see the changes, you may need to:"
echo "  1. Open a new Zsh terminal, OR"
echo "  2. In your current Zsh session, run: history -R"
echo ""
echo "The backup file is located at: $BACKUP_HISTFILE"

