au FileType php noremap <Leader>tau <ESC>:let g:phpunit_args_append=""<ESC>:Test <CR>
au FileType php noremap <Leader>tu  <ESC>:let g:phpunit_args_append=""<ESC>:Test %<CR>
au FileType php noremap <Leader>tt <ESC>:let g:phpunit_args_append="--filter " . @t<ESC>:Test<CR>
au FileType php noremap <Leader>to  <ESC>:TestOutput<CR>

let g:phpunit_cmd = "~/.dotfiles/vendor/bin/phpunit"

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
au FileType php noremap <Leader>u :call PhpInsertUse()<CR>
au FileType php noremap <Leader>i :call phpcomplete#JumpToDefinition('vsplit')<CR>

" array() -> []
au FileType php nnoremap <silent> <Leader>a /\<array\>\s*(<CR>:nohl<CR>dwmp%r]`pr[

setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
