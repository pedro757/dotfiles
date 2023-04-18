-- require "config/statusline"
require("colorizer").setup()
require("nvim-web-devicons").setup()
require("indent_blankline").setup {
  char = "▏",
  show_current_context = true,
}
require("project_nvim").setup {
  detection_methods = { "pattern", "lsp" },
  patterns = { ".git" },
}
-- require("tmux").setup {
--   copy_sync = {
--     enable = false,
--   },
--   navigation = {
--     cycle_navigation = true,
--     enable_default_keybindings = true,
--     persist_zoom = false,
--   },
-- }
require("refactoring").setup {}
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
    },
  },
  window = {
    border = "single",
  }
}
require("neoscroll").setup {
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
}
require("incline").setup {
  hide = {
    focused_win = true,
  },
}
