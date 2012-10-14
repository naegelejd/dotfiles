" pysyntax.vim - a python syntax checker
" Maintainer:   Joe Naegele <http://josephnaegele.com>>
" Version:      0.1

if exists("g:loaded_PySyntaxChecker") || &cp
    finish
endif

let g:loaded_PySyntaxChecker   = 0.1
let s:keepcp            = &cpo
set cpo&vim

function! GetVimPython()
    echo "Error: This version of VIM not compiled with +python"
endfunction

" If user's VIM is not compiled with Python support,
" fail gracefully
if !has('python')
    command! -nargs=0 Chsyn call GetVimPython()
    finish
endif

command! -nargs=0 Chsyn call CheckSyntax()

function! CheckSyntax()
python << EOF
import vim
import ast

source = '\n'.join(vim.current.buffer)
current_window = vim.current.window

try:
    a = ast.parse(source)
except SyntaxError, e:
    # move cursor to location of syntax error
    current_window.cursor = (e.lineno, e.offset)
    print("Syntax Error: %s" % e.msg)
else:
    print("Syntax OK")

EOF
endfunction
