" Check if git is available and if vundle is already installed  {{{
if executable("git") != 1 && !filereadable($HOME."/.dotfiles/bundle/vundle/README.md")
    echo "GIT is required to install bundles:"
else
	"Install vundle
	let shouldInstallBundles = 0

	if !filereadable($HOME . "/.nvim/autoload/plug.vim")
	echo "~≥ Installing vim-plug \n"
	silent !curl -fLo $HOME/.nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let shouldInstallBundles = 1
	endif

	call plug#begin('~/.vim/plugged')

	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
	Plug 'junegunn/fzf.vim'
	Plug 'benekastah/neomake', { 'on': 'Neomake' }
	Plug 'tpope/vim-fugitive'
	Plug 'mattn/gist-vim'
	Plug 'jaxbot/github-issues.vim'
	Plug 'vim-scripts/LanguageTool'
	Plug 'flazz/vim-colorschemes'
	Plug 'mattn/webapi-vim.git'
	Plug 'othree/html5.vim'
	Plug 'joonty/vdebug'
	Plug 'benmills/vimux'
	Plug 'arnaud-lb/vim-php-namespace', { 'for': 'go' }
	Plug 'wdalmut/vim-phpunit.git', { 'for': 'php' }
	Plug 'StanAngeloff/php.vim', { 'for': 'php' }
	Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
	Plug 'docker/docker', { 'rtp': 'contrib/syntax/vim' }
	Plug 'scrooloose/nerdtree'
	Plug 'scrooloose/nerdcommenter'
	Plug 'saltstack/salt-vim'
	Plug 'fatih/vim-go', { 'for': 'go' }

	call plug#end()

	if shouldInstallBundles == 1
	    echo "~> Installing plugs\n"
	    :PlugInstall
	endif

	" Use local vimrc if available
	if filereadable(expand("~/.vimrc.local"))
		source $HOME/.vimrc.local
	endif
endif
