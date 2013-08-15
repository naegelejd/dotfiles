" tagbar is broken on VIM < 7.0.167
if version < 702
    let g:loaded_tagbar = 1
endif

" Source Pathogen from bundle dir, rather than separate 'autoload' dir
runtime bundle/pathogen/autoload/pathogen.vim

set nocompatible        " Use Vim defaults
set mouse=a             " Automatically enable mouse usage
set ttyfast
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

set noerrorbells        " Turn off error bell
set visualbell          " temporarily enable visual bell
set t_vb=               " Really turn off bells (flashing)
au GUIEnter * set visualbell t_vb=  " Must be set after GUI starts

set modeline            " check for mode lines at top/bottom of file
set modelines=4         " number of lines checked

set nostartofline       " Maintain cursor column position for 'gg','G','H','M','L'
set linebreak
set showbreak=↪\

set scrolloff=1         " always show content after scroll
set scrolljump=5        " Minimum number of lines to scroll

set wildmenu                    " show list for autocomplete
set wildmode=list:longest:full  " priority for tab completion
set wildignore+=*/.git/*,*/.DS_Store

filetype off                " Turn off filetype recognition first, to force a reload
filetype plugin indent on   " Filetype recognition
set autoindent
set smartindent   " Attempt to guess next indentation level
set smarttab      " Not necessary since I'm not explicitly using hard tabs
set expandtab     " convert tabs to spaces
" set tabstop=4
set softtabstop=4
set shiftwidth=4

set nolist              " do not highlight whitespace
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


""""""" Fonts """""""""
if has("gui_macvim") || has("gui_mac")
    set guifont=Menlo:h14
elseif has("gui_gtk2")
    set guifont=Deja\ Vu\ Sans\ Mono\ 10
endif

""""""" GUI """"""""
if has("gui_running")
    set lines=40 columns=192  " open maximized
else
    set t_Co=256
endif

"""""""""""""""""""""""""""""""" Pathogen """"""""""""""""""""""""""""""""""""

call pathogen#infect()  " adds all plugins in ~/.vim/bundle to runtime path


""""""""""""""""""""""""""""""" Supertab """""""""""""""""""""""""""""""""""""

let g:SuperTabNoCompleteAfter = ['^', '|', '%', '*', '/', '-', '+', '!',
        \ '\.', '?', '"', "'", ',', ':', ';', '\\', '/*', '*/', '//',
        \ '<', '>', '{', '}', '[', ']', '(', ')', '\s']


""""""""""""""""""""""""""""""" Tagbar  """"""""""""""""""""""""""""""""""""""

" Open Tagbar on left rather than (default) right
let g:tagbar_left = 1
let g:tagbar_width = 30
nmap <F8> :TagbarToggle<CR>


"""""""""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""""""""""""
" SyntasticCheck()
" Errors()

let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'

" automatically show errors and close when fixed
" let g:syntastic_auto_loc_list = 1

let g:syntastic_c_checkers = ['make']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_haskell_checkers = ['ghc-mod']
let g:syntastic_lua_checkers = ['luac']
let g:syntastic_sh_checkers = ['sh']
let g:syntastic_xml_checkers = ['xmllint']

""""""""""" Syntax Highlighting """"""""""""
syntax on               " Color syntax highlighting

" if necessary, specify that the terminal emulator is 256 color
"set term=xterm-256color
if has("gui_running")
    colorscheme mayansmoke
else
    set background=dark
    colorscheme jellybeans
endif

" ensure solarized looks good in terminal
let g:solarized_termcolors=256

let s:mycolors = ['jellybeans', 'desert256', 'zenburn', 'wombat', 'molokai', 'mayansmoke', 'solarized']
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

" Highligh tabs
highlight BadTabs ctermbg=green guibg=green
2match BadTabs /\t/
au ColorScheme * highlight BadTabs ctermbg=green guibg=green

" For full syntax highlighting:
let python_highlight_all=1

" Highlight bad spaces in C code
let c_space_errors = 1

" Delete trailing white space!!!
function DeleteTrailingWS()
  execute "normal mz"
  %s/\s\+$//ge
  execute "normal `z"
endfunction

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

"""""""" Filetype-specific """"""""

" set cindent       " Vim will automatically enable this for the C-family of files

" C formatting (comments, code indentation...)
" formatoptions: wrap and auto-format comment blocks and such
" cinoptions: (l1 means align with case label, t0 means don't indent function return type)
" au BufRead,BufNewFile *.c,*.cpp,*.cc,*.h,*.l,*.y set formatoptions=tcqlron cinoptions=l1,t0
au BufRead,BufNewFile * set formatoptions=tcqlron cinoptions=l1,t0

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
au BufRead,BufNewFile * au BufRead,BufNewFile Makefile* set softtabstop=8 shiftwidth=8 noexpandtab

" Wrap text after a certain number of characters
" au BufRead *.txt set tw=78

" Use UNIX (\n) line endings.
au BufNewFile * set fileformat=unix

"""""""" Mappings """"""""

let mapleader = ','     " The default is '\' but many people prefer ','

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

" Map colorscheme rotation
map <F3> :call NextColor()<CR>
nmap <silent> <leader>colo :call NextColor()<CR>

" Map background toggle (light / dark)
map <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nmap <silent> <leader>tbg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Map deletion of trailing white space
map <F6> :call DeleteTrailingWS()<CR>
nmap <silent> <leader>dtw :call DeleteTrailingWS()<CR>
