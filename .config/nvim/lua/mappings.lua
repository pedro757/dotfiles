local map      = require'cartographer'
local nmap     = require'cartographer'.n.silent
local smap     = require'cartographer'.s.silent
local imap     = require'cartographer'.i.silent
local omap     = require'cartographer'.o.silent
local vmap     = require'cartographer'.v.silent
local xmap     = require'cartographer'.x.silent
local nnoremap = require'cartographer'.n.nore.silent
local inoremap = require'cartographer'.i.nore.silent
local vnoremap = require'cartographer'.v.nore.silent
local xnoremap = require'cartographer'.x.nore.silent
local cnoremap = require'cartographer'.c.nore
-- " move to text buffer
nnoremap['<F3>'] = ':bnext<CR>'
nnoremap['<F2>'] = ':bprevious<CR>'
nnoremap['<F4>'] = ':bd<CR>'

-- " Better tabbing
vnoremap['<'] = '<gv'
vnoremap['>'] = '>gv'

-- " Move line
nnoremap['<A-j>']     = ":m .+1<CR>=="
nnoremap['<A-k>']     = ":m .-2<CR>=="
inoremap['<A-j>']     = "<Esc>:m .+1<CR>==gi"
inoremap['<A-k>']     = "<Esc>:m .-2<CR>==gi"
vnoremap['<A-j>']     = ":m '>+1<CR>gv=gv"
vnoremap['<A-k>']     = ":m '<-2<CR>gv=gv"
nnoremap['<A-down>']  = ":m .+1<CR>=="
nnoremap['<A-up>']    = ":m .-2<CR>=="
inoremap['<A-down>']  = "<Esc>:m .+1<CR>==gi"
inoremap['<A-up>']    = "<Esc>:m .-2<CR>==gi"
vnoremap['<A-down>']  = ":m '>+1<CR>gv=gv"
vnoremap['<A-up>']    = ":m '<-2<CR>gv=gv"

xnoremap['<leader>p'] = '"_dP'

-- " Ranger
nmap['<leader>r']  = ":NvimTreeToggle<CR>"

-- " New Line Pressing Enter
nmap['<S-Enter>']  = ":call AddEmptyLineAbove()<CR>"
nmap['<CR>']       = ":call AddEmptyLineBelow()<CR>"

cnoremap['<C-A>']       = '<Home>'
cnoremap.expr['<C-k>']  = 'pumvisible() ? "\\<C-p>" : "<Up>"'
cnoremap.expr['<C-j>']  = 'pumvisible() ? "\\<C-n>" : "<Down>"'
cnoremap['<C-l>']       = '<CR>'

vim.cmd('nnoremap <leader>c :<BS>')
-- Vim Defaults
nnoremap['Y']      = "y$"
inoremap['<C-c>']  = "<Esc>"
nnoremap['gb']     = ":ls<CR>:b<Space>"
nnoremap.expr['j'] = "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'"
nnoremap.expr['k'] = "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'"
nmap['n']          = "<Plug>(is-n)zz"
nmap['N']          = "<Plug>(is-N)zz"
nmap['H']          = '^'
nmap['L']          = 'g_'
vmap['H']          = '^'
vmap['L']          = 'g_'
omap['H']          = '^'
omap['L']          = 'g_'
inoremap[',']      = ',<c-g>u'
inoremap['.']      = '.<c-g>u'
inoremap['!']      = '!<c-g>u'
inoremap['?']      = '?<c-g>u'

-- " Telescope
nnoremap['<leader>f']  = "<cmd>Telescope find_files find_command=fd,-I,--type,f,--hidden previewer=false<cr>"
nnoremap['<leader>g']  = "<cmd>lua require'telescope.builtin'.git_files({previewer = false})<CR>"
nnoremap['<leader>s']  = "<cmd>Telescope live_grep<cr>"
nnoremap['<leader>b']  = "<cmd>Telescope buffers<cr><c-c>"

-- " Snippets And Completion
imap.expr['<Tab>']         = 'pumvisible()                 ? "\\<C-n>"                      : luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "\\<TAB>"'
smap.expr['<Tab>']         = 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"'
imap.expr['<S-Tab>']       = 'pumvisible()                 ? "\\<C-p>"                      : luasnip#expand_or_jumpable() ? "<Plug>luasnip-jump-prev"      : "\\<TAB>"'
smap.expr['<S-Tab>']       = 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-jump-prev"      : "<S-Tab>"'
imap['<c-e>']              = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
smap['<c-e>']              = "luasnip#choice_active()      ? '<Plug>luasnip-next-choice'    : '<C-E>'"
inoremap.expr['<c-j>']     = '("\\<C-n>")'
inoremap.expr['<c-k>']     = '("\\<C-p>")'
inoremap['<c-h>']          = "<left>"
inoremap.expr['<c-l>']     = "compe#confirm({ 'keys': '<right>', 'select': v:true })"
inoremap.expr['<CR>']      = "compe#confirm({ 'keys': luaeval(\"require'nvim-autopairs'.autopairs_cr()\"), 'select': v:true })"
inoremap.expr['<C-Space>'] = "compe#complete()"
inoremap.expr['<C-e>']     = "pumvisible()  ? compe#close('<C-e>') :  '<C-e>'"
inoremap.expr['<C-f>']     = "pumvisible()  ? compe#scroll({ 'delta': +4 })  :  '<C-f>'"
inoremap.expr['<C-d>']     = "pumvisible()  ? compe#scroll({ 'delta': -4 })  :  '<C-d>'"

-- " QuickFixList
nnoremap['<C-q>']      = ":call ToggleList('Location List', 'l')<CR>"
nnoremap['<leader>q']  = ":call ToggleList('Quickfix List', 'c')<CR>"

map['*']   = '<Plug>(asterisk-z*)<Plug>(is-nohl-1)'
map['#']   = '<Plug>(asterisk-z#)<Plug>(is-nohl-1)'
map['g*']  = '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)'
map['g#']  = '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)'

-- " LSP
nnoremap['gD']          = vim.lsp.buf.declaration
nnoremap['gd']          = vim.lsp.buf.definition
nnoremap['gh']          = vim.lsp.buf.hover
nnoremap['gr']  = vim.lsp.buf.references
nnoremap['<leader>i']   = vim.lsp.buf.implementation
nnoremap['<leader>D']   = vim.lsp.buf.type_definition
nnoremap['<leader>rn']  = vim.lsp.buf.rename
nnoremap['<leader>d']   = vim.lsp.diagnostic.show_line_diagnostics
nnoremap['<leader>dn']  = vim.lsp.diagnostic.goto_next
nnoremap['<leader>dN']  = vim.lsp.diagnostic.goto_prev
nnoremap['<leader>dq']  = vim.lsp.diagnostic.set_loclist
nnoremap['<leader>=']   = vim.lsp.buf.formatting
nnoremap['<leader>a']   = require('lspsaga.codeaction').code_action
vnoremap['<leader>a']   = require('lspsaga.codeaction').range_code_action
nnoremap['<leader>hn']  = require"gitsigns.actions".next_hunk
nnoremap['<leader>hN']  = require"gitsigns.actions".prev_hunk
nnoremap['<Leader>hm'] = '<Plug>(git-messenger)'

nmap['gs']  = "<plug>(GrepperOperator)"
xmap['gs']  = "<plug>(GrepperOperator)"
