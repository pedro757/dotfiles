" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set cot=menuone,noinsert,noselect
set shm+=c
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                     	  " treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set relativenumber
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set signcolumn=yes
set scroll=20
set scrolloff=10
set colorcolumn=120                     " Colorear columna guia
set tw=120
set termguicolors
set noswapfile
set undodir=/tmp/.vim-undo-dir
set undofile

if !isdirectory("/tmp/.vim-undo-dir")
  call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif

augroup StopNewlineComments
  autocmd!
  autocmd FileType * setlocal formatoptions-=cro
augroup END

augroup TrimSpaces
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

augroup OnlyOneCursorLine
  autocmd!
  autocmd WinEnter,InsertLeave * set cursorline
  autocmd WinLeave,InsertEnter * set nocursorline
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 140})
augroup END

augroup AutoFormating
  autocmd!
  autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js Neoformat
augroup END

augroup Pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard'})
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

command WW SudaWrite
