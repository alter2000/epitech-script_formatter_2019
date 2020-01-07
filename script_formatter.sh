#!/usr/bin/env bash
# entry point for formatter_2019

source ./lib.sh
source ./parse.sh
source ./lint.sh

declare INDENT
declare OUT
declare EXPAND
declare HEADER

INDENT="$(repeat ' ' 8)"
OUT="/dev/stdout"
EXPAND="false"
HEADER="none"

main()
{
    TMP="$(getopt -o ":hsi:eo:" \
            --long "help,header,spaces,indentation:,expand,output:" -- "$@")"
    if [ $? != 0 ] ; then
        echo "getopt failed, exiting" >&2
        exit 84
    fi

    eval set -- "$TMP"

    while true; do
        case "$1" in
            -h|--header)
                HEADER="$DEFAULT_HEADER"
                echo hyer
                shift
            ;;
            -s|--spaces)
                echo lol
                shift
            ;;
            -i|--indentation)
                INDENT=$(repeat ' ' "$2")
                echo lol "$INDENT"
                shift 2
            ;;
            -e|--expand)
                EXPAND="true"
                echo expandong "$EXPAND"
                shift
            ;;
            -o|--output)
                OUT="$2"
                echo weebs "$OUT"
                shift 2
            ;;
            --help)
                help
                exit 0
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

    parse "$(<"$file")"
}

main "$@"
