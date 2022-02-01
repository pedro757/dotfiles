local map      = require'cartographer'
local nmap     = require'cartographer'.n.silent
local smap     = require'cartographer'.s.silent
local imap     = require'cartographer'.i.silent
local xmap     = require'cartographer'.x.silent
local nnoremap = require'cartographer'.n.nore.silent
local inoremap = require'cartographer'.i.nore.silent
local vnoremap = require'cartographer'.v.nore.silent
local xnoremap = require'cartographer'.x.nore.silent
local cnoremap = require'cartographer'.c.nore
local dap      = require'config.dap'
local m = vim.keymap.set

-- " Better tabbing
vnoremap['<'] = '<gv'
vnoremap['>'] = '>gv'

xnoremap['p'] = '"_dP'

-- " Ranger
nmap['<leader>e']  = ":NvimTreeToggle<CR>"

-- " New Line Pressing Enter
nmap['<S-Enter>']  = ":call AddEmptyLineAbove()<CR>"
nmap['<CR>']       = ":call AddEmptyLineBelow()<CR>"

cnoremap['<C-A>']       = '<Home>'
map.n.nore['<leader>c'] = ':<BS>'
-- Vim Defaults
inoremap['<C-c>']  = "<Esc>"
nnoremap.expr['j'] = "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'"
nnoremap.expr['k'] = "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'"
nmap['n']          = "<Plug>(is-n)zz"
nmap['N']          = "<Plug>(is-N)zz"
map['H']           = '^'
map['L']           = 'g_'
inoremap[',']      = ',<c-g>u'
inoremap['.']      = '.<c-g>u'
inoremap['!']      = '!<c-g>u'
inoremap['?']      = '?<c-g>u'

-- " Telescope
nnoremap['<leader>f']  = require"telescope.builtin".find_files
vnoremap['<leader>r']  = require('telescope').extensions.refactoring.refactors

-- " Snippets And Completion
imap.expr['<c-e>']            = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
smap.expr['<c-e>']            = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
m({"i", "c"}, "<c-h>", "<left>")
m("i", "<c-l>", "<right>")
m({"i", "c"}, "<c-j>", "<down>")
m({"i", "c"}, "<c-k>", "<up>")
m("c", "<c-l>", "<CR>")

-- " QuickFixList
nnoremap['<C-q>']      = ":call ToggleList('Location List', 'l')<CR>"
nnoremap['<leader>q']  = ":call ToggleList('Quickfix List', 'c')<CR>"

map['*']   = '<Plug>(asterisk-z*)<Plug>(is-nohl-1)'
map['#']   = '<Plug>(asterisk-z#)<Plug>(is-nohl-1)'
map['g*']  = '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)'
map['g#']  = '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)'

-- " LSP
m('n', "gD", vim.lsp.buf.declaration,
  { desc = "Declaration", silent = true  })
m('n', "gh", vim.lsp.buf.hover,
  { desc = "Hover", silent = true  })
m('n', "gr", vim.lsp.buf.references,
  { desc = "References", silent = true  })
m('n', "gD", vim.lsp.buf.declaration,
  { desc = "Declaration", silent = true  })
m('n', "<leader>i", vim.lsp.buf.implementation,
  { desc = "Implementation", silent = true  })
m('n', "<leader>D", vim.lsp.buf.type_definition,
  { desc = "Type Definition", silent = true  })
m('n', "<leader>r", vim.lsp.buf.rename,
  { desc = "Rename", silent = true  })
m('n', "<leader>d", vim.diagnostic.open_float,
  { desc = "Diagnostic", silent = true  })
m('n', "<leader>dn", vim.diagnostic.goto_next,
  { desc = "Next Diagnostic", silent = true  })
m('n', "<leader>dN", vim.diagnostic.goto_prev,
  { desc = "Previous Diagnostic", silent = true  })
m('n', "<leader>dq", vim.diagnostic.setloclist,
  { desc = "Send to LocList", silent = true })
m('n', "<leader>=", vim.lsp.buf.formatting,
  { desc = "Format file", silent = true  })
m('n', "<leader>a", ":Lspsaga code_action<cr>",
  { desc = "Action", silent = true  })
m('v', "<leader>a", ":<c-u>Lspsaga range_code_action<cr>",
  { desc = "Action", silent = true  })

m('n', "<leader>hn", require'gitsigns.actions'.next_hunk,
  { desc = "Next Hunk", silent = true  })
m('n', "<leader>hN", require'gitsigns.actions'.prev_hunk,
  { desc = "Previous Hunk", silent = true  })
m({'n', 'v'}, "<leader>hs", ":Gitsigns stage_hunk<CR>",
  { desc = "Stage Hunk", silent = true })
m({'n', 'v'}, "<leader>hr", ":Gitsigns reset_hunk<CR>",
  { desc = "Stage Hunk", silent = true })
m({'n', 'v'}, "<leader>hu", ":Gitsigns undo_stage_hunk<CR>",
  { desc = "Stage Hunk", silent = true })
m('n', "<leader>hp", ":Gitsigns preview_hunk<CR>",
  { desc = "Stage Hunk", silent = true })
m('n', "<leader>hb", function() require"gitsigns".blame_line{full=true} end,
  { desc = "Stage Hunk", silent = true })
m('n', "<Leader>hm", '<Plug>(git-messenger)',
  { desc = "Commit Message", silent = true  })

nmap['gs']  = "<plug>(GrepperOperator)"
xmap['gs']  = "<plug>(GrepperOperator)"

nnoremap['<leader>dd']  = require'dapui'.toggle
nnoremap['<leader>db']  = require'dap'.toggle_breakpoint
nnoremap['<leader>da']  = dap.attach
nnoremap['<leader>dc']  = require"dap".continue
nnoremap['<leader>ds']  = require"dap".step_over
nnoremap['<leader>di']  = require"dap".step_into
nnoremap['<leader>do']  = require"dap".step_out

nnoremap['<leader>g']   = require"harpoon.ui".toggle_quick_menu
nnoremap['<leader>ga']  = require"harpoon.mark".add_file

nnoremap['<leader>t']   = ":UltestNearest<CR>"
nnoremap['<leader>tt']  = ":Ultest<CR>"
nnoremap['<leader>to']  = ":UltestOutput<CR>"
