vim.g["pencil#textwidth"] = 120
vim.g["asterisk#keeppos"] = 1
vim.g.rnvimr_ex_enable = 1
vim.g.matchup_matchparen_offscreen = {
  method = "popup",
  fullwidth = 1,
  highlight = "MatchParen",
}
-- vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_side = "right"
vim.g.registers_window_border = "solid"
vim.g.registers_hide_only_whitespace = 1
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_use_treesitter = true
vim.g.loaded_matchit = 1
vim.g.matchup_delim_start_plaintext = 0
vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/pynvim3/bin/python"
vim.g.ultest_output_on_line = 0
vim.g.ultest_pass_sign = " "
vim.g.ultest_fail_sign = " "
vim.g.ultest_running_sign =" "
vim.g.ultest_not_run_sign =" "
local recipes = vim.g["sandwich#default_recipes"]
local spaces_recipes = {
  {
    buns = { "{ ", " }" },
    nesting = 1,
    match_syntax = 1,
    kind = { "add", "replace" },
    action = { "add" },
    input = { "{" },
  },
  {
    buns = { "[ ", " ]" },
    nesting = 1,
    match_syntax = 1,
    kind = { "add", "replace" },
    action = { "add" },
    input = { "[" },
  },
  {
    buns = { "( ", " )" },
    nesting = 1,
    match_syntax = 1,
    kind = { "add", "replace" },
    action = { "add" },
    input = { "(" },
  },
  {
    buns = { "{\\s*", "\\s*}" },
    nesting = 1,
    regex = 1,
    match_syntax = 1,
    kind = { "delete", "replace", "textobj" },
    action = { "delete" },
    input = { "{" },
  },
  {
    buns = { "[\\s*", "\\s*]" },
    nesting = 1,
    regex = 1,
    match_syntax = 1,
    kind = { "delete", "replace", "textobj" },
    action = { "delete" },
    input = { "[" },
  },
  {
    buns = { "(\\s*", "\\s*)" },
    nesting = 1,
    regex = 1,
    match_syntax = 1,
    kind = { "delete", "replace", "textobj" },
    action = { "delete" },
    input = { "(" },
  },
}

for _, v in ipairs(spaces_recipes) do
  table.insert(recipes, v)
end

vim.g["sandwich#recipes"] = recipes
