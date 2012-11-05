set cmdheight=1
set encoding=utf-8
set termencoding=utf-8

set clipboard=unnamed

syntax on
filetype indent plugin on
set shell=/bin/sh
set splitbelow
set nobackup

"status line settings
set laststatus=2
set statusline=%-3.3n\ %f\ %h%m%r%w[%{strlen(&filetype)?&filetype:'?'},%{&encoding},%{&fileformat}]%=\ 0x%-8B\ \ %-14.(%l,%c%V%)\ %<%P

" search options
set nohlsearch
set incsearch
set ignorecase
set smartcase

"navigation options
set whichwrap=h,l,<,>,[,]
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=80
set expandtab
set nowrap
set history=500

set number

set background=dark

if has("autocmd")
    filetype plugin indent on
    augroup vimrcFunctions
        au!
        autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
        autocmd Syntax * syn match Error /\s\+$\| \+\ze\t/
    augroup END
endif

"Lisp syntax
let g:lisp_rainbow = 1

source $HOME/.vim/plugin/tabbar.vim
let g:Tb_SplitBelow=0

"Surround with \textit
function! Textit() range
	exec "normal `<i\\textit{\<esc>"
	if a:firstline == a:lastline
		exec "normal `>8la}"
	else
		exec "normal `>a}"
	endif
endfunction
vmap ,C :call Textit()<CR>
