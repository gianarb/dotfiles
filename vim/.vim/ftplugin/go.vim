" vim-coc {{{
autocmd BufWritePre *.go silent! :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> jt    :call     CocAction('runCommand', 'go.test.toggle')<CR>

nmap tr :TestNearest<CR>
nmap ta :TestFile<CR>
