" PHP RELATED SETTINGS

if bufname("%") !~ '\.php$'
    let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

    let g:tagbar_type_php = {
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
    " BDD
    map <Leader>pdesc :!bin/phpspec describe<SPACE>
    au FileType php noremap <Leader>tau :!./bin/phpunit <CR>
    au FileType php noremap <Leader>tu :!./bin/phpunit %<CR>
    au FileType php noremap <Leader>ts :!./bin/phpspec run -fpretty %<CR>
    au FileType php noremap <Leader>tas :!./bin/phpspec run<CR>
    " PHP EXTENSION DEVELOPMENT RELATED SETTINGS
    autocmd BufNewFile,BufRead *.phpt call SyntaxRange#Include('<?php', '?>', 'php')
endif
