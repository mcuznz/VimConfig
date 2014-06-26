" .vim/ftplugin/php.vim by Tobias Schlitt <toby@php.net>.
" No copyright, feel free to use this, as you like.

" {{{ Settings

" Auto expand tabs to spaces
setlocal expandtab

" Auto indent after a {
" setlocal autoindent
" setlocal smartindent

" Linewidth to endless
setlocal textwidth=0

" Do not wrap lines automatically
setlocal nowrap

" Correct indentation after opening a phpdocblock and automatic * on every
" line
" setlocal formatoptions=qroct

" Switch syntax highlighting on, if it was not
syntax on

" }}} Settings

" {{{ Automatic close char mapping

" More common in PEAR coding standard
inoremap  { {<CR>}<C-O>O
" Maybe this way in other coding standards
" inoremap  { <CR>{<CR>}<C-O>O

inoremap [ []<LEFT>

" Maybe this way in other coding standards
inoremap ( ()<LEFT>

inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" }}} Automatic close char mapping

" {{{ Dictionary completion

" Use the dictionary completion
setlocal complete-=k complete+=k

" }}} Dictionary completion
