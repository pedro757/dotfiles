local dap = require "config.dap"
local m = vim.keymap.set

-- " Better tabbing
m("v", "<", "<gv")
m("v", ">", ">gv")

m("n", "<leader>e", ":NvimTreeToggle<CR>")

-- " New Line Pressing Enter
m("n", "<S-Enter>", ":call AddEmptyLineAbove()<CR>", { silent = true })
m("n", "<CR>", ":call AddEmptyLineBelow()<CR>", { silent = true })

m("c", "<c-a>", "<Home>")
m("n", "<leader>c", ":<BS>")
-- Vim Defaults
m("i", "<c-c>", "<Esc>")
m("n", "<leader>o", ":NeoZoomToggle<CR>zz", { silent = true })
m("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true })
m("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true })
m("n", "n", "<Plug>(is-n)zz", { remap = true })
m("n", "N", "<Plug>(is-N)zz", { remap = true })
m("", "H", "^", { remap = true })
m("", "L", "g_", { remap = true })
m("i", ",", ",<c-g>u")
m("i", ".", ".<c-g>u")
m("i", "!", "!<c-g>u")
m("i", "?", "?<c-g>u")

-- " Telescope
m("n", "<leader>f", require("telescope.builtin").find_files)
m("n", "<leader><leader>", ":Telescope<CR>")
m("v", "<leader>r", require("telescope").extensions.refactoring.refactors)

-- " Snippets And Completion
m(
  "i",
  "<c-e>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
  { expr = true, remap = true }
)
m(
  "s",
  "<c-e>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
  { expr = true, remap = true }
)
m({ "i", "c" }, "<c-h>", "<left>")
m("i", "<c-l>", "<right>")
m({ "i", "c" }, "<c-j>", "<down>")
m({ "i", "c" }, "<c-k>", "<up>")
m("c", "<c-l>", "<CR>")

-- " QuickFixList
m("n", "<C-q>", ":call ToggleList('Location List', 'l')<CR>", { silent = true })
m(
  "n",
  "<leader>q",
  ":call ToggleList('Quickfix List', 'c')<CR>",
  { silent = true }
)

m("", "*", "<Plug>(asterisk-z*)<Plug>(is-nohl-1)", { remap = true })
m("", "#", "<Plug>(asterisk-z#)<Plug>(is-nohl-1)", { remap = true })
m("", "g*", "<Plug>(asterisk-gz*)<Plug>(is-nohl-1)", { remap = true })
m("", "g#", "<Plug>(asterisk-gz#)<Plug>(is-nohl-1)", { remap = true })

-- " LSP
m("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration", silent = true })
m("n", "gh", vim.lsp.buf.hover, { desc = "Hover", silent = true })
m("n", "gr", vim.lsp.buf.references, { desc = "References", silent = true })
m("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration", silent = true })
m(
  "n",
  "<leader>i",
  vim.lsp.buf.implementation,
  { desc = "Implementation", silent = true }
)
m(
  "n",
  "<leader>D",
  vim.lsp.buf.type_definition,
  { desc = "Type Definition", silent = true }
)
m("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename", silent = true })
m(
  "n",
  "<leader>d",
  vim.diagnostic.open_float,
  { desc = "Diagnostic", silent = true }
)
m(
  "n",
  "<leader>dn",
  vim.diagnostic.goto_next,
  { desc = "Next Diagnostic", silent = true }
)
m(
  "n",
  "<leader>dN",
  vim.diagnostic.goto_prev,
  { desc = "Previous Diagnostic", silent = true }
)
m(
  "n",
  "<leader>dq",
  vim.diagnostic.setloclist,
  { desc = "Send to LocList", silent = true }
)
m("n", "<leader>=", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format file", silent = true })
m(
  "n",
  "<leader>a",
  ":Lspsaga code_action<cr>",
  { desc = "Action", silent = true }
)
m(
  "v",
  "<leader>a",
  ":<c-u>Lspsaga range_code_action<cr>",
  { desc = "Action", silent = true }
)

m(
  "n",
  "<leader>hn",
  require("gitsigns.actions").next_hunk,
  { desc = "Next Hunk", silent = true }
)
m(
  "n",
  "<leader>hN",
  require("gitsigns.actions").prev_hunk,
  { desc = "Previous Hunk", silent = true }
)
m(
  { "n", "v" },
  "<leader>hs",
  ":Gitsigns stage_hunk<CR>",
  { desc = "Stage Hunk", silent = true }
)
m(
  { "n", "v" },
  "<leader>hr",
  ":Gitsigns reset_hunk<CR>",
  { desc = "Stage Hunk", silent = true }
)
m(
  { "n", "v" },
  "<leader>hu",
  ":Gitsigns undo_stage_hunk<CR>",
  { desc = "Stage Hunk", silent = true }
)
m(
  "n",
  "<leader>hp",
  ":Gitsigns preview_hunk<CR>",
  { desc = "Stage Hunk", silent = true }
)
m("n", "<leader>hb", function()
  require("gitsigns").blame_line { full = true }
end, { desc = "Stage Hunk", silent = true })
m(
  "n",
  "<Leader>hm",
  "<Plug>(git-messenger)",
  { desc = "Commit Message", silent = true }
)

m("n", "gs", "<plug>(GrepperOperator)", { remap = true })
m("x", "gs", "<plug>(GrepperOperator)", { remap = true })

m("n", "<leader>dd", require("dapui").toggle)
m("n", "<leader>db", require("dap").toggle_breakpoint)
m("n", "<leader>da", dap.attach)
m("n", "<leader>dc", require("dap").continue)
m("n", "<leader>ds", require("dap").step_over)
m("n", "<leader>di", require("dap").step_into)
m("n", "<leader>do", require("dap").step_out)

m("n", "<leader>g", require("harpoon.ui").toggle_quick_menu)
m("n", "<leader>ga", require("harpoon.mark").add_file)

m(
  "n",
  "<leader>t",
  ":UltestNearest<CR>",
  { desc = "Test Nearest", silent = true }
)
m("n", "<leader>tt", ":Ultest<CR>", { desc = "Test File", silent = true })
m(
  "n",
  "<leader>to",
  "<Plug>(ultest-output-jump)",
  { desc = "Test Output", silent = true }
)

m("n", "<leader>p", "<Plug>ReplaceWithRegisterOperator")
