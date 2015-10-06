set rtp+=~/.fzf

let g:go_fmt_command = "goimports"

let g:syntastic_c_checkers=['c']
let g:syntastic_php_checkers=['php', 'phpmd', 'phpcs']
let g:syntastic_html_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_css_checkers=['csslint']

" Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_cursor_column = 0
