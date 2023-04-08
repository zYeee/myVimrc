call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'newzealandpaul/wombat256mod'
Plug 'othree/xml.vim'
Plug 'godlygeek/tabular'
"Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim' 
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'aceofall/gtags.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'idanarye/vim-merginal'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/Auto-Pairs'
Plug 'vim-airline/vim-airline'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'dyng/ctrlsf.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'ervandew/supertab'
Plug 'luochen1990/rainbow'
Plug 'ruanyl/vim-gh-line'
Plug 'francoiscabrol/ranger.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
"Plug 'vim-scripts/AutoComplPop', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'nvie/vim-flake8', {'for': 'python' }
Plug 'Yggdroot/indentLine', {'for': 'python'}
"Plug 'maralla/completor.vim', {'for': 'python'}
"Plug 'lvht/phpcd.vim', { 'for': 'php' }
"Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
"Plug 'vim-scripts/perl-support.vim', { 'for': 'perl' }
"Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['go', 'python']}
call plug#end()

set encoding=UTF-8
let mapleader=";"

map <silent> <F2> : Tagbar<CR>
map <F3>          : call Complie()<CR>
map <silent> <F4> : Tab/=<CR>
map <F12>         : !send<CR>
map <F5>          : GitGutterToggle<CR>
map <leader><F2>          : NERDTreeToggle<CR>
map <C-g>         : NERDTreeFind<CR>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <leader>y "+y
map <leader>p "+p
map cc :cclose<CR>
nmap H gT
nmap L gt
nmap <leader><leader>t :ter<CR>
nmap <leader><leader>i :!isort %<CR><CR>

"fzf
"nmap <C-p> :Files<CR>
"nmap <C-b> :Buffers<CR>
"nmap <C-f> :Ack! 
nmap <C-f> :CtrlSF 
nmap <C-f>; :CtrlSFToggle<CR> 

nmap ff :LeaderfFunction!<CR>

nmap ]] :set iskeyword-=:<CR>
nmap [[ :set iskeyword+=:<CR>

nmap <leader>g :Merginal<CR>

imap jj <Esc><Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap // //<space>

"tagbar
let g:tagbar_width=30


" highlight the search result
set hls
set shiftwidth=4
set ts=4
set expandtab
set cursorline
set ignorecase
set cc=120
set backspace=indent,eol,start
set nocompatible              " be iMproved
set noswapfile
set incsearch
set smartcase
set pythonthreedll=/usr/local/opt/python@3.7/Frameworks/Python.framework/Versions/3.7/lib/libpython3.7.dylib
filetype on                   " required!
filetype plugin on
filetype plugin indent on     " required!
syntax on

autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType html set omnifunc=xmlcomplete#CompleteTags
autocmd BufNewFile *.py exec ":call SetPyTitle()" 
"autocmd BufWritePost *.py CocCommand python.sortImports
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif

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

let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeWinSize = 20

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
        endif
    elseif &filetype == 'c'
		set makeprg=gcc\ -o\ %<\ %
        silent make
        let file = expand("%:r")
        if filereadable(file)
			exec "!./%< && rm %<"
		else 
			copen
        endif
	elseif (&filetype=='python')
		exec "!python3 %"
	elseif (&filetype == 'php')
		exec "!php %"
	elseif (&filetype == 'perl')
		exec "!perl %"
	elseif (&filetype == 'go')
		exec "GoRun"
	endif
endfunc

let g:rainbow_active = 1

"jedi
let g:jedi#goto_assignments_command = "<C-]>"
let g:jedi#completions_command = "<C-j>"
let g:jedi#force_py_version = 3
let g:jedi#popup_select_first = 1
let g:pymode_rope = 0
let g:autopep8_max_line_length=100
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#rename_command = "<leader>r"

" gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

let g:gutentags_ctags_tagfile = 'tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

"set tags=taaags;
let g:airline_extensions = []

let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

let g:go_fmt_command = "goimports"

  let g:go_debug_mappings = {
     \ '(go-debug-continue)':   {'key': '<F5>'},
     \ '(go-debug-print)':      {'key': '<F6>'},
     \ '(go-debug-breakpoint)': {'key': '<F9>'},
     \ '(go-debug-next)':       {'key': '<F10>'},
     \ '(go-debug-step)':       {'key': '<F8>'},
     \ '(go-debug-halt)':       {'key': '<F7>'},
  \ }

let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_calls = 1
let g:go_fillstruct_mode = 'gopls'


let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_ShowDevIcons = 0
let g:Lf_UseCache = 0

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

"let g:ale_linters = {'go': ['staticcheck', 'gofmt', 'golangci-lint']}
let g:ale_linters = {'go': ['golangci-lint']}
let g:ale_go_golangci_lint_options = '-c /Users/yzhu/.golangci.yml'
let g:ale_go_golangci_lint_package = 1
"let g:ale_linters = {'go': ['golint', 'staticcheck']}
"let g:ale_go_staticcheck_lint_package = 1

" \tr will send text to the window
nnoremap <leader>tr yy \| :call term_sendkeys(term_list()[0], @")<CR>
vnoremap <leader>tr y \| :call term_sendkeys(term_list()[0], @")<CR>

" bookmark
let g:bookmark_auto_save = 1
let g:bookmark_save_per_working_dir = 1
nmap <Leader>bs <Plug>BookmarkShowAll
nmap <Leader>ba <Plug>BookmarkAnnotate
nmap <Leader>bt <Plug>BookmarkToggle
nmap <leader>rn <Plug>(coc-rename)
