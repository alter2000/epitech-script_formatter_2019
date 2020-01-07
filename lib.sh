#!/usr/bin/env bash

readonly DEFAULT_HEADER="$(cat <<EOF
# something for a header idk
EOF
)"

export DEFAULT_HEADER

source ./parse.sh

help()
{
    cat <<EOF
Usage:	script_formatter.sh in [-h] [-s] [-i nb_char] [-e] [-o out]

    in	input file
    -h, --header	header generation
    -s, --spaces	force spaces instead of tabulations for indentation
    -i, --indentation=nb_char	number of characters for indentation (8 by default)
    -e, --expand	force do and then keywords on new lines
    -o, --output=out	output file (stdout by default)
EOF
}

repeat()
{
    set -f
    for _ in $(seq 1 "$2"); do
        printf "%s" "$1"
    done
    set +f
}
