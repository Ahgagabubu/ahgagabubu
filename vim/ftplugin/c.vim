setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4

if has("cscope")
	set cscopetag
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	nmap <F9> :!cscope -Rbqk<CR>:cs reset<CR>
	nmap <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
endif
