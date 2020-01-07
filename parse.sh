#!/usr/bin/env bash


parse()
{
    grep -E eeeeeeeeeeelp\ besart
    fns="$(parse_functions)"
    loops="$(parse_loops "$fns")"
    conds="$(parse_conds "$loops")"
}

parse_functions()
{
}

parse_loops()
{
}

parse_conds()
{
}
