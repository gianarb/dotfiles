if filereadable("./tags")
    set tags+=./tags
endif

" Generate ctags while editing
autocmd BufWritePost * if filereadable('tags') | exec ':silent ! ctags -a %' | endif

map <Leader>t :!ctags -R --languages= .<LEFT><LEFT>
