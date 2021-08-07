vim.g.mapleader      = ' '
vim.o.cot            = 'menuone,noselect'
vim.o.shm            = 'filnxtToOFc'
vim.o.hidden         = true
vim.o.wrap           = false
vim.o.encoding       = 'utf-8'
vim.o.pumheight      = 10
vim.o.fileencoding   = 'utf-8'
vim.o.ruler          = true
vim.o.cmdheight      = 2
vim.o.iskeyword      = '@,48-57,_,192-255,-'
vim.o.mouse          = 'a'
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.conceallevel   = 0
vim.o.tabstop        = 2
vim.o.shiftwidth     = 2
vim.o.smarttab       = true
vim.o.expandtab      = true
vim.o.smartindent    = true
vim.o.autoindent     = true
vim.o.laststatus     = 0
vim.o.number         = true
vim.o.relativenumber = true
vim.o.cursorline     = true
vim.o.background     = 'dark'
-- vim.o.showtabline    = 2
vim.o.showmode       = false
vim.o.backup         = false
vim.o.writebackup    = false
vim.o.updatetime     = 300
vim.o.timeoutlen     = 500
vim.o.clipboard      = 'unnamedplus'
vim.o.signcolumn     = 'yes'
vim.o.scroll         = 20
vim.o.scrolloff      = 10
vim.o.colorcolumn    = '120'
vim.o.tw             = 120
vim.o.termguicolors  = true
vim.o.swapfile       = false
vim.o.undodir        = '/tmp/.vim-undo-dir'
vim.o.undofile       = true
vim.o.foldmethod     = 'expr'
vim.o.foldexpr       = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 20
vim.cmd('syntax enable')
