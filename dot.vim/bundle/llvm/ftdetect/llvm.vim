" Enable syntax highlighting for LLVM files
augroup filetype
  au! BufRead,BufNewFile *.ll	set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files
augroup filetype
  au! BufRead,BufNewFile *.td	set filetype=tablegen
augroup END
