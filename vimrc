set nocompatible              " be iMproved, required
filetype off                  " required
set number                    " enable line number
set term=screen-256color

" Make sure that unrecognized files are still indented
set autoindent

" Purge previous auto commands (in case vimrc is run twice)
autocmd!

" Show (partial) commands (or size of selection in Visual mode) in the status
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

set backspace+=start,eol,indent

"Install vundle
let shouldInstallBundles = 0

if !filereadable($HOME . "/.vim/bundle/vundle/README.md")
        echo "~â‰¥ Installing Vundle \n"
        silent !mkdir -p $HOME/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
        let shouldInstallBundles = 1
endif

" Cntrl + Space for autocomplete
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
                        \ "\<lt>C-n>" :
                        \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
                        \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
                        \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'marik/vundle'
Bundle 'jnwhiteh/vim-golang'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/gist-vim'
Bundle 'majutsushi/tagbar'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'othree/html5.vim'
Bundle 'StanAngeloff/php.vim'
Bundle 'godlygeek/tabular'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'mattn/webapi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'gianarb/notify.vim'

if shouldInstallBundles == 1
        echo "~> Installing vundle bundles"
        :BundleInstall
endif

if filereadable("./tags")
        set tags=./tags
endif   

" Turn syntax highlighting on
syntax on

set hlsearch
set incsearch

colorscheme jellybeans

filetype plugin indent on     " required

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

" Generate and reload php ctags 
function! GeneratePhpCTags()
        silent call system('ctags -R --languages=PHP')
        set tags=./tags
endfunction
map <C-o> :call GeneratePhpCTags()

" Syntastic check
let g:syntastic_html_checkers=['jshint']
let g:syntastic_php_checkers=['php']

" git
map <Leader>gs :Gstatus<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>ge :Gedit<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>ga :Gcommit -a<CR>
map <Leader>gw :Gwrite<CR>
map <Leader>gl :Gitv<CR>

" Motion keys for tabs ctrl+t <direction>
map <C-n> :tabnew<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

map <C-a> ggVG
imap <C-Space> <C-x><C-o>

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
endif
