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

if filereadable("./tags")
    set tags+=./tags
endif

" Generate ctags while editing
autocmd BufWritePost * if filereadable('tags') | exec ':silent ! ctags -a %' | endif

" Autocomplete ctrl-space
imap <C-Space> <C-x><C-o>

map <Leader>tags :!ctags -R --languages= .<LEFT><LEFT>
