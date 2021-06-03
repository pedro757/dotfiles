require("neoscroll").setup()
require'colorizer'.setup()
require'nvim-web-devicons'.setup()
require('shade').setup({
  silent = true,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>st',
  }
})
require('indent_guides').setup({
  even_colors = { fg ='#2a3834',bg='#322F2C' };
  odd_colors = { fg='#2a3834',bg='#2a3834' };
})
require("which-key").setup{}
