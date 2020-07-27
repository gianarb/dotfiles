"nmap <leader>tau :GoTest<CR>
"nmap gb :GoBuild<CR>

"nmap db :GoDebugBreakpoint<CR>
"nmap ds :GoDebugStart<CR>
"nmap dss :GoDebugStop<CR>
"nmap dc :GoDebugContinue<CR>
"nmap dst :GoDebugTest<CR>
"nmap dn :GoDebugNext<CR>
"nmap di :GoDebugStep<CR>
"nmap do :GoDebugStepOut<CR>

" Go Vim {{{
"setlocal omnifunc=
"let g:go_omnifunc_enabled = 0
"let g:go_fmt_autosave = 0

"let g:go_def_mapping_enabled = 0
"let go_gopls_enabled = 0

"let g:go_metalinter_autosave_enabled = ['vet']
"let g:go_metalinter_autosave = 0
"let g:go_metalinter_enabled=0

"let g:go_diagnostics_enabled=0

"let g:go_test_prepend_name = 1
"let g:go_test_show_name=1

" wrap long lines in quickfix
" https://github.com/fatih/vim-go/issues/1271
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END
" }}}

" vim-coc {{{
autocmd BufWritePre *.go silent! :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> jt    :call     CocAction('runCommand', 'go.test.toggle')<CR>

nmap tr :TestNearest<CR>
nmap ta :TestFile<CR>
