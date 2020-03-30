nmap <leader>tau :GoTest<CR>
nmap gb :GoBuild<CR>

nmap db :GoDebugBreakpoint<CR>
nmap ds :GoDebugStart<CR>
nmap dss :GoDebugStop<CR>
nmap dc :GoDebugContinue<CR>
nmap dst :GoDebugTest<CR>
nmap dn :GoDebugNext<CR>
nmap di :GoDebugStep<CR>
nmap do :GoDebugStepOut<CR>

let g:go_metalinter_enabled=1
let g:go_test_prepend_name = 1
let g:go_test_show_name=1
setlocal omnifunc=

let g:go_test_prepend_name = 1
let g:go_test_show_name=1
let g:go_diagnostics_enabled=1

let g:go_def_mode='gopls'
let g:go_fmt_command = "gopls"
let g:go_rename_command="gopls"
let g:go_metalinter_command = "gopls"

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
nmap <leader>rn <Plug>(coc-rename)

nmap tr :GoTestFunc<CR>
nmap ta :GoTest<CR>
