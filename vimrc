" Joe Naegele's VIMRC, somewhat focused toward python pep-8 specs

set nocompatible	" Use Vim defaults
set mouse=a		" Automatically enable mouse usage
set bs=indent,eol,start	" Allow backspacing over everything in insert mode
set history=500		" Keep a decent-sized history
set autoread		" Automatically update files changed outside of vim
set showcmd             " Show cmd counter
set showmode            " Show current mode
set ruler		" Show the cursor position all the time
set number		" Show line numbers

filetype on         " Filetype recognition

" Folding... use za to toggle... then zM,zR,zo,zc
set nofoldenable	" Auto fold code by default
set foldmethod=indent	" fold based on indent
"set foldnestmax=10	" deepest fold is 10 levels
set foldlevel=1		" default fold level

""""""" Fonts """""""""

if has("gui_macvim") || has("gui_mac")
    set guifont=Menlo:h14
else
    set guifont=Deja\ Vu\ Sans\ Mono:h12
endif

if has("gui_running")
    set lines=40 columns=170
endif

"""""""""""""""""""""""""""""""" Pathogen """"""""""""""""""""""""""""""""""""

call pathogen#infect()  " adds all plugins in ~/.vim/bundle to runtime path

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if necessary, specify that the terminal emulator is 256 color
"set term=xterm-256color

set background=dark

colorscheme jellybeans

"colorscheme desert256

"colorscheme solarized	" Use <F5> to toggle solarized light/dark scheme
"if has('gui_running')
"   set background=light
"else
"   let g:solarized_termcolors=256
"endif

""""""""""" Syntax Highlighting """"""""""""
syntax on		" Color syntax highlighting

" For full syntax highlighting:
let python_highlight_all=1

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Indentation """"""""
" I just stick with Vim's indentation rules
filetype plugin indent on

" If I didn't use the 'filetype indentation plugin', I'd use the following:
" set autoindent    " Keep indentation level from previous line
" set smartindent   " Attempt to guess next indentation level
" set smarttab      " Not necessary since I'm not explicitly using hard tabs
" set cindent       " Vim will automatically enable this for the C-family of files

" C formatting (comments, code indentation...)
" formatoptions: wrap and auto-format comment blocks and such
" cinoptions: (l1 means align with case label, t0 means don't indent function return type)
au BufRead,BufNewFile *.c,*.cpp,*.cc,*.h,*.l,*.y set formatoptions=tcqlron cinoptions=l1,t0

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
au BufRead,BufNewFile * set softtabstop=4 shiftwidth=4 expandtab
au BufRead,BufNewFile Makefile* set softtabstop=8 shiftwidth=8 noexpandtab

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*.cc,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" au BufRead *.txt set tw=78

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile * set fileformat=unix

" Delete trailing white space!!!
fu DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endf
au FileType * au BufWritePre <buffer> call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Statusline """"""""

" Always show the statusline
set laststatus=2
"set statusline=%#comment#
set statusline+=%-3.3n\ 	" buffer number
"set statusline+=%#type#
set statusline+=%-0.20f\ 		" filename
"set statusline+=%#constant#
set statusline+=%h%m%r%w	" buffnum,modified,read,write,help
"set statusline+=%#comment#
set statusline+=[%{strlen(&ft)?&ft:'none'},	" filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " file encoding
set statusline+=%{&ff}] 	" file format
set statusline+=%=      	" right align
"set statusline+=%#statement#
set statusline+=%b,0x%-8B	" current char
"set statusline+=%{strftime(\"%c\",getftime(expand(\"%:p\")))} 	"file mtime
"set statusline+=%-{strftime(\"%a\ %Y-%m-%d,\ %H:%M:%S\")}	"datetime
"set statusline+=%#identifier#
set statusline+=%10((%c,%l)%) 	" line and column
"set statusline+=%#comment#
set statusline+=\ %p%%    	" percent through file (of cursor)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Mappings """"""""
"
let mapleader = ','	" The default is '\' but many people prefer ','

" Help with lazy SHIFT + ':' in command-line mode
nnoremap ; :

" Wrapped lines goes down/up to next ROW, rather than the next LINE
nnoremap j gj
nnoremap k gk

" Stupid shift key fixes
cmap WQ wq
cmap wQ wq
cmap Wq wq
cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with D and C
nnoremap Y y$

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" visual shifting (does not exit VISUAL MODE)
vnoremap < <gv
vnoremap > >gv

