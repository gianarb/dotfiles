let mapleader = ","                     " Set the <Leader> for combo commands

" reset seatch key
map <Leader>l :set nohlsearch<CR>

" save
map <Leader>, :w<CR>
imap <Leader>, <ESC>:w<CR>
vmap <Leader>, <ESC><ESC>:w<CR>
" Use F4 to toggle 'paste' mode"
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

" Unmap arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

"  select all
map <C-a> <esc>ggVG<CR>

" Save how sudo
cmap ww w !sudo tee % >/dev/null

map + :vertical resize +5<CR>
map _ :vertical resize -5<CR>

if !has('nvim')
    " vim-coc {{{

    " Use tab for trigger completion with characters ahead and navigate, this
    " exposes snipptes as well.
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

    " https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-and-s-tab-to-navigate-the-completion-list
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> for confirm completion.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-refactor)

    autocmd BufWritePre * silent! :call CocAction('format')

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    " }}}
    "
endif

" NERDTree {{{
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" }}}

" FZF {{{
map <C-p> :FZF<cr>
map <C-b> :Buffers<cr>
" }}}

" vimspector {{{
map <F2> :call vimspector#Reset()<CR>
" }}}
