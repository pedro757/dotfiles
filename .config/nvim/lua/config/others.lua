require'colorizer'.setup()
require'nvim-web-devicons'.setup()
require("indent_blankline").setup {
  char = "▏",
  show_current_context = true,
}
require("lsp-rooter").setup{}
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
require('kommentary.config').configure_language({"typescriptreact", "javascriptreact"}, {
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
