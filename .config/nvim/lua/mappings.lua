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
local cmp      = require'cmp'
local comple   = require'config.completion'
local dap      = require'config.dap'

-- " move to text buffer
nnoremap['<F3>'] = ':bnext<CR>'
nnoremap['<F2>'] = ':bprevious<CR>'
nnoremap['<F4>'] = ':bd<CR>'

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
imap.expr['<Tab>']       = 'pumvisible()                 ? "\\<C-n>"                      : luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "\\<TAB>"'
smap.expr['<Tab>']       = 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"'
imap['<S-Tab>']          = comple.s_tab_complete
smap['<S-Tab>']          = comple.s_tab_complete
imap['<c-e>']            = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
smap['<c-e>']            = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
inoremap['<c-h>']        = "<left>"
inoremap.c['<c-k>']      = comple.prev
inoremap.c['<c-j>']      = comple.next
inoremap.c['<c-l>']      = comple.ctrl_l
inoremap.expr['<CR>']    = comple.enter
inoremap.c.expr['<C-u>'] = comple.scroll_up
inoremap.c.expr['<C-d>'] = comple.scroll_down
inoremap.c['<C-Space>']  = cmp.complete
inoremap.c['<C-e>']      = cmp.close
inoremap.c['<C-x>']      = cmp.close

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
