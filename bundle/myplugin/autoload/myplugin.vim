if !has('python')
    echo "Error: This version of VIM not compiled with +python"
    finish
endif

function! Reverse()

python << EOF

import vim

#vim.current.buffer[-1] = vim.current.buffer[0]

#rev = reversed(vim.current.buffer)

#for i, line in enumerate(rev):
#    vim.current.buffer[i] = line

EOF

endfunction
