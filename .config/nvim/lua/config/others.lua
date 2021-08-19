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
    cycle_navigation = true,
    enable_default_keybindings = true,
    persist_zoom = false,
  },
})
require('kommentary.config').configure_language("typescriptreact", {
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})
require('kommentary.config').configure_language("javascriptreact", {
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})
require('kommentary.config').configure_language("lua", {
  prefer_single_line_comments = true,
})
require("luasnip/loaders/from_vscode").lazy_load()
require("refactoring").setup {}
require('numb').setup()
require("mkdir")
