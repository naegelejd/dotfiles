"
"
"
if exists("g:loaded_MyPlugin") || &cp
    finish
endif

if !has('python')
"    echo "Error: This version of VIM not compiled with +python"
    finish
endif

let g:loaded_MyPlugin   = 0.1
let s:keepcp            = &cpo
set cpo&vim

command! -nargs=0 Rev call Reverse()

function! Reverse()

python << EOF

import vim

#vim.current.buffer[-1] = vim.current.buffer[0]

rev = reversed(vim.current.buffer)

for i, line in enumerate(rev):
    vim.current.buffer[i] = line

EOF

endfunction
