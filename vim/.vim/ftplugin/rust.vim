" coc trick to resize the terminal when I run: CocCommand rust-analyzer.run
" I placed it here and not as part of the plugin.vim file where all the other
" plugin related configuring live bacause I don't know if I want this behavior
" for all the languages.
autocmd User CocTerminalOpen :resize 40
