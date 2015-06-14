"""""""""""""""""""""""""
" Basic features
"""""""""""""""""""""""""
let pathogen_disabled = []
if !has('gui_running')
    call add(g:pathogen_disabled, 'css-color')
endif
silent! call pathogen#infect()

" Display options
syntax on
set cursorline
set number
set list!                       " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

" color
if $TERM =~ '^xterm' || $TERM =~ '^screen' || $TERM=~ '256color$' || has('gui_running')
    try
        colorscheme monokai
    catch
        colorscheme default
    endtry
endif

" Statusline
if has("statusline")
    set statusline=%F%m%r%h%w\ %=[FORMAT=%{&ff}]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [TYPE=%Y]\ [POS=%l,%v][%p%%]
    set laststatus=2
endif

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,latin1

" foldenable
if exists("&foldenable") && v:version >= 700
    set foldenable
    " set foldcolumn=2
    set foldmethod=indent
    set foldlevel=1
endif

" Misc
filetype plugin indent on       " Do filetype detection and load custom file plugins and indent files
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set wildmode=list:longest,full  " Complete longest common match and show possible matches and wildmenu
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set updatecount=100             " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before the horizontal window border
set visualbell t_vb=            " Disable error bells
set shortmess+=A                " Always edit file, even when swap file is found
set nobackup
set nowritebackup

" up/down on displayed lines, not real lines. More useful than painful.
noremap k gk
noremap j gj

" Formatting, indentation and tabbing
"set autoindent
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
"set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set formatoptions-=t formatoptions+=croql
set modeline

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each registeD
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:1000,n~/.vim/swap/viminfo

" ctags: recurse up to home to find tags. See
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" for an explanation and other ctags tips/tricks
set tags+=tags;$HOME

" Undo
set undolevels=10000
if has("persistent_undo")
    set undodir=~/.vim/.undo        " Allow undoes to persist even after a file is closed
    set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" to_html settings
let html_number_lines = 1
let html_ignore_folding = 1
let html_use_css = 1
let xml_use_xhtml = 1

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \     exe "normal g'\"zz" |
            \ endif |


" After 4s of inactivity, check for external file modifications on next keyrpress
au CursorHold * checktime

"""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""
let mapleader=","
let localmapleader=","

nmap <Leader>s :%S/
vmap <Leader>s :S/

vnoremap . :normal .<CR>
vnoremap @ :normal! @

" Toggles
set pastetoggle=<F1>
" the nmap is just for quicker powerline feedback
nmap <silent> <F1>      :set invpaste<CR>
nmap          <F2>      :setlocal spell!<CR>
imap          <F2> <C-o>:setlocal spell!<CR>
nmap <silent> <F3>      :set invwrap<CR>
" TODO toggle numbers

map <Leader>/ :nohlsearch<cr>
map <Home> :tprev<CR>
map <End>  :tnext<CR>

" TODO Do also cnext and cprev as a fallback
map <PageDown> :lnext<CR>
map <PageUp>   :lprev<CR>

" Disable K for manpages - not used often and easy to accidentally hit
noremap K k

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

vmap s :!sort<CR>
vmap u :!sort -u<CR>

" Write file when you forget to use sudo
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""
nnoremap <Leader>b :BufSurfBack<cr>
nnoremap <Leader>f :BufSurfForward<cr>

" TODO Merge the NERDTreeFind with Toggle inteilligently.
nnoremap <C-n> :NERDTreeToggle<cr>

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
            \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo', '\.elc$',
            \ '\.doc\?', '\.xls\?', '\.ppt\?', '\.rtf$', '\.iso$', '\.img',
            \ '\.jp\+g$', '\.png$', '\.gif$', '\.svg$', '\.bmp$', '\.tiff$', '\.pdf$' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

"autocmd vimenter * NERDTree
autocmd vimenter *
            \ if !argc() |
            \ NERDTree |
            \ endif |
autocmd bufenter *
            \ if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") |
            \ q |
            \ endif |
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

nnoremap <Leader>a :Ack

" Put a space around comment markers
let g:NERDSpaceDelims = 1

map <Leader>l :MBEOpen<cr>
let g:miniBufExplorerMoreThanOne = 10000
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplSplitBelow=1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplVSplit = 20

let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['c', 'html', 'python', 'ruby', 'scss', 'scala'] }

let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

let g:ctrlp_map = '<Leader>.'
let g:ctrlp_custom_ignore = '/\.\|\.o\|\.so'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']

"""""""""""""""""""""""""
" Tabular
"""""""""""""""""""""""""
noremap \= :Tabularize /=<CR>
noremap \: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap \> :Tabularize /=><CR>
noremap \, :Tabularize /,\zs/l0l1<CR>
noremap \{ :Tabularize /{<CR>
noremap \\| :Tabularize /\|<CR>
noremap \& :Tabularize /\(&\\|\\\\\)<CR>

"""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""
nnoremap <Leader>t :TagbarOpen fjc<CR>
let g:TagbarShowTag = 1

"""""""""""""""""""""""""
" Screen settings
"""""""""""""""""""""""""
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellInitialFocus = 'shell'
let g:ScreenShellQuitOnVimExit = 0

map <C-\> :ScreenShellVertical<CR>

"""""""""""""""""""""""""
" Ruby Stuff
"""""""""""""""""""""""""
command -nargs=? -complete=shellcmd W  :w | :call ScreenShellSend("load '".@%."';")
map <Leader>r :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
map <Leader>w :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>
map <Leader>, :w<CR> :call ScreenShellSend("\e[A")<CR>

"""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""
autocmd FileType python setlocal et sta sw=4 sts=4
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 10
map <F5> :!python %<CR>

"""""""""""""""""""""""""
" Cscope
"""""""""""""""""""""""""
if has("cscope")
    " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " Check cscope for definition of a symbol before checking ctags. Set to 1 if
    " you want the reverse search order.
    set csto=0

    " Add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    " Show msg when any other cscope db is added
    set cscopeverbose
end

"""""""""""""""""""""""""
" Markdown
"""""""""""""""""""""""""
let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_initial_foldlevel=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

"""""""""""""""""""""""""
" Local config
"""""""""""""""""""""""""
silent! so ~/.vim/vimrc.mine

" TODO raise contrast for comments
