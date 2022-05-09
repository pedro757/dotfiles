local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup
local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
local buf_opts = { buffer = 0, silent = true }
local clear = { clear = true }
local HelpMappings = aug("HelpMappings", clear)

au("Filetype", {
  pattern = "help",
  callback = function()
    vim.cmd([[ nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>]])
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    vim.cmd([[nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>]])
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    map("n", "O", [[?'\l\{2,\}'<CR>]], buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    map("n", "o", [[/'\l\{2,\}'<CR>]], buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    map("n", "<BS>", "<C-T>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    map("n", "<cr>", "<C-]>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = {
    "help",
    "startuptime",
    "checkhealth",
    "harpoon",
    [[null-ls-info]],
    "lspinfo",
  },
  callback = function()
    map("n", "gq", ":bd<cr>", buf_opts)
    map("n", "<c-x>", ":bd<cr>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = {
    "startuptime",
    "harpoon",
    [[null-ls-info]],
    "lspinfo",
  },
  callback = function()
    map("n", "<c-c>", ":bd<cr>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "harpoon",
  callback = function()
    map("n", "<c-j>", "<down>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "harpoon",
  callback = function()
    map("n", "<c-k>", "<up>", buf_opts)
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "harpoon",
  callback = require("harpoon.ui").select_menu_item,
  group = HelpMappings,
})

local HighlightYank = aug("HighlightYank", clear)

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
  end,
  group = HighlightYank,
})

local StopNewlineComments = aug("StopNewlineComments", clear)

au("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove "c"
    vim.opt.formatoptions:remove "r"
    vim.opt.formatoptions:remove "o"
  end,
  group = StopNewlineComments,
})

local TrimSpaces = aug("TrimSpaces", clear)

au("BufWritePre", {
  callback = function()
    vim.fn.TrimWhitespace()
  end,
  group = TrimSpaces,
})

local OnlyOneCursorLine = aug("OnlyOneCursorLine", clear)

au({ "WinEnter", "InsertLeave" }, {
  callback = function()
    vim.opt.cursorline = true
  end,
  group = OnlyOneCursorLine,
})

au({ "WinLeave", "InsertEnter" }, {
  callback = function()
    vim.opt.cursorline = false
  end,
  group = OnlyOneCursorLine,
})

local Targets = aug("Targets", clear)

au("User", {
  callback = function()
    vim.fn["targets#mappings#extend"] {
      b = {
        pair = { {
          o = "(",
          c = ")",
        } },
      },
    }
  end,
  group = Targets,
})

cmd("Worktree", require("telescope").extensions.git_worktree.git_worktrees, {})
cmd("WW", "SudaWrite", {})
