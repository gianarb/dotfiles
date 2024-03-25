set rtp+=~/.fzf

" vim-test {{{
let test#strategy = "vimterminal"
" }}}

" vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" vim-coc {{{
let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-rust-analyzer',
\ 'coc-svelte',
\ '@yaegassy/coc-tailwindcss3'
\ ]
" }}}
