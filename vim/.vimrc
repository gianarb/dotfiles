" post installation hooks{{{
"function! BuildYCM(info)
    "!git submodule update --init --recursive
    "!./install.py --system-libclang --clang-completer --go-completer --js-completer --java-completer
"endfunction
" }}} thanks fntlnz

" Install and setup plug{{{
let shouldInstallBundles = 0

if !filereadable($HOME . "/.vim/autoload/plug.vim")
	echo "~≥ Installing vim-plug \n"
	silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let shouldInstallBundles = 1
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'mattn/webapi-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'

call plug#end()

" I develop this integration and I want to load it directly from my workspace
if isdirectory($HOME . "/git/coc-grammarly")
    Plug '~/git/coc-grammarly'
endif

if shouldInstallBundles == 1
    echo "~> Installing plugs\n"
    :PlugInstall
endif
" }}}

" Use local vimrc if available{{{
if filereadable(expand("~/.vimrc.local"))
	source $HOME/.vimrc.local
endif
" }}}
"
let mapleader = ","                     " Set the <Leader> for combo commands

set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Enable filetype plugins {{{
    filetype plugin on
    filetype indent on
    filetype plugin indent on
" }}}

" Height of the command bar {{{
set cmdheight=2
" }}}

" Line Number {{{
set rnu                              " enable relative line number
set number                           " enable no relative number for the current line
" }}}
"
" Disable sounds {{{
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" }}}

" Indentation {{{
set autoindent                          " Make sure that unrecognized files are still indented
set si
" }}}

set secure                              " Enable secure mode
set showcmd                             " Show (partial) commands (or size of selection in Visual mode) in the status
set showmatch                           " When a bracket is inserted, briefly jump to a matching one
syntax on
set enc=utf-8

" Tabs vs Space {{{
set tabstop=4                           " Use 4 spaces for <Tab> and :retab
set shiftwidth=4
set expandtab                           " Expand tabs to spaces
set smarttab
" }}}
"
set nowrap
set wildmenu                            " Use menu to show command-line completion (in 'full' case)

" Search {{{
set incsearch                           " Enable incremental search
set hlsearch                            " Highlight results of a search
set smartcase                           " Ignore case only if seach string is all lowercase
set incsearch                           " Makes search act like search in modern browsers
set ic                                  " Search ignore case
" }}}
"

set termguicolors

 "colorscheme one {{{
colorscheme one
set background=dark
call one#highlight('Normal', 'abb2bf', '000000', 'none')
let g:one_allow_italics = 1
 "}}}

set showtabline=2                       " Make sure that tabline is always present
set laststatus=2                        " Always show status line, even for one window
set matchtime=2                         " Jump to matching bracket for 2/10th of a second (works with showmatch)
set backupdir=/tmp
set directory=/tmp                      " Don't clutter my dirs up with swp and tmp files
set scrolloff=999                       " Scroll when cursor gets within 10 characters of top/bottom edge
set shiftwidth=4                        " Use 4 spaces for (auto)indent
set exrc                                " Enable project specific .vimrc
set backspace=indent,eol,start
set mouse=v
set clipboard=unnamed

" Show tabs and spaces
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~
set list

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

let g:vimspector_enable_mappings = 'HUMAN'
