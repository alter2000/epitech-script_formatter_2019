#!/usr/bin/env bash

readonly RE_FUNCTION='(function\s)?[a-zA-Z0-9]+\(\)\s?{.*?}'
readonly RE_COND='if\s+(.*?)(\s|;)then\s+(.*?)(else)?(.*?)fi'
readonly RE_FOR='for\s+(.*?)(\s|;)do\s+*(.*?)done'
readonly RE_WHILE=''
readonly GREP="grep -Ezo"

parse()
{
    fns="$(parse_functions)"
    loops="$(parse_loops "$fns")"
    conds="$(parse_conds "$loops")"
}

parse_functions()
{
    $GREP "$RE_FUNCTION" "$@"
}

parse_loops()
{
    "$GREP" "$RE_LOOP" "$@"
}

parse_conds()
{
    "$GREP" "$RE_COND" "$@"
}
