" Joe Naegele's VIMRC, somewhat focused toward python pep-8 specs

set nocompatible	" Use Vim defaults
set mouse=a		" Automatically enable mouse usage
set bs=indent,eol,start	" Allow backspacing over everything in insert mode
set history=500		" Keep a decent-sized history
set autoread		" Automatically update files changed outside of vim
set ruler		" Show the cursor position all the time
set number		" Show line numbers
syntax on		" Color syntax highlighting

" Folding... use za to toggle... then zM,zR,zr,zm
set nofoldenable	" Auto fold code by default
set foldmethod=indent	" fold based on indent
"set foldnestmax=10	" deepest fold is 10 levels
set foldlevel=1		" default fold level


"colorscheme elflord
"colorscheme darkblue

" Automatically indent based on file type: ``filetype indent on``
" Keep indentation level from previous line: ``set autoindent``
" ``set ai`` "Auto indent
" ``set si`` "Smart indent

" Folding based on indentation: ``set foldmethod=indent``
" set foldmethod=indent

" When editing a file, always jump to the last cursor position
au BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal! g'\"" |
\ endif

" Don't write swapfile on most commonly used directories for NFS mounts or USB sticks
au BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): 
"``set bomb``

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.cpp,*.cc,*.h,*.html,*.php,*.css set tabstop=4 softtabstop=4

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.html,*.php,*.css set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.html,*.php,*.css set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set noexpandtab
    en
endf
au BufRead,BufNewFile *.c,*.cpp,*.cc,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*.cc,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*.cc,*.h set textwidth=79
au BufRead *.txt set tw=78

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.cpp,*.cc,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.cpp,*.cc,*.h set fileformat=unix

" Delete trailing white space!!!
fu DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endf
au FileType c,cpp,java,php,ruby,python,html au BufWritePre <buffer> call DeleteTrailingWS()

" For full syntax highlighting:
let python_highlight_all=1


" ------------
" Statusline
" ------------
" Always show the statusline
set laststatus=2
set statusline=%#comment#
set statusline+=%-3.3n\ 	" buffer number
set statusline+=%#type#
set statusline+=%-0.20f\ 		" filename
set statusline+=%#constant#
set statusline+=%h%m%r%w	" buffnum,modified,read,write,help
set statusline+=%#comment#
set statusline+=[%{strlen(&ft)?&ft:'none'},	" filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " file encoding
set statusline+=%{&ff}] 	" file format
set statusline+=%=      	" right align
set statusline+=%#statement#
"set statusline+=%b,0x%-8B	" current char
"set statusline+=%{strftime(\"%c\",getftime(expand(\"%:p\")))} 	"file mtime
"set statusline+=%-{strftime(\"%a\ %Y-%m-%d,\ %H:%M:%S\")}	"datetime
set statusline+=%#identifier#
set statusline+=%10((%c,%l)%) 	" line and column
set statusline+=%#comment#
set statusline+=\ %p%%    	" percent through file (of cursor)

" --------
" Mappings
" --------
let mapleader = ','	" The default is '\' but many people prefer ','

" Help with lazy SHIFT + ':' in command-line mode
nnoremap ; :

" Wrapped lines goes down/up to next ROW, rather than the next LINE
nnoremap j gj
nnoremap k gk

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with D and C
nnoremap Y y$

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" visual shifting (does not exit VISUAL MODE)
vnoremap < <gv
vnoremap > >gv

