#!/bin/bash
_pass()
{
	local cur prev prefix suffix gen
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	prefix="$HOME/.password-store/"
	suffix=".gpg"

	if [[ $prev == --* ]]; then
		return 0
	fi
	
	for item in $(compgen -f $prefix$cur); do
		if [[ $item == $prefix.* ]]; then
			continue
		fi
		if [[ -d $item ]]; then
			item="$item/"
		fi
		item="${item%$suffix}"
		gen="$gen ${item#$prefix}"
	done

	COMPREPLY=( $gen )
}
complete -o filenames -o nospace -F _pass pass
