" tagbar is broken on VIM < 7.0.167
if version < 702
    let g:loaded_tagbar = 1
endif

set nocompatible        " Use Vim defaults

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic.git'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'

Plugin 'fatih/vim-go.git'
Plugin 'rust-lang/rust.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'killphi/vim-ebnf.git'
Plugin 'raichoo/haskell-vim'
Plugin 'JuliaLang/julia-vim'
Plugin 'andreimaxim/vim-io.git'
Plugin 'lemon.vim'

Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sonoma.vim'

Plugin 'naegelejd/vim-abbreviations'
Plugin 'naegelejd/luci', {'rtp': 'etc/vim/'}
Plugin 'naegelejd/nolli', {'rtp': 'etc/vim/'}
Plugin 'naegelejd/vim-swig'

call vundle#end()

filetype plugin indent on   " Filetype recognition

set mouse=a             " Automatically enable mouse usage
set ttyfast
set autowrite           " Automatically write buffer
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set history=500         " Keep a decent-sized history
set autoread            " Automatically update files changed outside of vim
set showcmd             " Show cmd counter
set noshowmode          " Hide mode name at bottom of scren
set ruler               " Show the cursor position all the time
set number              " Show line numbers
set ignorecase          " Ignore case when searching
set smartcase           " Do smart things with capitalization when searching
set hlsearch            " Highlight search matches
set incsearch           " 'relatime' search matching

set tildeop             " Make ~ act like a normal operator

set lazyredraw          " Don't redraw while executing macros
set magic               " regular expressions

set noerrorbells        " Turn off error bell
set visualbell          " temporarily enable visual bell
set t_vb=               " Really turn off bells (flashing)
au GUIEnter * set visualbell t_vb=  " Must be set after GUI starts

set modeline            " check for mode lines at top/bottom of file
set modelines=4         " number of lines checked

set nostartofline       " Maintain cursor column position for 'gg','G','H','M','L'
set linebreak
set showbreak=↪\

set scrolloff=4         " keep cursor within 4 lines from edge of window
set scrolljump=1        " scroll a line at a time

set wildmenu                    " show list for autocomplete
set wildmode=list:longest:full  " priority for tab completion
set wildignore+=*/.git/*,*/.DS_Store

set tags=./tags;$HOME

" set smartindent   " (Prefer filetype indent)
" set cindent       " (Prefer filetype indent)
set formatoptions=tcroqnlj
set cinoptions=:0,l1,N-s,t0,+2*N

set smarttab      " Not necessary since I'm not explicitly using hard tabs
set expandtab     " convert tabs to spaces
" set tabstop=4
set softtabstop=4
set shiftwidth=4

set list
set listchars=tab:\|·,trail:·   " Show hidden chars (no eol marker)

set shiftround          " round indent to multiple of shiftwidth

set showmatch           " show matching parenthesis
set matchtime=2         " for 2ms

set splitbelow          " split new window to bottom
set splitright          " split new window to right

set laststatus=2        " Always show the statusline

" Folding... use za to toggle... then zM,zR,zo,zc
" set foldmethod=indent " fold based on indent
set foldmethod=syntax   " fold based on syntax (better for C)
set nofoldenable        " Keep folds open by default
set foldnestmax=10      " deepest fold is 10 levels
set foldlevel=1         " default fold level

set encoding=utf8       " UTF-8 as default encoding
set fileformats=unix,mac,dos    " file format precedence

set viminfo^=%      " Remember info about open buffers on close

set virtualedit+=block  " Allow block selection of shape

set t_Co=256        " Set number of colors to 256 by default

let mapleader = ','     " The default is '\' but many people prefer ','


"""""""""""""""""""""""""""""""""" vim-go """"""""""""""""""""""""""""""""""""

let g:go_fmt_fail_silently = 1  " don't pop up quickfix window

""""""""""""""""""""""""""""""" vim-markdown """""""""""""""""""""""""""""""""

let g:vim_markdown_folding_disabled=1

""""""""""""""""""""""""""""""" Supertab """""""""""""""""""""""""""""""""""""

" don't attempt to autocomplete after any symbols, spaces, etc.
let g:SuperTabNoCompleteAfter = [
        \ '+', '-', '\*', '/', '%', '\^', '|', '\~', '!',
        \ '@', '#', '$', '&', ',', '\.', '?', ':', ';',
        \ "'", '"', '\\', '`',
        \ '<', '>', '[', ']', '{', '}', '(', ')',
        \ '\s', '^']

"""""""""""""""""""""""""""""" NERDTree """"""""""""""""""""""""""""""""""""""

nmap <leader>n :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""" Tagbar  """"""""""""""""""""""""""""""""""""""

" Open Tagbar on left rather than (default) right
let g:tagbar_left = 1
let g:tagbar_width = 30
nmap <leader>tb :TagbarToggle<CR>

"""""""""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""""""""""""
" reminder: SyntasticCheck()
" reminder: Errors()

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'

" automatically show errors and close when fixed
" let g:syntastic_auto_loc_list = 1

" let g:syntastic_go_checkers = ['gofmt']
let g:syntastic_c_checkers = ['make']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_haskell_checkers = ['ghc-mod']
let g:syntastic_lua_checkers = ['luac']
let g:syntastic_sh_checkers = ['sh']
let g:syntastic_xml_checkers = ['xmllint']
let g:syntastic_javascript_checkers = ['jsl']

""""""""""" Syntax Highlighting """"""""""""
syntax on               " Color syntax highlighting

" if necessary, specify that the terminal emulator is 256 color
"set term=xterm-256color

" ensure solarized looks good in terminal
let g:solarized_termcolors=256

let s:mycolors = ['default', 'jellybeans', 'desert256', 'zenburn', 'wombat', 'molokai', 'mayansmoke', 'solarized']
function! NextColor()
    if len(s:mycolors) == 0
        execute 'colorscheme default'
    endif
    if exists('g:colors_name')
        let l:current = index(s:mycolors, g:colors_name)
    else
        let l:current = -1
    endif
    let l:newindex = (l:current + 1) % len(s:mycolors)
    let l:scheme = s:mycolors[l:newindex]
    execute 'colorscheme ' . l:scheme
    redraw
    echo l:scheme
endfunction

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
" ensure the TrailingWhitespace colors persist through colorscheme changes
au ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
" Don't match trailing whitespace while typing in insert mode
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinEnter * match TrailingWhitespace /\s\+$/
" Clear matches after leaving a window for performance reasons
au BufWinLeave * call clearmatches()

" For full syntax highlighting:
let python_highlight_all=1

" Highlight bad spaces in C code
let c_space_errors = 1

fu! DeleteTrailingWS()
  execute "normal mz"
  %s/\s\+$//ge
  execute "normal `z"
endfu

fu! DeleteAllTabs()
  exe "normal mz"
  %s/\t//ge
  exe "normal `z"
endfu

fu! PadOperators()
    " Pad binary operators with a space on either side
    " FIXME! - Breaks 2-char operators (+=, <=, ==)
    exe "normal mz"
    %s/\([^ ]\)\([+\-*/%|^&<>=]=?\)/\1 \2 /ge
    %s/\([<>=+\-/*?&|^%]\)\([^ ]\)/\1 \2 /ge
    exe "normal `z"
endfu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When editing a file, always jump to the last cursor position
au BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif

" Don't write swapfile on most commonly used directories for NFS mounts or USB sticks
au BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file):
"``set bomb``

"""""""" Filetype-specific """"""""

au FileType make,go setlocal softtabstop=8 shiftwidth=8 noexpandtab
au FileType html,markdown setlocal softtabstop=2 shiftwidth=2

au FileType go setlocal nolist

"""""""" Mappings """"""""

let mapleader = ','     " The default is '\' but many people prefer ','

" Map 'jk' and 'jk' to ESC for simpler return to normal mode
inoremap jk <ESC>
inoremap kj <ESC>
cnoremap jk <C-c>
cnoremap kj <C-c>

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

" Easier window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Yank from the cursor to the end of the line, to be consistent with D and C
nnoremap Y y$

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" visual shifting (does not exit VISUAL MODE)
vnoremap < <gv
vnoremap > >gv

" move cursor to after pasted yanked/pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" prevent command window from accidentally opening
map q: :q

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" Map colorscheme rotation
map <F3> :call NextColor()<CR>
nmap <silent> <leader>colo :call NextColor()<CR>

" Map background toggle (light / dark)
map <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nmap <silent> <leader>tbg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Map deletion of trailing white space
map <F6> :call DeleteTrailingWS()<CR>
nmap <silent> <leader>dtw :call DeleteTrailingWS()<CR>

" delete all tabs in the buffer
nmap <silent> <leader>dat :call DeleteAllTabs()<CR>

" ensure all binary operators are padded with a space on either side
nmap <silent> <leader>po :call PadOperators()<CR>

" redraw screen (Since I mapped Ctrl-L to window navigation)
nmap <leader>r :redraw!<CR>

" toggle paste mode
nmap <leader>pp :setlocal paste!<CR>

" Pressing ,ss will toggle and untoggle Spell-Checking
map <leader>ss :setlocal spell!<CR>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Map tag and pop for ctags
" Note the intentional space after ':tag'
nmap <silent> <leader>t :tag 
nmap <silent> <leader>p :pop<CR>

" Search for selected text, forwards or backwards (vim.wikia.com)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

function! SendBuffer(port)
python << EOF
import vim
import socket
port = int(vim.eval("a:port"))
ADDR = ('localhost', port)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)
for line in vim.current.buffer:
    sock.send(line)
sock.close()
EOF
endfunction
