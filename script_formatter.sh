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

    TMP="$(getopt -o ":hsi:eo:" \
            --long "header,spaces,indentation:,expand,output:" -- "$@")"
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

    # parse "$(<"$file")"
    cp cmds.vim cmdready.vim
    if [ "$HEADER" != "none" ]; then
        sed -i "s/HEADER/$HEADER/" cmdready.vim
    else
        sed -i "s/qp.*$/\n/" cmdready.vim
    fi
    if [ -n "$SPACES" ]; then
        sed -i 's/:set noexpandtab/:set expandtab/' cmdready.vim
    fi
    if [ "$EXPAND" = "true" ]; then
        sed -Ei \
            's/BERRY_COMBOLUTED_DO_NOT_CHANGE_DO_REGEX/\<do\>/' \
            's/BERRY_COMBOLUTED_DO_NOT_CHANGE_THEN_REGEX/\<then\>/' \
            's/EXPAND_BERRY_COMBOLUTED_DO_NOT_CHANGE_DO_REGEX/\ndo/' \
            's/EXPAND_BERRY_COMBOLUTED_DO_NOT_CHANGE_THEN_REGEX/\nthen/' \
            cmdready.vim
    fi
    if [ "$INDENT" != 8 ]; then
        sed -i "s/8/$INDENT/g" cmdready.vim
    fi
    sed -i "s,FILE,$OUT," cmdready.vim
    cat cmdready.vim >/dev/stderr
    vim --clean -s cmdready.vim -E "$file" +'w /dev/stdout' 2>/dev/stderr 1>&2
}

main "$@"
