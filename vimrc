" Be iMproved, required
if &compatible
    set nocompatible
endif

" encoding
scriptencoding utf-8
setglobal fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos,mac

" Create needed folder
if !isdirectory($HOME . '/.vim/.swap')
    call mkdir($HOME . '/.vim/.swap', 'p')
endif
if !isdirectory($HOME . '/.vim/.undo')
    call mkdir($HOME . '/.vim/.undo', 'p')
endif

" MacOS & Unix italic
if has("unix")
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
endif

" viminfo: buffers, registers, marks, search/cmd history, no hlsearch
set viminfo=%50,\"100,'20,/100,:10000,h,f1
set viminfofile=$HOME/.vim/.swap/viminfo


" Global Settings
syntax on
set cursorline
set number
set title
set ruler                           " Always show current position
set virtualedit=onemore             " block, insert, all, onemore
set list                            " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«,nbsp:␣

" Formatting, indentation and tabbing
set autoindent shiftround
set smarttab                        " Make <tab> and <backspace> smarter
set expandtab                       " expand tabs to spaces
set tabstop=4 softtabstop=4 shiftwidth=4
set formatoptions-=t formatoptions+=croql

" Misc
filetype plugin indent on
set hidden
set wildmenu                        " Enhanced completion hints in command
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.pyc,*.pyo,*.class,*.swp,*.zip,.git/*,node_modules/*,dist/*,build/*
set complete=.,w,b,u,i            " Do lots of scanning on tab completion
set completeopt=menu,menuone,noselect
set updatecount=100                 " Write swap file to disk every 100 chars
set updatetime=1000                 " Faster CursorHold (checktime, signify)
set path+=**                        " Recursive :find
set signcolumn=yes                  " Keep sign column width stable
set directory=$HOME/.vim/.swap//    " Directory to use for the swap file
set diffopt=filler,iwhite,vertical
set history=10000
"set wrap
"set linebreak
set scrolloff=3
set visualbell t_vb=                " Disable error bells
set nowritebackup
set mouse=a                         " Mouse wheel
let g:netrw_home=$HOME.'/.vim/.swap'

" Persistent undo
set undolevels=10000
if has("persistent_undo")
    set undodir=$HOME/.vim/.undo
    set undofile
endif

" No swap/undo files for sensitive or system files
augroup vimrc_private
    autocmd!
    autocmd BufReadPre $HOME/.ssh/*,$HOME/.gnupg/*,/etc/*,/tmp/*,/private/tmp/*
                \ setlocal noswapfile noundofile
augroup END

" Search settings
set ignorecase                      " ignore case buring search
set smartcase                       " ignore 'ignorecase' when UPPer in search
set hlsearch                        " highlight search
set incsearch                       " do incremental searching
set showmatch                       " show matching parenthese

augroup vimrc_filetype
    autocmd!
    autocmd FileType c,cmake,cpp,css,fortran,lisp,make,perl,scss,sh,vim
                \ setlocal textwidth=78 colorcolumn=+1 wrap linebreak formatoptions+=t
    autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
augroup END

" Auto reload when editing this config
if !empty($MYVIMRC)
    augroup vimrc_autoreload
        autocmd!
        autocmd BufWritePost vimrc,gvimrc
                \ if resolve(expand('<afile>:p')) ==# resolve($MYVIMRC) |
                \     source $MYVIMRC |
                \ elseif !empty($MYGVIMRC)
                \     && resolve(expand('<afile>:p')) ==# resolve($MYGVIMRC) |
                \     source $MYGVIMRC |
                \ endif
    augroup END
endif

augroup vimrc_misc
    autocmd!
    " When opening a file, always jump to the last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \ exe "normal g'\"zz" |
                \ endif |
    " After 4s of inactivity, check for file modifications on next keypress
    autocmd CursorHold * checktime
augroup END

" Cscope
if has("cscope")
    set cscopetag
    set csto=0
    set cscopeverbose
    if filereadable("cscope.out")
        cs add cscope.out
    endif
endif

" Keybindings
let mapleader=","
let maplocalleader="\\"

" allow saving files as sudo
cnoremap w!! w !sudo tee > /dev/null %

" yank to clipboard
if has("clipboard")
    " Check if we are in an SSH session, and if there is no X11 forwarding
    if !empty($SSH_TTY) && empty($DISPLAY)
        set clipboard=
    else
        " unnamedplus is accepted with +clipboard even when has('unnamedplus')
        " reports 0 (e.g. macOS system vim)
        set clipboard=unnamed,unnamedplus
    endif
endif

" Follow scroll wheel to cursor
nnoremap <ScrollWheelUp>     3k
nnoremap <ScrollWheelDown>   3j

nnoremap <Leader>s  :%s/
vnoremap <Leader>s  :s/

vnoremap .  :normal .<cr>
vnoremap @  :normal! @@<cr>

" up/down on displayed lines, not real lines. More useful than painful.
nnoremap k   gk
nnoremap j   gj

" clear search highlight
noremap <Leader>/  :nohlsearch<cr>

" Disable K for manpages - not used often and easy to accidentally hit
noremap K   k

" Resize window splits
nnoremap <C-k>  3<C-w>-
nnoremap <C-j>  3<C-w>+
nnoremap <C-h>  3<C-w><
nnoremap <C-l>  3<C-w>>

" colorscheme
try
    colorscheme lucario
    hi CursorLineNr ctermfg=NONE ctermbg=236 cterm=bold guifg=NONE guibg=#405160 gui=NONE
    hi SpecialKey   ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#61bbc8 guibg=NONE gui=NONE
    hi Comment      ctermfg=44 ctermbg=NONE cterm=italic guifg=#5c98cd guibg=NONE gui=italic
    hi clear SignColumn
catch
    colorscheme default
endtry

" Load plug.vim
silent! so $HOME/.vim/plugrc.vim

" vim: set et fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
