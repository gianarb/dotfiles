" PHP RELATED SETTINGS
au FileType php let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
au FileType php let g:phpcomplete_parse_docblock_comments=1
au FileType php let g:tagbar_type_php = {
                \ 'kinds'     : [
                    \ 'd:Constants:0:0',
                    \ 'v:Variables:0:0',
                    \ 'f:Functions:1',
                    \ 'i:Interfaces:0',
                    \ 'c:Classes:0',
                    \ 'p:Properties:0:0',
                    \ 'm:Methods:1',
                    \ 'n:Namespaces:0',
                    \ 't:Traits:0',
                \ ],
                \ 'sro'        : '::',
                \ 'kind2scope' : {
                    \ 'c' : 'class',
                    \ 'm' : 'method',
                    \ 'f' : 'function',
                    \ 'i' : 'interface',
                    \ 'n' : 'namespace',
                    \ 't' : 'trait',
                \ },
                \ 'scope2kind' : {
                    \ 'class'     : 'c',
                    \ 'method'    : 'm',
                    \ 'function'  : 'f',
                    \ 'interface' : 'i',
                    \ 'namespace' : 'n',
                    \ 'trait'     : 't',
                \ }
            \ }
au FileType php set omnifunc=phpcomplete#CompletePHP

au FileType php map <Leader>pdesc :!bin/phpspec describe<SPACE>
au FileType php noremap <Leader>ts :!./bin/phpspec run -fpretty %<CR>
au FileType php noremap <Leader>tas :!./bin/phpspec run<CR>

let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"

" phpunit
au FileType php noremap <Leader>tau <ESC>:let g:phpunit_args_append=""<ESC>:Test <CR>
au FileType php noremap <Leader>tu  <ESC>:Test %<CR>
au FileType php noremap <Leader>tt <ESC>:let g:phpunit_args_append="--filter " . @t<ESC>:Test<CR>
au FileType php noremap <Leader>to  <ESC>:TestOutput<CR>

au FileType php autocmd BufNewFile,BufRead *.phpt call SyntaxRange#Include('<?php', '?>', 'php')
" array() -> []
au FileType php nnoremap <silent> <Leader>a /\<array\>\s*(<CR>:nohl<CR>dwmp%r]`pr[

let g:phpunit_cmd = "~/.dotfiles/vendor/bin/phpunit"

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
au FileType php noremap <Leader>u :call PhpInsertUse()<CR>
au FileType php noremap <Leader>i :call phpcomplete#JumpToDefinition('vsplit')<CR>

