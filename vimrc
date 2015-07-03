set nocompatible              " be iMproved, required
" Check if git is available and if vundle is already installed  {{{
if executable("git") != 1 && !filereadable($HOME."/.dotfiles/bundle/vundle/README.md")
    echo "GIT is required to install bundles:"
else
    source $HOME/.vim/partials/bundles.vim
    source $HOME/.vim/partials/status-line.vim
    source $HOME/.vim/partials/php.vim
    source $HOME/.vim/partials/xml.vim
    source $HOME/.vim/partials/settings.vim
    source $HOME/.vim/partials/autocomplete.vim

    " Use local vimrc if available
    if filereadable(expand("~/.vimrc.local"))
        source $HOME/.vimrc.local
    endif
endif
