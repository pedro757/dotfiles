local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = actions.select_default + actions.center,
        ["<esc>"] = actions.close,
        ["<C-x>"] = actions.close,
        ["<C-c>"] = false,
        ["<C-l>"] = actions.select_default + actions.center,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<C-x>"] = actions.close,
        ["<C-l>"] = actions.select_default + actions.center,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      }
    },
    file_ignore_patterns = { "plugged", "cache", "venv", "node_modules", ".git", "packer_compiled.lua" },
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
  -- extensions = {
  --   fzy_native = {
  --     override_generic_sorter = false,
  --     override_file_sorter = true,
  --   }
  -- }
}
require("telescope").load_extension("git_worktree")
-- require('telescope').load_extension('fzy_native')
