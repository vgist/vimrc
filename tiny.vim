set nocompatible
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos,mac
"set langmenu=zh_CN.UTF-8
"set helplang=cn

set list!                           " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
set backspace=eol,start,indent      " Allow backspace
set visualbell t_vb=                " Disable error bells
set virtualedit=onemore             " block, insert, all, onemore
set formatoptions-=t formatoptions+=croql

set smarttab                        " Make <tab> and <backspace> smarter
set expandtab                       " expand tabs to spaces
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent smartindent shiftround

set ignorecase                      " ignore case when searching
set smartcase                       " no ignorecase if Uppercase char present
