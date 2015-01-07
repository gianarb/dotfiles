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

Plugin 'gmarik/Vundle.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'groenewege/vim-less'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/gist-vim'
Plugin 'majutsushi/tagbar'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/webapi-vim.git'
Plugin 'jaxbot/github-issues.vim'
Plugin 'othree/html5.vim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'StanAngeloff/php.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdtree'
Plugin 'saltstack/salt-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'

if shouldInstallBundles == 1
    echo "~> Installing vundle bundles"
    :BundleInstall
endif

