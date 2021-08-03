-- require("neoscroll").setup()
require'colorizer'.setup()
require'nvim-web-devicons'.setup()
-- require('shade').setup({
--   silent = true,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>st',
--   }
-- })
require('indent_guides').setup({
  even_colors = { fg ='#2a3834',bg='#303030' };
  odd_colors = { fg='#2a3834',bg='#2a3834' };

})
require("lsp-rooter").setup {}
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})
require("luasnip/loaders/from_vscode").lazy_load()
require("refactoring").setup {}
-- require("which-key").setup{
--   plugins = {
--     presets = {
--       operators = false,
--       motions = false,
--       text_objects = false,
--       windows = false,
--       nav = false,
--       z = false,
--       g = false,
--     }
--   },
--   operators = {},
--   ignore_missing = true
-- }
require('numb').setup()
require("mkdir")
