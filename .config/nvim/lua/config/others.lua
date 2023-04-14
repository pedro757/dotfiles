-- require "config/statusline"
require("colorizer").setup()
require("nvim-web-devicons").setup()
require("nvim-tree").setup {
  update_cwd = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    icons = {
      git_placement = "after",
      glyphs = {
        git = {
          unstaged = " ",
          staged = "烙",
          unmerged = " ",
          renamed = "諭",
          untracked = " ",
          deleted = " ",
        }
      }
    }
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  view = {
    relativenumber = true,
    mappings = {
      list = {
        { key = { "l" }, action = "edit" },
        { key = { "h" }, action = "close_node" },
        { key = { "gq" }, action = "close" },
      },
    },
  },
}
require("indent_blankline").setup {
  char = "▏",
  show_current_context = true,
}
require("project_nvim").setup {}
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
