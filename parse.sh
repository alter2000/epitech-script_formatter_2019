#!/usr/bin/env bash

source ./lint.sh

readonly RE_FN_NAME='[a-zA-Z0-9_+:]'
readonly RE_FN_BODY="{.*?}"
readonly RE_FN_DECL="(function\s)?$RE_FN_NAME+\(\)\s?$RE_FN_BODY"

readonly RE_COND_BODY=
readonly RE_COND="if\s+(.*?)(\s|;)then\s+(.*?)(else)?(.*?)fi"

readonly RE_LOOP_BODY='do\s+*(.*?)done'
readonly RE_LOOP_FOR='for\s+\w\sin\s+(.*?)(\s|;)'
readonly RE_LOOP_BASIC='(while|until)\s+(.*?)(\s|;)'
readonly RE_LOOP_START="($RE_LOOP_BASIC|$RE_LOOP_FOR)"
readonly RE_LOOP="$RE_LOOP_START$RE_LOOP_BODY"

readonly GREP="grep -Ezo"
readonly SED="sed"

parse()
{
    fns="$(parse_functions "$1")"
    loops="$(parse_loops "$fns")"
    conds="$(parse_conds "$loops")"
}

parse_functions()
{
    echo hey >&2
    fns="$(to_array "$($GREP "$RE_FN_DECL")")"
    echo tf >&2
    for i in $fns; do
        name_parens="$($GREP "$FN_NAME+?(\(\))" <<<"$i")"
        body="$($SED '' <<<"$i")"
        printf "%s" "$name_parens" >>"$OUT"
        printf "\n{\n" >>"$OUT"
        printf "%s" "$(modify "$INDENT" "$body")" >>"$OUT"
        printf "\n}\n" >>"$OUT"
    done
}

parse_loops()
{
    loops="$(to_array "$($GREP "$RE_LOOP" "$@")")"
    for i in "$loops"; do
        loop="$($GREP "$RE_LOOP_START" "$@")"
        body="$($GREP "$RE_LOOP_BODY" "$@")"
        printf "%s" "$loop"
        if "$EXPAND"; then
            printf "%s" "\ndo\n" >>"$OUT"
        else
            printf "%s" "do\n" >>"$OUT"
        fi
        printf "%s" "$(modify "$INDENT" "$body")" >>"$OUT"
        printf "%s" "\ndone\n" >>"$OUT"
    done
}

parse_conds()
{
    conds="$(to_array "$($GREP "$RE_COND" "$@")")"
    for i in $conds; do
        cond=''
        body=''
        if "$EXPAND"; then
            echo lol parse.sh+55
        fi
        printf "%s" "$(modify "$INDENT" "$body")" >>"$OUT"
    done
}
