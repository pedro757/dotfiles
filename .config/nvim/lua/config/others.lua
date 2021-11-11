require'config/statusline'
require'colorizer'.setup()
require'nvim-web-devicons'.setup()
require'nvim-tree'.setup{
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  view = {
    mappings = {
      list = {
	{ key = { 'l' }, cb = require'nvim-tree.config'.nvim_tree_callback("edit") },
	{ key = { 'h' }, cb = require'nvim-tree.config'.nvim_tree_callback('close_node')}
      }
    }
  }
}
require("indent_blankline").setup {
  char = "▏",
  show_current_context = true,
}
require("project_nvim").setup {}
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
