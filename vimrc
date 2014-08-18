set nocompatible              " be iMproved, required

" Check if git is available and if vundle is already installed  {{{
if executable("git") != 1 && !filereadable($HOME."/.vim/bundle/vundle/README.md")
    echo "GIT is required to install bundles:"
else
    source $HOME/.vim/vim-partials/bundles.vim
    source $HOME/.vim/vim-partials/settings.vim
    source $HOME/.vim/vim-partials/status-line.vim
    source $HOME/.vim/vim-partials/autocomplete.vim
    source $HOME/.vim/vim-partials/golang.vim
    source $HOME/.vim/vim-partials/php.vim
    
    " Use local vimrc if available
    if filereadable(expand("~/.vimrc.local"))
        source $HOME/.vimrc.local
    endif

endif
