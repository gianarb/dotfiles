" ------------------------------------------------------------------------------
" Vim IFQL                                                                {{{
"
" Author: Gianluca Arbezzano <gianarb92@gmail.com>
"
" Description:
" Run PHPUnit from within Vim. This plugin is based on the joonty's
" vim-phpunitqf but i have removed the quickfix because i don't want to use it.
"
" Requires: Vim 6.0 or newer
"
" Install:
" Put this file and the python file in the vim plugins directory (~/.vim/plugin)
" to load it automatically, or load it manually with :so sauce.vim.
"
" License: MIT
"
" }}}
" ------------------------------------------------------------------------------

au BufReadPost *\.ifql set filetype=ifql
au BufReadPost *\.ifql set syntax=ifql
