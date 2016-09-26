set rtp+=~/.fzf

" Go Vim
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

" Syntastic
let g:syntastic_c_checkers=['c']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args="--standard=psr2"
let g:syntastic_html_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_css_checkers=['csslint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_cursor_column = 0

set diffopt+=vertical

" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
