set guioptions-=l   " remove left scrollbar
set guioptions-=r   " remove right scrollbar
set guioptions-=b   " remove bottom horizontal scrollbar
set guioptions-=L   " remove left scrollbar in split window
set guioptions-=R   " remove right scrollbar in split window
set guioptions-=m   " remove menu bar
set guioptions-=T   " remove toolbar

""""""" Fonts """""""""
if has("gui_macvim") || has("gui_mac")
    set guifont=Menlo:h12
elseif has("gui_gtk2")
    set guifont=Deja\ Vu\ Sans\ Mono\ 10
elseif has("gui_win32")
    set guifont=Inconsolata:h12
endif

""""""" GUI """"""""
if has("gui_running")
    set lines=40 columns=192  " open maximized
    set guitablabel=%M\ %t
endif

