" Create needed folder
silent !mkdir -p $HOME/.vim/.swap

" Be iMproved, required
if &compatible
    set nocompatible
endif

" viminfo: remember certain things when we exit
set viminfo=%50,\"100,'20,/20,:50,h,f1,n$HOME/.vim/.swap/viminfo
"           |    |    |   |   |   | |  + viminfo file path
"           |    |    |   |   |   | + file marks 0-9,A-Z. 0 = not storeed
"           |    |    |   |   |   + disable hlsearch loading viminfo
"           |    |    |   |   + command line history saved
"           |    |    |   + search history saved
"           |    |    + file marks saved
"           |    + lines saved each register (old name for <, vi6,2)
"           + save/restore buffer list

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | PlugInstall | so $HOME/.vimrc
endif

call plug#begin('$HOME/.vim/bundle')
Plug 'vim-scripts/Modeliner', {'tag': '0.3.0'}
Plug 'ervandew/supertab', {'tag': '2.1'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0', 'on': 'NERDTreeToggle'}
Plug 'tomasr/molokai'
Plug 'aperezdc/vim-template'
Plug 'vim-airline/vim-airline', {'tag': 'v0.9'}
Plug 'godlygeek/tabular', {'tag': '1.0.0'}
Plug 'tpope/vim-fugitive', {'tag': 'v2.5'}
Plug 'mhinz/vim-signify', {'tag': 'v1.9'}

Plug 'elzr/vim-json'
Plug 'darfink/vim-plist'
Plug 'hail2u/vim-css3-syntax', {'tag': 'v1.2.0'}
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'hdima/python-syntax', {'tag': 'r3.5.0'}
Plug 'fatih/vim-go', {'tag': 'v1.19'}
call plug#end()

" global
syntax on
set cursorline
"set cursorcolumn
set number
"set relativenumber
set title
"set t_ti= t_te=
set ruler
set virtualedit=onemore             " block, insert, all, onemore
set list!                           " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,latin1
"set langmenu=zh_CN.UTF-8
"set helplang=cn

" colorscheme
try
    set t_Co=256
    colorscheme molokai
    let g:molokai_original = 1
catch
    colorscheme default
endtry

" Misc
filetype plugin indent on
set hidden
set wildmenu                        " Enhanced completion hints in command
set wildmode=list:longest,full
set backspace=eol,start,indent      " Allow backspace
set complete=.,w,b,u,U,t,i,d        " Do lots of scanning on tab completion
set updatecount=100                 " Write swap file to disk every 100 chars
"set autochdir
set directory=$HOME/.vim/.swap      " Directory to use for the swap file
set diffopt=filler,iwhite
set history=10000
"set wrap
"set linebreak
set scrolloff=3
set visualbell t_vb=                " Disable error bells
set shortmess+=A                    " Always edit file
set nobackup                        " close backup files
set nowritebackup
set modifiable
"set laststatus=2
set mouse=a                         " Mouse wheel
let g:netrw_home=$HOME.'/.vim/.swap'
"set showcmd
"set magic

" Formatting, indentation and tabbing
set autoindent smartindent
set smarttab                        " Make <tab> and <backspace> smarter
set expandtab
"set noexpandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set formatoptions-=t formatoptions+=croql
set modeline

" Undo
set undolevels=10000
if has("persistent_undo")
    set undodir=$HOME/.vim/.swap
    set undofile
    set undoreload=10000
endif

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Search settings
set ignorecase                      " ignore case buring search
set smartcase                       " ignore 'ignorecase' when UPPer in search
set hlsearch                        " highlight search
set incsearch                       " do incremental searching
set showmatch                       " show matching parenthese
set wrapscan

set textwidth=0
autocmd FileType cmake,css,fortran,lisp,make,perl,sh,c,cpp,vim
            \ setlocal textwidth=78 colorcolumn=+1 wrap linebreak formatoptions+=t
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \ exe "normal g'\"zz" |
            \ endif |

" After 4s of inactivity, check for file modifications on next keyrpress
autocmd CursorHold * checktime

" Keybindings
let mapleader=","
let localmapleader=","

" Follow scroll wheel to cursor
noremap <ScrollWheelUp>     3k
noremap <ScrollWheelDown>   3j


nnoremap <Leader>s  :%S/
vnoremap <Leader>s  :S/

vnoremap .  :normal .<cr>
vnoremap @  :normal! @

" up/down on displayed lines, not real lines. More useful than painful.
nnoremap k   gk
nnoremap j   gj

" TODO toggle numbers
noremap <Leader>/  :nohlsearch<cr>

" tabprevious and tabnext
noremap <S-l>      :tabprevious<cr>
noremap <S-h>      :tabnext<cr>

" TODO Do also cnext and cprev as a fallback
noremap <PageDown>  :lnext<cr>
noremap <PageUp>    :lprev<cr>

" Disable K for manpages - not used often and easy to accidentally hit
noremap K   k

" Resize window splits
nnoremap <C-k>  3<C-w>-
nnoremap <C-j>  3<C-w>+
nnoremap <C-h>  3<C-w><
nnoremap <C-l>  3<C-w>>

" Split window
nnoremap _  :split<cr>
nnoremap \| :vsplit<cr>

vnoremap s  :!sort<cr>
vnoremap u  :!sort -u<cr>

" Write file when you forget to use sudo
cmap w!!    w !sudo tee % >/dev/null

" Cscope
if has("cscope")
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set cscopeverbose
endif

" airline
if !empty(glob('~/.vim/bundle/vim-airline'))
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    if !has('gui')
        let g:airline_symbols.branch = '⎇'
    endif
endif


" CSS3-Syntax
if !empty(glob('~/.vim/bundle/vim-css3-syntax'))
    augroup VimCSS3Syntax
        autocmd!
        autocmd FileType css setlocal iskeyword+=-
    augroup END
endif

" NERDTree
if !empty(glob('~/.vim/bundle/nerdtree'))
    nnoremap <C-n> :NERDTreeToggle<cr>
    let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
                \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo', '\.elc$',
                \ '\.doc\?', '\.xls\?', '\.ppt\?', '\.rtf$', '\.iso$', '\.o$',
                \ '\.img', '\.jp\+g$', '\.png$', '\.gif$', '\.svg$', '\.bmp$',
                \ '\.tiff$', '\.pdf$' ]
    let NERDTreeHighlightCursorline = 1
    let NERDTreeShowBookmarks = 1
    let NERDTreeShowFiles = 1
endif

" Signify
if !empty(glob('~/.vim/bundle/vim-signify'))
    let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
endif

" Supertab
if !empty(glob('~/.vim/bundle/supertab'))
    let g:SuperTabDefaultCompletionType = "<c-n>"
endif

" Markdown
if !empty(glob('~/.vim/bundle/vim-markdown'))
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_json_frontmatter = 1
endif

" Python syntax highligh
if !empty(glob('~/.vim/bundle/python-syntax'))
    let g:python_highlight_all = 1
endif

" VIM JSON
if !empty(glob('~/.vim/bundle/vim-json'))
    let g:vim_json_syntax_conceal = 0
endif

" Golang
if !empty(glob('~/.vim/bundle/vim-go'))
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_interfaces = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_autosave = 0
endif

" Local config
silent! so $HOME/.vim/vimrc.mine

" vim: set et fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
