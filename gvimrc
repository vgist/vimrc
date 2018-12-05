set guioptions-=m   "remove menu bar
set guioptions-=T   "remove toolbar
set guioptions-=r   "remove right-hand scroll bar
set guioptions-=L   "remove left-hand scroll bar

set lines=50 columns=140
autocmd VimEnter * set vb t_vb=

" theme
try
    colorscheme molokai
catch
    colorscheme default
endtry

if has('unix')
    set scrolloff=999
    if has("mac")
        set guifont=Monaco:h13
        noremap <D-0> :set guifont=Monaco:h13<CR>       " Command + 0
    else
        set guifont=Monospace\ 11
        noremap <C-F1> :set guifont=Monospace\ 11<CR>
        noremap <C-F2> :set guifont=Monospace\ 13<CR>
    endif
" elseif has("win32") || has('win64')
"   set ...
endif

silent! so $HOME/.vim/gvimrc.mine
