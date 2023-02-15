vim.g["pencil#textwidth"] = 80
vim.g["asterisk#keeppos"] = 1
vim.g.matchup_matchparen_offscreen = {
  method = "popup",
  fullwidth = 1,
  highlight = "MatchParen",
}
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_side = "right"
vim.g.registers_window_border = "solid"
vim.g.registers_hide_only_whitespace = 1
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_use_treesitter = true
vim.g.loaded_matchit = 1
vim.g.matchup_delim_start_plaintext = 0
vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/pynvim3/bin/python"
vim.g.grepper = {
  tools = { 'rg', 'git', 'ag' },
  jump = 1,
  next_tool = '<leader>g',
  single_prompt = 1,
  quickfix = 1,
}
vim.g.himalaya_folder_picker = "telescope"
vim.g.himalaya_folder_picker_telescope_preview = 1

if vim.loop.cwd() == "/home/pedro/.config/nvim" then
  vim.env.GIT_DIR = vim.fn.expand("~") .. "/.dotfiles/"
  vim.env.GIT_WORK_TREE = vim.fn.expand("~")
end
