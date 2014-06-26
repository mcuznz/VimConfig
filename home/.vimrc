" Delete all auto commands (needed to auto source .vimrc after saving)
autocmd!

set mouse=a
set nocompatible
set shell=/bin/sh

" required by Vundle!
filetype off

""""""""""""""
" tmux fixes "
" """"""""""""""
" Handle tmux $TERM quirks in vim
if $TERM =~ '^screen-256color'
	map <Esc>OH <Home>
	map! <Esc>OH <Home>
	map <Esc>OF <End>
	map! <Esc>OF <End>
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Plugins
Bundle 'SirVer/ultisnips'
Bundle 'tobyS/pdv'
Bundle 'tobyS/vmustache'
Bundle "tobyS/skeletons.vim"
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'embear/vim-localvimrc'
" Bundle 'joonty/vdebug'
Bundle 'joonty/vim-phpunitqf'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-unimpaired'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'stephpy/vim-php-cs-fixer'

" Syntax highlighting
Bundle 'JCook21/vim-twig'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'StanAngeloff/php.vim'
Bundle 'KohPoll/vim-less'
Bundle 'vim-ruby/vim-ruby'
Bundle 'altercation/vim-colors-solarized'
Bundle 'smerrill/vcl-vim-plugin'
Bundle 'tejr/vim-tmux'
Bundle 'othree/html5-syntax.vim'
Bundle 'elzr/vim-json.git'


" Highlight current line in insert mode.
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Set the hidden option to enable moving through args and buffers without
" saving them first
 set hidden

" Show line numbers by default
set number

set wrapscan
syntax on
set wrap
set linebreak
set nolist

" Colorscheme
set background=dark
colorscheme solarized
call togglebg#map("<F12>")

" Save files as root
cnoremap w!! w !sudo tee % >/dev/null

" load the man plugin for a nice man viewer
runtime! ftplugin/man.vim

" Use pman for manual pages
setlocal keywordprg=pman

" Use filetype plugins
filetype plugin indent on

" Auto indent after a {
set autoindent
set smartindent

" Use built in matchit plugin
runtime macros/matchit.vim

" Filetype settings
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType twig setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown set spell

au BufRead,BufNewFile *.phps set filetype=php

" Associate .md files with markdown.
au BufRead,BufNewFile *.md set filetype=markdown

" Enable folding by fold markers
set foldmethod=marker

" Autoclose folds, when moving out of them
set foldclose=all

" Use incremental searching
set incsearch

" Don't highlight search matches
set nohlsearch

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol,indent

" Allow file inline modelines to provide settings
set modeline

" Allow the dot command to be used in visual mode
:vnoremap . :norm.<CR>

" Toggle paste with <ins>
set pastetoggle=<ins>

" Switch paste mode off whenever insert mode is left
autocmd InsertLeave <buffer> set nopaste

" Show large "menu" with auto completion options
set wildmenu
set wildmode=list:longest

" Use a fast terminal since this is 2014...
set ttyfast

" Save more commands in history
set history=200

set laststatus=2
set encoding=utf-8

" Reads the skeleton php file
" TODO: How can this be moved out of this file?
" Note: The normal command afterwards deletes an ugly pending line and moves
" the cursor to the middle of the file.
autocmd BufNewFile *.php 0r ~/.vim/skeleton.php | normal Gdda

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Let powerline handle displaying the status line.
set noshowmode

" Use python to pretty format json.
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Autoreload Vimrc every time it's saved.
if has("autocmd")
	autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" Plugin settings " ================================================================================
" Localvimrc plugin settings
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0
let g:localvimrc_count=1

" Syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_java_javac_config_file_enabled=1

" Ultisnips settings
let g:UltiSnipsExpandTrigger = "<leader><Tab>"
let g:UltiSnipsListSnippets = "<leader><C-Tab>"
" Set a custom snippets directory
let g:UltiSnipsSnippetsDir = $HOME . "/.vim/snippets"
let g:UltiSnipsSnippetDirectories = ["mysnippets", "templates_snip"]

" Powerline settings
set rtp+=~/.homesick/repos/VimConfig/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
let g:powerline_config_overrides = { 'ext': { 'vim': { 'colorscheme': 'solarized' }}}

" JSON syntax plugin
let g:vim_json_syntax_conceal = 0

" Trims whitespace in a file.
function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction

function! My_TabComplete()
	let substr = strpart(getline('.'), col('.'))
	let result = match(substr, '\w\+\(\.\w*\)$')
	if (result!=-1)
		return "\<C-X>\<C-U>"
	else
		return "\<tab>"
endfunction
autocmd FileType java inoremap <tab> <C-R>=My_TabComplete()<CR>
