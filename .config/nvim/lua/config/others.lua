require'config/statusline'
require'colorizer'.setup()
require'nvim-web-devicons'.setup()
require'nvim-tree'.setup{
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  -- actions = {
  --   open_file = {
  --     quit_on_open = true
  --   }
  -- },
  view = {
    mappings = {
      list = {
	{ key = { 'l' }, action = "edit" },
	{ key = { 'h' }, action = "close_node" },
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
require('Comment').setup {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,
}
require("luasnip/loaders/from_vscode").lazy_load()
require("refactoring").setup {}
require('numb').setup()
require("mkdir")
require("gomove").setup {}
require("which-key").setup {
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = true,
      z = true,
      g = true,
    }
  }
}
require("tabout").setup {
  tabkey = "",
  backwards_tabkey = "",
}
require('neoscroll').setup()
require('incline').setup{
  hide = {
    focused_win = true,
  }
}
