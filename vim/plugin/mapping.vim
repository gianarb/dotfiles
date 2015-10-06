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

" FZF
map <C-p> :FZF<cr>
map <C-t> :Tags<cr>
map <C-b> :Buffers<cr>

" atags.vim
map <Leader>t :call atags#generate()<cr>

"  select all
map <C-a> <esc>ggVG<CR>

map <Leader>tree :NERDTreeToggle<CR>

let g:VimuxOrientation = "h"
map <Leader>rb :VimuxRunCommand  "<LEFT>"
map <Leader>rc :VimuxCloseRunner<CR>

" Save how sudo
cmap w!! w !sudo tee % >/dev/null
