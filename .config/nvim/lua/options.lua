local opt = vim.opt
opt.completeopt    = 'menu,menuone,noselect'
opt.wrap           = false
opt.encoding       = 'utf-8'
opt.pumheight      = 10
opt.fileencoding   = 'utf-8'
opt.cmdheight      = 2
opt.mouse          = 'a'
opt.mousefocus     = true
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
opt.showtabline    = 0
opt.laststatus     = 3
opt.backup         = false
opt.writebackup    = false
opt.updatetime     = 400
opt.timeoutlen     = 500
opt.clipboard      = 'unnamedplus'
opt.signcolumn     = 'yes'
opt.scroll         = 20
opt.scrolloff      = 5
opt.colorcolumn    = '80'
opt.textwidth      = 80
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
opt.shell          = "/bin/bash"
opt.synmaxcol      = 1024
opt.emoji          = false

if require"utils".executable "rg" then
  opt.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
  opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end
