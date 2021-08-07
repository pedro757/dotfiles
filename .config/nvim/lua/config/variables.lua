vim.g['pencil#textwidth'] = 120
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g['airline#extensions#tabline#show_tabs'] = 0
vim.g['airline#extensions#scrollbar#enabled'] = 0
vim.g['asterisk#keeppos'] = 1
vim.g.rnvimr_ex_enable = 1
vim.g.matchup_matchparen_offscreen = { method = 'popup', fullwidth = 1 }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_side = 'right'
vim.g.nvim_tree_bindings = {
  { key = {"l"}, cb = require'nvim-tree.config'.nvim_tree_callback("edit") },
  { key = { 'h' }, cb = require'nvim-tree.config'.nvim_tree_callback('close_node')}
}
vim.g.registers_window_border = "solid"
vim.g.registers_hide_only_whitespace = 1
-- vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'
-- vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb al rB Al bb aa bB Aa BB AA'
-- vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'