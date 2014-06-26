set expandtab ts=2 sts=2 sw=2 autoindent
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let ruby_operators=1
let ruby_space_errors=1

if !exists( "*RubyEndToken" )

  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*|\(,\|\s\|\w*|\s*\)\?$'
    let stuff_without_do = '^\s*class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def'
      let with_do = 'do\s*|\(,\|\s\|\w*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>"
      endif
    endfunction

endif

imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
