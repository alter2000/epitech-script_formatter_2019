#!/usr/bin/env bash

readonly FN_NAME='[a-zA-Z0-9_+:]'
readonly RE_FUNCTION="(function\s)?$FN_NAME+\(\)\s?{.*?}"
readonly RE_COND='if\s+(.*?)(\s|;)then\s+(.*?)(else)?(.*?)fi'
readonly RE_FOR='for\s+(.*?)(\s|;)do\s+*(.*?)done'
readonly RE_WHILE=''
readonly GREP="grep -Ezo"
readonly SED="sed"

parse()
{
    fns="$(parse_functions)"
    loops="$(parse_loops "$fns")"
    conds="$(parse_conds "$loops")"
}

parse_functions()
{
    fns="$($GREP "$RE_FUNCTION" "$@")"
    for i in $fns; do
        name_parens="$($GREP "$FN_NAME+?(\(\))" <<<"$i")"
        body="$($SED '' <<<"$i")"
        printf "%s" "$name_parens"
        printf "\n{\n"
        printf "%s" "$(modify "$INDENT" "$body")"
        printf "\n}\n"
    done
}

parse_loops()
{
    loops="$("$GREP" "$RE_LOOP" "$@")"
    for i in $loops; do
        loop=
        body=
        if "$EXPAND"; then
        fi
        printf "%s" "$(modify "$INDENT" "$body")"
    done
}

parse_conds()
{
    conds="$("$GREP" "$RE_COND" "$@")"
    for i in $conds; do
        cond=
        body=
        if "$EXPAND"; then
        fi
        printf "%s" "$(modify "$INDENT" "$body")"
    done
}
