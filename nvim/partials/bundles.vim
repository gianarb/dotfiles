"Install vundle
let shouldInstallBundles = 0

if !filereadable($HOME . "/.nvim/autoload/plug.vim")
echo "~≥ Installing vim-plug \n"
silent !curl -fLo $HOME/.nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
let shouldInstallBundles = 1
endif

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'mattn/gist-vim'
Plug 'gregsexton/gitv'
Plug 'majutsushi/tagbar'
Plug 'shawncplus/phpcomplete.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/LanguageTool'
Plug 'flazz/vim-colorschemes'
Plug 'mattn/webapi-vim.git'
Plug 'jaxbot/github-issues.vim'
Plug 'othree/html5.vim'
Plug 'joonty/vdebug'
Plug 'benmills/vimux'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'wdalmut/vim-phpunit.git'
Plug 'docker/docker', { 'rtp': 'contrib/syntax/vim' }
Plug 'StanAngeloff/php.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'vim-php/vim-composer'
Plug 'saltstack/salt-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go'

call plug#end()

if shouldInstallBundles == 1
    echo "~> Installing plugs\n"
    :PlugInstall
endif
