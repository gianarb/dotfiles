filetype plugin indent on
set number                               " enable line number
set term=screen-256color
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

" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove trailing spaces
au FileType vim,php,c,python,html,javascript,twig,yml,xml,js,md,sls au BufWritePre *.* :%s/\s\+$//e

" Use 2 space on specific files
autocmd Filetype html,sls,coffee,js,javascript setlocal ts=2 sts=2 sw=2

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

" LESS
au BufNewFile,BufRead *.less set filetype=less
" WSGI
au BufNewFile,BufRead *wsgi set filetype=python
" HTML
au BufRead,BufNewFile *.twig set filetype=html
" JSON
au BufRead,BufNewFile *.json set filetype=json

" cloe buffer explorer on select
let g:miniBufExplAutoStart = 0
let g:miniBufExplCloseOnSelect = 1
let g:miniBufExplVSplit = 35

let g:syntastic_c_checkers=['c']
let g:syntastic_html_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_css_checkers=['csslint']

" Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_cursor_column = 0

" git
map <Leader>gs :Gstatus<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>ge :Gedit<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>ga :Gcommit -a<CR>
map <Leader>gw :Gwrite<CR>
map <Leader>gl :Gitv<CR>

let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](report|cache|vendor|node_modules|dist|bower_components|build)$',
    \ }

nmap <Leader>b :TagbarToggle<CR>
map <Leader>tree :NERDTreeToggle<CR>
nmap <Leader>m :MBEToggle<CR> :MBEFocus<CR>

let g:VimuxOrientation = "h"
map <Leader>rb :VimuxRunCommand  "<LEFT>"
map <Leader>rc :VimuxCloseRunner<CR>
