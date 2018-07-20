call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'newzealandpaul/wombat256mod'
Plug 'othree/xml.vim'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim' 
Plug 'kien/ctrlp.vim'
Plug 'aceofall/gtags.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'Lokaltog/vim-powerline'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/Auto-Pairs'
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'php' }
Plug 'vim-scripts/AutoComplPop', { 'for': 'php' }
Plug 'lvht/phpcd.vim', { 'for': 'php' }
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'nvie/vim-flake8', {'for': 'python' }
Plug 'maralla/completor.vim', {'for': 'python'}
Plug 'Yggdroot/indentLine', {'for': 'python'}

call plug#end()

map <silent> <F2> : Tagbar<CR>
map <F3>          : call Complie()<CR>
map <silent> <F4> : Tab/=<CR>
map <F12>         : !send<CR>
map <F5>          : GitGutterToggle<CR>
map <F6>          : !php -l %<CR>
map <C-a>         : DoxAuthor<CR>
map <C-f>         : Dox<CR>
map <C-g>         : NERDTreeTabsFind<CR>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <leader>y "+y
map <leader>p "+p
nmap H gT
nmap L gt
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

"DoxygenToolkit
let g:DoxygenToolkit_authorName="zhuye,yformat930@126.com"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_by_filename = 1

"ack
let g:ack_default_options = " --php"

"gtags
set cscopetag
set cscopeprg='gtags-cscope'

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

let g:solarized_termtrans = 1

"markdown
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
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
	endif
endfunc

"jedi
let g:jedi#goto_assignments_command = "<C-]>"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-j>"
"let g:jedi#rename_command = "<leader>r"
