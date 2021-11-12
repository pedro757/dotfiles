local opt = vim.opt
vim.g.mapleader    = ' '
opt.completeopt    = 'menu,menuone,noselect'
opt.hidden         = true
opt.wrap           = false
opt.encoding       = 'utf-8'
opt.pumheight      = 10
opt.fileencoding   = 'utf-8'
opt.ruler          = true
opt.cmdheight      = 2
opt.mouse          = 'a'
opt.splitbelow     = true
opt.splitright     = true
opt.conceallevel   = 0
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.background     = 'dark'
opt.showmode       = false
opt.backup         = false
opt.writebackup    = false
opt.updatetime     = 300
opt.timeoutlen     = 500
opt.clipboard      = 'unnamedplus'
opt.signcolumn     = 'yes'
opt.scroll         = 20
opt.scrolloff      = 10
opt.colorcolumn    = '120'
opt.textwidth      = 120
opt.termguicolors  = true
opt.swapfile       = false
opt.undodir        = '/tmp/.vim-undo-dir'
opt.undofile       = true
opt.foldmethod     = 'expr'
opt.foldexpr       = 'nvim_treesitter#foldexpr()'
opt.foldlevelstart = 20
opt.lazyredraw     = true
opt.iskeyword      :append('-')
opt.shortmess      :append('c')
