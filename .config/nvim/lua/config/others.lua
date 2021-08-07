require'colorizer'.setup()
require'nvim-web-devicons'.setup()
require('indent_guides').setup({
  even_colors = { fg ='#2a3834',bg='#303030' };
  odd_colors = { fg='#2a3834',bg='#2a3834' };
})
require("lsp-rooter").setup {}
require("tmux").setup({
  copy_sync = {
    enable = false,
  },
  navigation = {
    enable_default_keybindings = true,
    persist_zoom = false,
  },
})
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})
require("luasnip/loaders/from_vscode").lazy_load()
require("refactoring").setup {}
require('numb').setup()
require("mkdir")
