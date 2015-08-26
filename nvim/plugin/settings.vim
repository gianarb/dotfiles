filetype plugin indent on
set number                               " enable line number
set exrc                                " Enable project specific .vimrc
set secure                              " Enable secure mode
let mapleader = ","                     " Set the <Leader> for combo commands
set autoindent                          " Make sure that unrecognized files are still indented
set showcmd                             " Show (partial) commands (or size of selection in Visual mode) in the status
set showmatch                           " When a bracket is inserted, briefly jump to a matching one
set backspace+=start,eol,indent
syntax on
set background=dark
colorscheme solarized
set enc=utf-8
set tabstop=4                           " Use 4 spaces for <Tab> and :retab
set expandtab                           " Expand tabs to spaces
set nowrap                              " do not wrap lines by default
set wildmenu                            " Use menu to show command-line completion (in 'full' case)
set incsearch                           " Enable incremental search
set hlsearch                            " Highlight results of a search
set ic                                  " Search ignore case
set smartcase                           " Ignore case only if seach string is all lowercase
set showtabline=2                       " Make sure that tabline is always present
set laststatus=2                        " Always show status line, even for one window
set matchtime=2                         " Jump to matching bracket for 2/10th of a second (works with showmatch)
set backupdir=/tmp
set directory=/tmp                      " Don't clutter my dirs up with swp and tmp files
set ruler                               " Show line, column number, and relative position within a file in the status
set scrolloff=999                       " Scroll when cursor gets within 10 characters of top/bottom edge
set shiftwidth=4                        " Use 4 spaces for (auto)indent
