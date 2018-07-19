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

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_test_prepend_name = 1
let g:go_test_show_name=1
setlocal omnifunc=
