#!/usr/bin/env bash
# entry point for formatter_2019

source ./lib.sh

declare INDENT
declare OUT
declare EXPAND

INDENT="$(repeat ' ' 8)"
OUT="/dev/stdout"
EXPAND="false"

main()
{
    while getopts ":hsi:eo:" opt; do
        case "$opt" in
            h)
                help
            ;;
            s)
                echo lol
            ;;
            i)
                INDENT=$(repeat ' ' "$OPTARG")
                echo lol
            ;;
            e)
                EXPAND="true"
                echo expandong
            ;;
            o)
                OUT="$(OPTARG)"
                echo weebs
            ;;
            *) printf "idk wrong?"
        esac
    done

}

main "$@"
