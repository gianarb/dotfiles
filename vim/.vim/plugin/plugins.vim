set rtp+=~/.fzf

" Go Vim {{{
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_omnifunc_enabled = 0
" }}}

" Syntastic {{{
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
" }}}

" Autoformat js{{{
let g:formatterpath = ['xo']
noremap <F3> :Autoformat<CR>
" }}}

" UltiSnips {{{
let g:UltiSnipsEditSplit="vertical"
if !exists("g:UltiSnipsSnippetDirectories")
    let g:UltiSnipsSnippetDirectories = ["mysnippets"]
else
    let g:UltiSnipsSnippetDirectories += ["mysnippets"]
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
