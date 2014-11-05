autocmd!
set nocompatible
filetype off
set number                    " enable line number
set term=screen-256color

" Set the <Leader> for combo commands
let mapleader = ","
" Make sure that unrecognized files are still indented
set autoindent
" Purge previous auto commands (in case vimrc is run twice)
autocmd!
" Show (partial) commands (or size of selection in Visual mode) in the status
set showcmd
" When a bracket is inserted, briefly jump to a matching one
set showmatch
set backspace+=start,eol,indent

syntax on
colorscheme molokai
let g:molokai_original = 1

" Highlight current line - allows you to track cursor position more easily
set cursorline
" Use UTF-8 as the default buffer encoding
set enc=utf-8
" Use 4 spaces for <Tab> and :retab
set tabstop=4
" Expand tabs to spaces
set expandtab
" do not wrap lines by default
set nowrap
" Use menu to show command-line completion (in 'full' case)
set wildmenu
" Enable incremental search
set incsearch
" Highlight results of a search
set hlsearch
" Ignore case when searching
set ignorecase
" Ignore case only if seach string is all lowercase
set smartcase
" Make sure that tabline is always present
set showtabline=2
" Always show status line, even for one window
set laststatus=2
" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2
" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd
" When a bracket is inserted, briefly jump to a matching one
set showmatch
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
" display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
set backupdir=/tmp
set directory=/tmp " Don't clutter my dirs up with swp and tmp files
" Show line, column number, and relative position within a file in the status
" line
set ruler
" Scroll when cursor gets within 10 characters of top/bottom edge
set scrolloff=999
" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround
" Use 4 spaces for (auto)indent
set shiftwidth=4

" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Use 2 space on specific files
autocmd Filetype sls,coffee,js setlocal ts=2 sts=2 sw=2

" Remove trailing spaces
au FileType vim,php,c,python,html,twig,yml,xml,js,md,sls au BufWritePre *.* :%s/\s\+$//e

" easy split manager
map <Leader>v :vsplit<cr>
map + :vertical resize +5<cr>
map - :vertical resize -5<cr>
map = <c-w>=
" Motion keys for tabs ctrl+t <direction>
map <C-n> :tabnew<cr>
" Open my vimrc
map <Leader>my :vsplit ~/.vimrc<CR>
map <Leader>l :set nohlsearch<CR>

map <Leader>, :w<CR>
imap <Leader>, <ESC>:w<CR>
vmap <Leader>, <ESC><ESC>:w<CR>
map <C-a> <esc>ggVG<CR>
" Use F4 to toggle 'paste' mode"
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

" Unmap arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

