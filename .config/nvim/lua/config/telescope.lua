local actions = require('telescope.actions')
local action_layout = require("telescope.actions.layout")
require('telescope').setup{
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
        ["<C-g>"] = "which_key",
        ["<C-p>"] = action_layout.toggle_preview,
        ["<C-h>"] = actions.file_split,
      }
    },
    file_ignore_patterns = { "plugged", "cache", "venv", ".venv",
      "node_modules", ".git/", "packer_compiled.lua" },
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      hidden = true,
    },
  },
}
require('telescope').load_extension('projects')
require("telescope").load_extension("git_worktree")

local refactoring = require("refactoring")
refactoring.setup({})
require("telescope").load_extension("refactoring")
