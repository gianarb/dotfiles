" post installation hooks{{{
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer --go-completer --js-completer --tern-completer
    endif
endfunction
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
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mattn/gist-vim'
Plug 'joonty/vdebug'
Plug 'jaxbot/github-issues.vim'
Plug 'mattn/webapi-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-hclfmt'
Plug 'nathanielc/vim-tickscript'
Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
Plug 'wdalmut/vim-phpunit', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'Chiel92/vim-autoformat', { 'for': 'javascript' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'artur-shaik/vim-javacomplete2'

call plug#end()

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

" Enable filetype plugins {{{
    filetype plugin on
    filetype indent on
    filetype plugin indent on
" }}}

" Height of the command bar {{{
set cmdheight=1
" }}}

" Line Number {{{
set number                              " enable line number
set rnu                                 " Relative line number
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
set wrap
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
set nowrap                              " do not wrap lines by default
set wildmenu                            " Use menu to show command-line completion (in 'full' case)

" Search {{{
set incsearch                           " Enable incremental search
set hlsearch                            " Highlight results of a search
set smartcase                           " Ignore case only if seach string is all lowercase
set incsearch                           " Makes search act like search in modern browsers
set ic                                  " Search ignore case
" }}}
"
set showtabline=2                       " Make sure that tabline is always present
set laststatus=2                        " Always show status line, even for one window
set matchtime=2                         " Jump to matching bracket for 2/10th of a second (works with showmatch)
set backupdir=/tmp
set directory=/tmp                      " Don't clutter my dirs up with swp and tmp files
set ruler                               " Show line, column number, and relative position within a file in the status
set scrolloff=999                       " Scroll when cursor gets within 10 characters of top/bottom edge
set shiftwidth=4                        " Use 4 spaces for (auto)indent
colorscheme glokai                      " Schema color
set exrc                                " Enable project specific .vimrc
set backspace=indent,eol,start
set mouse=v
set clipboard=unnamed
" }}}
