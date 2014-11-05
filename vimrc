set nocompatible              " be iMproved, required
" Check if git is available and if vundle is already installed  {{{
if executable("git") != 1 && !filereadable($HOME."/.dotfiles/bundle/vundle/README.md")
    echo "GIT is required to install bundles:"
else
    source $HOME/.dotfiles/vim-partials/settings.vim
    source $HOME/.dotfiles/vim-partials/bundles.vim
    source $HOME/.dotfiles/vim-partials/status-line.vim
    source $HOME/.dotfiles/vim-partials/autocomplete.vim
    source $HOME/.dotfiles/vim-partials/php.vim

    " Use local vimrc if available
    if filereadable(expand("~/.vimrc.local"))
        source $HOME/.vimrc.local
    endif

    " Use local vimrc if available
    if filereadable(expand("./.vimpj.vim"))
        source ./.vimpj.vim
    endif

endif
