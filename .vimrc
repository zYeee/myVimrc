call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'newzealandpaul/wombat256mod'
Plug 'othree/xml.vim'
Plug 'godlygeek/tabular'
"Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim' 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'aceofall/gtags.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/Auto-Pairs'
Plug 'vim-airline/vim-airline'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'c9s/perlomni.vim'
Plug 'tpope/vim-surround'
Plug 'dyng/ctrlsf.vim'
"Plug 'lvht/phpcd.vim', { 'for': 'php' }
Plug 'vim-scripts/AutoComplPop', { 'for': 'perl' }
Plug 'vim-scripts/perl-support.vim', { 'for': 'perl' }
"Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'nvie/vim-flake8', {'for': 'python' }
Plug 'maralla/completor.vim', {'for': 'python'}
Plug 'Yggdroot/indentLine', {'for': 'python'}
Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

call plug#end()

map <silent> <F2> : Tagbar<CR>
map <F3>          : call Complie()<CR>
map <silent> <F4> : Tab/=<CR>
map <F12>         : !send<CR>
map <F5>          : GitGutterToggle<CR>
map <F6>          : NERDTreeToggle<CR>
map <C-g>         : NERDTreeTabsFind<CR>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <leader>y "+y
map <leader>p "+p
map cc :cclose<CR>
nmap H gT
nmap L gt

"fzf
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Ack! 

nmap ]] :set iskeyword-=:<CR>
nmap [[ :set iskeyword+=:<CR>

imap jj <Esc><Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

let mapleader=";"

"tagbar
let g:tagbar_width=30


" highlight the search result
set hls
set shiftwidth=4
set ts=4
set expandtab
set cursorline
set ignorecase
set cc=80
set backspace=indent,eol,start
set nocompatible              " be iMproved
set noswapfile
set incsearch
set smartcase
set pythonthreedll=/usr/local/Cellar/python@3.8/3.8.2/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib
filetype on                   " required!
filetype plugin on
filetype plugin indent on     " required!
syntax on

autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType html set omnifunc=xmlcomplete#CompleteTags
autocmd BufNewFile *.py exec ":call SetPyTitle()" 

"set t_Co=16
"colorscheme wombat256mod
set background=dark
colorscheme solarized

func! SetPyTitle()
     call setline(1,"#!/usr/local/bin/python3")
     call append(line("."),   "# -*- coding: utf-8 -*-")
endfunc

let g:solarized_termtrans = 1

"ack
let g:ack_default_options = " --perl"
let g:ackhighlight = 1

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"nerdtree
let g:nerdtree_tabs_open_on_console_startup=1

func! Complie()
	exec "w"
	if &filetype == 'cpp'
		set makeprg=g++\ -o\ %<\ %\ leetcode.cpp
		silent make
		let file=expand("%:r")
		if filereadable(file)
			exec "!./%< && rm %<"
		else 
			copen
		" %在vim中代表当前文件名，%<代表不含扩展名的文件名
        endif
    elseif &filetype == 'c'
		set makeprg=gcc\ -o\ %<\ %
        silent make
        let file = expand("%:r")
        if filereadable(file)
			exec "!./%< && rm %<"
		else 
			copen
		" %在vim中代表当前文件名，%<代表不含扩展名的文件名
        endif
	elseif (&filetype=='python')
		exec "!python3 %"
	elseif (&filetype == 'php')
		exec "!php %"
	elseif (&filetype == 'perl')
		exec "!perl %"
	endif
endfunc

"jedi
let g:jedi#goto_assignments_command = "<C-]>"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-j>"
"let g:jedi#rename_command = "<leader>r"


" gutentags
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = 'tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags


let g:acp_behaviorPerlOmniLength = 0

"set tags=taaags;
let g:airline_extensions = []

let g:jedi#force_py_version = 3
