:if $HEADER != 'none'
	:normal gg/# "qdapoHEADER"qp
:endif

:if $SPACES == "true"
	:set noexpandtab
:else
	:set expandtab
:endif

:let indent = $INDENT
:set tabstop=indent shiftwidth=indent

:normal gg=G

:if $EXPAND
	:%s/\<do\>/\ndo/
	:%s/\<then\>/\nthen/
	:normal gg=G
:endif

:normal VG
:let file = $OUT
:if ! file
	:file = '/dev/stdout'
:endif
:wq! file
