set rtp+=~/.fzf

" Go Vim {{{
let g:go_omnifunc_enabled = 0
let g:go_metalinter_autosave_enabled = ['vet']
let g:go_metalinter_autosave = 1
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
let NERDTreeShowHidden=1
" }}}

" FZF {{{
map <C-p> :FZF<cr>
map <C-t> :Tags<cr>
map <C-b> :Buffers<cr>
" }}}

" tagbar {{{
nmap <Leader>tt :Vista!!<CR>
" }}}

" vim-coc {{{
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

let g:go_def_mapping_enabled = 0
nnoremap <silent> <space>s :<C-u>Denite coc-service<cr>
nnoremap <silent> <space>a :<C-u>Denite coc-diagnostic<cr>
nmap <leader>rn <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" }}}

" vim-grammarous{{{
" the below setting makes grammar checker check comments only except for markdown and vim help
let g:grammarous#default_comments_only_filetypes = {
    \ '*' : 1, 'help' : 0, 'markdown' : 0,
    \ }
" }}}

" vim-test {{{
let test#strategy = "vimterminal"
" }}}

" https://github.com/haya14busa/vim-gofmt {{{
let g:gofmt_formatters = [
\   { 'cmd': 'gofmt', 'args': ['-s', '-w'] },
\ ]
autocmd BufWritePre *.go Fmt
" }}}
