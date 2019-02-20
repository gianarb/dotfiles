set rtp+=~/.fzf

" Go Vim {{{
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_omnifunc_enabled = 0
" }}}

" Syntastic {{{
let g:syntastic_sh_checkers=['shellcheck']
let g:syntastic_c_checkers=['c']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args="--standard=psr2"
let g:syntastic_html_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_css_checkers=['csslint']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_cursor_column = 0
set diffopt+=vertical
" }}}

" Autoformat js{{{
let g:formatterpath = ['xo']
noremap <F3> :Autoformat<CR>
" }}}

" UltiSnips {{{
let g:UltiSnipsEditSplit="vertical"
if !exists("g:UltiSnipsSnippetDirectories")
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/mysnippets']
else
    let g:UltiSnipsSnippetDirectories+=[$HOME.'/.vim/mysnippets']
endif

let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
" }}}

" NERDTree {{{
map <Leader>t :NERDTreeToggle<CR>
" }}}

" {{{
if exists('g:ycm_filetype_blacklist')
   let g:ycm_filetype_blacklist.asciidoc = 1
endif
" }}}

" vimux {{{
let g:VimuxOrientation = "h"
map <Leader>rb :VimuxRunCommand  "<LEFT>"
map <Leader>rc :VimuxCloseRunner<CR>
" }}}

" FZF {{{
map <C-p> :FZF<cr>
map <C-t> :Tags<cr>
map <C-b> :Buffers<cr>
" }}}

" vim-go {{{
let g:go_metalinter_autosave_enabled = ['vet']
let g:go_metalinter_autosave = 1
" }}}

" tagbar {{{
nmap <Leader>tt :TagbarToggle<CR>
" }}}

" startify {{{
let g:startify_custom_header = [
           \ '      .   *   ..  . *  *',
           \ '    *  * @()Ooc()*   o  .',
           \ '        (Q@*0CG*O()  _',
           \ '      |\_________/|/ _ \',
           \ '      |  |  |  |  | / | |',
           \ '      |  |  |  |  | | | |',
           \ '      |  |  |  |  | | | |',
           \ '      |  |  |  |  | | | |',
           \ '      |  |  |  |  | | | |',
           \ '      |  |  |  |  | \_| |',
           \ '      |  |  |  |  |\___/',
           \ '      |\_|__|__|_/|',
           \ '       \_________/',
            \ ]
" }}}

" {{{
" " Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <C-p> to complete 'word', 'emoji' and 'include' sources
imap <silent> <C-p> <Plug>(coc-complete-custom)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
