#!/usr/bin/env bash

# entry point for formatter_2019

declare SPACES
declare INDENT
declare OUT
declare EXPAND
declare HEADER

SPACES=""
INDENT=8
OUT="/dev/stdout"
EXPAND="false"
HEADER="none"

main()
{
	# -help is speshul
	for i in "$@"; do
		if [ "$i" = "-help" ]; then
			help
			exit 0
		fi
	done

	TMP="$(getopt -o ":hsi:eo:" --long "header,spaces,indentation:,expand,output:" -- "$@")"
	if [ $? != 0 ] ; then
		echo "getopt failed, exiting" >&2
		exit 84
	fi

	eval set -- "$TMP"

	while true; do
		case "$1" in
			-h|--header)
				HEADER="$DEFAULT_HEADER"
				shift
				;;

			-s|--spaces)
				SPACES="true"
				shift
				;;

			-i|--indentation)
				INDENT="$2"
				shift 2
				;;

			-e|--expand)
				EXPAND="true"
				shift
				;;

			-o|--output)
				OUT="$2"
				shift 2
				;;

			-- )
				shift
				break
				;;
			*)
				printf "idk wrong?"
				echo "$@"
				break
				;;
		esac
	done

	file="$1"
	if [ -z "$file" ]; then
		echo "no file selected" >&2
		exit 84
	fi

	export SPACES
	export INDENT
	export OUT
	export EXPAND
	export HEADER

	vim --clean -s ./cmds.vim -E "$file" </dev/null || true
}

main "$@"
