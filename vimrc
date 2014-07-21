set nocompatible              " be iMproved, required
filetype off                  " required
set number                    " enable line number
set term=screen-256color
" enable 256 colors in screen
set t_Co=256

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

filetype plugin indent on     " required

set backspace+=start,eol,indent

syntax on
colorscheme molokai
let g:molokai_original = 1

" Highlight current line - allows you to track cursor position more easily
set cursorline

"Install vundle
let shouldInstallBundles = 0

if !filereadable($HOME . "/.vim/bundle/vundle/README.md")
    echo "~â‰¥ Installing Vundle \n"
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
    let shouldInstallBundles = 1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'marik/vundle'
Bundle 'jnwhiteh/vim-golang'
Bundle 'fatih/vim-go'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'groenewege/vim-less'
Bundle 'pangloss/vim-javascript'
Bundle 'mattn/gist-vim'
Bundle 'majutsushi/tagbar'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-dispatch'
Bundle 'jaxbot/github-issues.vim'
Bundle 'othree/html5.vim'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'Valloric/YouCompleteMe'
Bundle 'StanAngeloff/php.vim'
Bundle 'godlygeek/tabular'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'mattn/webapi-vim'
Bundle 'scrooloose/nerdtree'

if shouldInstallBundles == 1
    echo "~> Installing vundle bundles"
    :BundleInstall
endif


" Cntrl + Space for autocomplete
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
    \ "\<lt>C-n>" :
    \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
    \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
    \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>



if filereadable("./tags")
    set tags=./tags
endif

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

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Use F4 to toggle 'paste' mode"
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

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

" PHP
au FileType php set omnifunc=phpcomplete#CompletePHP
" LESS
au BufNewFile,BufRead *.less set filetype=less
" WSGI
au BufNewFile,BufRead *wsgi set filetype=python
" HTML
au BufRead,BufNewFile *.twig set filetype=html

" Show line, column number, and relative position within a file in the status
" line
set ruler

" Scroll when cursor gets within 10 characters of top/bottom edge
set scrolloff=999

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 4 spaces for (auto)indent
set shiftwidth=4


" Syntastic check
let g:syntastic_html_checkers=['jshint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_c_checkers=['c']
let g:syntastic_css_checkers=['csslint']
let g:syntastic_less_checkers=['lessc']
let g:syntastci_go_checkers=['go', 'gofmt', 'golint']

" Tagbar Go {{{
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
" }}} 

"a utocomplete Options {{{
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_always_populate_location_list = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_auto_trigger = 1
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
" }}}

" git
map <Leader>gs :Gstatus<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>ge :Gedit<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>ga :Gcommit -a<CR>
map <Leader>gw :Gwrite<CR>
map <Leader>gl :Gitv<CR>

" easy split manager
map <Leader>v :vsplit<cr>
map + :vertical resize +5<cr>
map - :vertical resize -5<cr>
map = <c-w>=

" format table
noremap <Leader>tab :Tabularize<CR>

" Motion keys for tabs ctrl+t <direction>
map <C-n> :tabnew<cr>

map <C-a> ggVG
imap <C-Space> <C-x><C-o>

let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](report|bin|cache|vendor|node_modules|dist|bower_components|build)$',
    \ }

" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["mysnippet"]
let g:UltiSnipsExpandTrigger="<C-b>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

" BDD
map <Leader>pdesc :!bin/phpspec describe<SPACE>
au FileType php noremap <Leader>tau <ESC>:!phpunit --configuration tests/ <CR>
au FileType php noremap <Leader>tu <ESC>:!phpunit --configuration tests/ %<CR>
au FileType php noremap <Leader>ts <ESC>:!bin/phpspec run -fpretty %<CR>
au FileType php noremap <Leader>tas <ESC>:!bin/phpspec run<CR>

map <Leader>tree :NERDTreeToggle<CR>

" Open my vimrc
map <Leader>my :e ~/.vimrc<CR>

map <Leader>, :w<CR>
imap <Leader>, <ESC>:w<CR>
vmap <Leader>, <ESC><ESC>:w<CR>

nmap <Leader>bar :TagbarToggle<CR>

nmap <Leader>m :MBEToggle<CR>

"statusline setup
set statusline =%#StatusLineFilename#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
endif
