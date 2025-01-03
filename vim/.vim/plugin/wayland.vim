" only run this in Vim on Wayland -- Vim on X has native clipboard support,
" and Neovim already works with wl-copy by default
if empty($WAYLAND_DISPLAY)
    finish
endif

xnoremap y y:call system("wl-copy", @")<cr>
nnoremap p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
