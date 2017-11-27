" Create needed folder
silent !mkdir -p $HOME/.vim/.swap

" Be iMproved, required
if &compatible
    set nocompatible
endif

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each registeD
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:1000,n$HOME/.vim/.swap/viminfo

"""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""

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
Plug 'vim-airline/vim-airline', {'tag': 'v0.8'}
Plug 'godlygeek/tabular', {'tag': '1.0.0'}
Plug 'tpope/vim-fugitive', {'tag': 'v2.2'}
Plug 'mhinz/vim-signify'

Plug 'elzr/vim-json'
Plug 'darfink/vim-plist'
Plug 'hail2u/vim-css3-syntax', {'tag': 'v0.25.0'}
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'hdima/python-syntax', {'tag': 'r3.5.0'}
Plug 'fatih/vim-go', {'tag': 'v1.15'}
call plug#end()

"""""""""""""""""""""""""
" global
"""""""""""""""""""""""""

syntax on
set cursorline
"set cursorcolumn
set number
set list!                           " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,latin1

" color
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
set directory=$HOME/.vim/.swap      " Directory to use for the swap file
set diffopt=filler,iwhite
set history=10000
set scrolloff=3
set visualbell t_vb=                " Disable error bells
set shortmess+=A                    " Always edit file
set nobackup                        " close backup files
set nowritebackup
set modifiable
set laststatus=2
set mouse=a                         " Mouse wheel
let g:netrw_home=$HOME.'/.vim/.swap'

" Formatting, indentation and tabbing
set autoindent smartindent
set smarttab                        " Make <tab> and <backspace> smarter
set expandtab
"set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions-=t formatoptions+=croql
set modeline

" Undo
set undolevels=10000
if has("persistent_undo")
    set undodir=$HOME/.vim/.swap
    set undofile
    set undoreload=10000
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" Stoping automatic wrapping and highlight colorcolumn
set textwidth=0
autocmd FileType cmake,css,fortran,lisp,make,perl,sh,vim
            \ setlocal textwidth=78 colorcolumn=+1

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \ exe "normal g'\"zz" |
            \ endif |

" After 4s of inactivity, check for file modifications on next keyrpress
au CursorHold * checktime

au FileType html setl sw=2 sts=2 et

"""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""
let mapleader=","
let localmapleader=","

" Follow scroll wheel to cursor
map <ScrollWheelUp>     3k
map <ScrollWheelDown>   3j


nmap <Leader>s  :%S/
vmap <Leader>s  :S/

vnoremap .  :normal .<CR>
vnoremap @  :normal! @

" up/down on displayed lines, not real lines. More useful than painful.
noremap k   gk
noremap j   gj

" TODO toggle numbers
map <Leader>/   :nohlsearch<cr>
map <S-l>       :tabprevious<CR>
map <S-h>       :tabnext<CR>

" TODO Do also cnext and cprev as a fallback
map <PageDown>  :lnext<CR>
map <PageUp>    :lprev<CR>

" Disable K for manpages - not used often and easy to accidentally hit
noremap K   k

" Resize window splits
nnoremap <C-k>  3<C-w>-
nnoremap <C-j>  3<C-w>+
nnoremap <C-h>  3<C-w><
nnoremap <C-l>  3<C-w>>

nnoremap _  :split<cr>
nnoremap \| :vsplit<cr>

vmap s  :!sort<CR>
vmap u  :!sort -u<CR>

" Write file when you forget to use sudo
cmap w!!    w !sudo tee % >/dev/null

"""""""""""""""""""""""""
" Cscope
"""""""""""""""""""""""""
if has("cscope")
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set cscopeverbose
endif

"""""""""""""""""""""""""
" airline
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-airline'))
    let g:airline_powerline_fonts = 0
    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'    " filename only
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_tabs = 0
    let g:airline#extensions#tabline#tab_nr_type = 2
    let g:airline#extensions#hunks#non_zero_only = 1    " git gutter
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:bufferline_echo = 0
    set timeoutlen=200
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    " unicode symbols instead of powerline fonts
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = '☰'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'
endif


"""""""""""""""""""""""""
" CSS3-Syntax
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-css3-syntax'))
    augroup VimCSS3Syntax
        autocmd!
        autocmd FileType css setlocal iskeyword+=-
    augroup END
endif

"""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/nerdtree'))
    nnoremap <C-n> :NERDTreeToggle<cr>
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo', '\.elc$',
                \ '\.doc\?', '\.xls\?', '\.ppt\?', '\.rtf$', '\.iso$',
                \ '\.img', '\.jp\+g$', '\.png$', '\.gif$', '\.svg$', '\.bmp$',
                \ '\.tiff$', '\.pdf$' ]
    let NERDTreeHighlightCursorline=1
    let NERDTreeShowBookmarks=1
    let NERDTreeShowFiles=1
endif

"""""""""""""""""""""""""
" Signify
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-signify'))
    let g:signify_vcs_list          = [ 'git', 'hg', 'svn' ]
endif

"""""""""""""""""""""""""
" template
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-template'))
    " let g:templates_plugin_loaded = 1
    " let g:templates_no_autocmd = 1
    let g:username = "Register"
    let g:email = "registerdedicated(at)gmail.com"
    let g:license = "GPLv3"
endif

"""""""""""""""""""""""""
" Supertab
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/supertab'))
    let g:SuperTabDefaultCompletionType = "<c-n>"
endif

"""""""""""""""""""""""""
" Markdown
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-markdown'))
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1
    let g:vim_markdown_math = 1
    let g:vim_markdown_json_frontmatter = 1
endif

"""""""""""""""""""""""""
" Python syntax highligh
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/python-syntax'))
    let g:python_highlight_all = 1
endif

"""""""""""""""""""""""""
" VIM JSON
"""""""""""""""""""""""""
if !empty(glob('~/.vim/bundle/vim-json'))
    let g:vim_json_syntax_conceal = 0
endif

"""""""""""""""""""""""""
" Golang
"""""""""""""""""""""""""
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

"""""""""""""""""""""""""
" Local config
"""""""""""""""""""""""""
silent! so $HOME/.vim/vimrc.mine

" vim: set et fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
