set nocompatible

"--------------
"" Load pathogen
"--------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

filetype plugin indent on

set t_Co=256
set background=dark
colorscheme solarized
syntax on

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal nolist textwidth=0 noexpandtab ts=4 sw=4
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
"autocmd FileType go set formatprg=gofmt

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
if $TMUX == ''
    set clipboard+=unnamed
endif
" Enhance command-line completion
set wildmenu
set wildmode=list:longest
set visualbell
set matchpairs=(:),[:],{:},<:>
set viminfo='1000,f1,<500,:500,/500
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
set whichwrap=h,l,[,],~
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
"set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set hidden
set exrc
set secure
" Enable line numbers
set number
" Highlight current line
set cursorline
" Show “invisible” characters
set listchars=tab:▸\
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
set smartcase
set showmatch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=79
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
"set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Allow vim to edit crontab
set backupskip=/tmp/*,/private/tmp/*
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" undofile
set shell=/bin/bash
set lazyredraw
set matchtime=3
" Use relative line numbers
if exists("&relativenumber")
	set norelativenumber
	au BufReadPost * set norelativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Moving between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Working with split screen nicely
" Resize Split When the window is resized"
au VimResized * :wincmd =

set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"


" Removing scrollbars
if has("gui_running")
    set gfn=Letter\ Gothic\ Std\ Bold:h14
    set tabpagemax=1
    set transp=5
    set sessionoptions+=resize,winpos
    set guitablabel=%-0.12t%M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions+=a
    set guioptions+=m
    set listchars=tab:▸\
    autocmd VimEnter * wincmd p
    autocmd VimEnter * NERDTreeFind
    autocmd VimEnter * wincmd p
    autocmd VimEnter * vsplit
endif

autocmd bufwritepost .vimrc source ~/.vimrc

" Change directory to current
function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    exec "cd " . _dir
    unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

if &term == "xterm-color"
	set t_kb=
	fixdel
endif

"nnoremap <silent> Q :Ex<CR>
noremap Y y$
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

map <C-n> :NERDTreeToggle<CR>

set expandtab
set splitbelow
set splitright

let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'

set rtp+=~/.powerline/powerline/bindings/vim
"let NERDTreeShowHidden=1
"let g:godef_same_file_in_same_window=1
"let g:godef_split=0
let g:SuperTabDefaultCompletionType = "context"


" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif