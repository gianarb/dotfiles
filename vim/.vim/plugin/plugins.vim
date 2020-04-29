set rtp+=~/.fzf

" vim-grammarous{{{
" the below setting makes grammar checker check comments only except for markdown and vim help
let g:grammarous#default_comments_only_filetypes = {
    \ '*' : 1, 'help' : 0, 'markdown' : 0,
    \ }
" }}}

" vim-test {{{
let test#strategy = "vimterminal"
" }}}

" vim-coc {{{
"
" https://github.com/neoclide/coc.nvim/issues/888#issuecomment-504090910
call coc#config('coc.preferences', {
    \ 'messageLevel': 'error',
    \})
" }}}
