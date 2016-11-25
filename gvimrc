set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set lines=50 columns=120
autocmd VimEnter * set vb t_vb=

" theme
try
    colorscheme molokai
catch
    colorscheme default
endtry

if has('unix')
    if has("gui_macvim") || has("gui_mac") || has("mac")
        set guifont=Monaco:h11
        map <F1> :set guifont=Monaco:h11<CR>
        map <F2> :set guifont=Monaco:h13<CR>
        macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>   " Command + Enter
    else
        set guifont=Monospace\ 11
        map <C-F1> :set guifont=Monospace\ 11<CR>
        map <C-F2> :set guifont=Monospace\ 13<CR>
    endif
" elseif has("win32") || has('win64')
"   set ...
endif

silent! so $HOME/.vim/gvimrc.mine
