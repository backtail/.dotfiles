#!/usr/bin/env bash
# Recursive `git status` (including sub-modules)
# found here: https://gist.github.com/dbu/2843660 

set -e

status_ops="$*"

find . -name '.git' \
	| while read -r repo
do
	repo=${repo//\.git/}
	git -C "$repo" status -s \
		| grep -q -v "^\$" \
		&& echo -e "\n\033[1m${repo}\033[m" \
		&& git -C "$repo" status $status_ops \
		|| true
done
