" Auto expand tabs to spaces
setlocal expandtab

" Switch syntax highlighting on, if it was not
syntax on

inoremap <buffer> " ""<LEFT>
inoremap <buffer> ' ''<LEFT>
let g:syntastic_python_checkers = ['flake8']
