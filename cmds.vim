:if getline(1) !=# '#!/bin/sh'
1d
call append(0, '#!/usr/bin/env bash')
endif
:if $HEADER !=# 'none'
call append(2, "# which is called " . expand('%:t'))
call append(2, "# some random header with a date: " . strftime('%c'))
endif
:if $SPACES ==# "true"
set expandtab
else
set noexpandtab
endif
:let g:indent = $INDENT
:exec 'set tabstop=' . g:indent . ' shiftwidth=' . g:indent
:if $EXPAND ==# "true"
execute '%substitute /\<then\>/\rthen/'
execute '%substitute /\<do\>/\rdo/'
execute '%substitute /;\s$//'
execute '%substitute ///ge'
endif

:normal gg=G
:retab

:let g:file = $OUT
:if g:file == ''
let g:file = '/dev/stdout'
endif
exec 'wq!' . g:file
q!
