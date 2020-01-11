:if $HEADER != 'none'
	normal gg/# "qdapo# HEADER"qp
endif

:if $SPACES == "true"
	set noexpandtab
else
	set expandtab
endif

:let g:indent = $INDENT
:exec 'set tabstop=' . g:indent . ' shiftwidth=' . g:indent

:if $EXPAND
	%s/\<do\>/\ndo/
	%s/\<then\>/\nthen/
	normal gg=G
endif

:normal gg=G

:let g:file = $OUT
:if g:file == ''
	let g:file = '/dev/stdout'
endif
:exec 'wq!' . g:file
:q!
