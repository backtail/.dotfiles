#!/usr/bin/env bash

RECENT_FILE="$HOME/.local/share/recently-used.xbel"

# Read entire file
mapfile -t lines < "$RECENT_FILE"

declare -a ordered_filenames ordered_fullpaths

for i in "${!lines[@]}"; do
    line="${lines[$i]}"
    if [[ $line =~ href=\"file://([^\"]+)\" ]]; then
        url="${BASH_REMATCH[1]}"
        fullpath=$(printf '%b' "${url//%/\\x}")
        
        # Check if it's a directory by looking at the bookmark block
        is_dir=false
        for ((j=i; j<i+10 && j<${#lines[@]}; j++)); do
            if [[ "${lines[$j]}" =~ inode/directory ]]; then
                is_dir=true
                break
            fi
            [[ "${lines[$j]}" =~ \</bookmark\> ]] && break
        done
        
        [[ $is_dir = true ]] && continue
        
        if [[ -f "$fullpath" ]]; then
            filename=$(basename "$fullpath")
            ordered_filenames+=("$filename")
            ordered_fullpaths+=("$fullpath")
        fi
    fi
done

# REVERSE THE ARRAYS so newest is first
declare -a reversed_filenames reversed_fullpaths
for ((i=${#ordered_filenames[@]}-1; i>=0; i--)); do
    reversed_filenames+=("${ordered_filenames[$i]}")
    reversed_fullpaths+=("${ordered_fullpaths[$i]}")
done

ordered_filenames=("${reversed_filenames[@]}")
ordered_fullpaths=("${reversed_fullpaths[@]}")

# Now remove duplicates, keeping first occurrence (which is now newest)
declare -A seen
declare -a unique_filenames unique_fullpaths

for ((i=0; i<${#ordered_filenames[@]}; i++)); do
    filename="${ordered_filenames[$i]}"
    fullpath="${ordered_fullpaths[$i]}"
    
    if [[ -z "${seen[$filename]}" ]]; then
        unique_filenames+=("$filename")
        unique_fullpaths+=("$fullpath")
        seen["$filename"]=1
    fi
done

# Display newest first
if [ ${#unique_filenames[@]} -eq 0 ]; then
    exit 0
fi

SELECTED_NAME=$(printf '%s\n' "${unique_filenames[@]}" | \
    fuzzel --dmenu --lines=20 --prompt="Recent Files (${#unique_filenames[@]}): ")

if [ -n "$SELECTED_NAME" ]; then
    for i in "${!unique_filenames[@]}"; do
        if [[ "${unique_filenames[$i]}" = "$SELECTED_NAME" ]]; then
            xdg-open "${unique_fullpaths[$i]}"
            break
        fi
    done
fi
