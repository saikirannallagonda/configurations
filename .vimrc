" Enable syntax highlighting
syntax on

" Set default color scheme
colorscheme desert

" Set line numbers
set number
set relativenumber

" Set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable auto-indentation
filetype on
filetype plugin on
filetype indent on

" Set the encoding
set encoding=utf-8

" Highlight current line
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Enable mouse support
set mouse=a

" show commands as you type them
set sc

" highlight search matches
set hls

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" recursive file search
set path+=**

" see possible completions
set wildmenu
set wildmode=list:longest,full

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Do not save backup files.
set nobackup

