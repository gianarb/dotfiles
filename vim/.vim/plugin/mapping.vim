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

nmap tr :TestNearest<CR>
nmap ta :TestSuite<CR>
