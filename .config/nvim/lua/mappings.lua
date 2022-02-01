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
nnoremap['gD']         = vim.lsp.buf.declaration
nnoremap['gd']         = vim.lsp.buf.definition
nnoremap['gh']         = vim.lsp.buf.hover
nnoremap['gr']         = vim.lsp.buf.references
nnoremap['<leader>i']  = vim.lsp.buf.implementation
nnoremap['<leader>D']  = vim.lsp.buf.type_definition
nnoremap['<leader>r']  = vim.lsp.buf.rename
nnoremap['<leader>d']  = vim.diagnostic.open_float
nnoremap['<leader>dn'] = vim.diagnostic.goto_next
nnoremap['<leader>dN'] = vim.diagnostic.goto_prev
nnoremap['<leader>dq'] = vim.diagnostic.setloclist
nnoremap['<leader>=']  = vim.lsp.buf.formatting
nnoremap['<leader>a']  = require'lspsaga.codeaction'.code_action
vnoremap['<leader>a']  = require'lspsaga.codeaction'.range_code_action
nnoremap['<leader>hn'] = require'gitsigns.actions'.next_hunk
nnoremap['<leader>hN'] = require'gitsigns.actions'.prev_hunk
nnoremap['<Leader>hm'] = '<Plug>(git-messenger)'

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
