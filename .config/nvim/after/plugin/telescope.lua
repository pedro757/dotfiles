if not pcall(require, "telescope") then
  return
end
local m = vim.keymap.set
local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

require("telescope").setup {
  defaults = {
    preview = {
      hide_on_startup = true,
    },
    mappings = {
      i = {
        ["<CR>"] = actions.select_default + actions.center,
        ["<esc>"] = actions.close,
        ["<C-x>"] = actions.close,
        ["<C-c>"] = false,
        ["<C-l>"] = actions.select_default + actions.center,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-g>"] = "which_key",
        ["<C-p>"] = action_layout.toggle_preview,
        ["<C-h>"] = actions.file_split,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<C-x>"] = actions.close,
        ["<C-l>"] = actions.select_default + actions.center,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-g>"] = "which_key",
        ["<C-p>"] = action_layout.toggle_preview,
        ["<C-h>"] = actions.file_split,
      },
    },
    file_ignore_patterns = {
      "plugged",
      "cache",
      "venv",
      ".venv",
      "node_modules",
      "mysql_data/",
      ".turbo/",
      ".git/",
      "packer_compiled.lua",
      ".next/",
      "target/",
      "pnpm-lock.yaml",
    },
    set_env = { ["COLORTERM"] = "truecolor" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
    ast_grep = {
      command = {
        "sg",
        "--json=stream",
      },
      grep_open_files = false,
      lang = nil,
    }
  },
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "f",
        "--strip-cwd-prefix",
        "--no-ignore-vcs",
      },
      hidden = true,
    },
  },
}
require("telescope").load_extension("ui-select")

-- require('telescope').load_extension('projects')
require"git-worktree".setup {
  update_on_change_command = "Telescope find_files"
}
require("telescope").load_extension("git_worktree")

local refactoring = require "refactoring"
refactoring.setup {}
-- require("telescope").load_extension("refactoring")

-- " Telescope
m(
  "n",
  "<leader>f",
  require("telescope.builtin").find_files,
  { desc = "Find File" }
)
m(
  "n",
  "<leader><leader>",
  vim.cmd.Telescope,
  { desc = "Telescope", silent = true }
)
m("v", "<leader>r", require("telescope").extensions.refactoring.refactors)
