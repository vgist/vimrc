set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set visualbell t_vb=

autocmd VimEnter * set vb t_vb=
set gcr = n:blinkon0
set lines=50 columns=120

map <F1> :set guifont=Monospace\ 9<CR>
map <F2> :set guifont=Monospace\ 14<CR>

" theme
try
    colorscheme monokai-light
catch
    colorscheme default
endtry

" macvim
if has("gui_macvim")
    set guifont=Monaco:h14

    " Fullscreen takes up entire screen
    set fuoptions = maxhorz,maxvert

    " Command-Return for fullscreen
    macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>
endif

silent! so $HOME/.vim/gvimrc.mine
