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
    vim.cmd [[ nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>]]
  end,
  group = HelpMappings,
})

au("Filetype", {
  pattern = "help",
  callback = function()
    vim.cmd [[nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>]]
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
    "UltestSummary",
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
  callback = function()
    map({ "i", "n" }, "<c-l>", require("harpoon.ui").select_menu_item, buf_opts)
  end,
  group = HelpMappings,
})

local HighlightYank = aug("HighlightYank", clear)

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
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
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[:keepjumps keeppatterns %s/\s\+$//e]]
    vim.cmd [[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d]]
    local end_row = vim.api.nvim_buf_line_count(0)
    if curpos[1] > end_row then
      curpos[1] = end_row
    end
    vim.api.nvim_win_set_cursor(0, curpos)
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

local NvimConfig = aug("NvimConfig", clear)

au("BufWritePost", {
  pattern = "plugins.lua",
  callback = function()
    if vim.loop.cwd() == "/home/pedro/.config/nvim" then
      vim.cmd [[source <afile> | PackerCompile]]
    end
  end,
  group = NvimConfig,
})

local NvimRootGit = aug("NvimRootGit", clear)
au("VimEnter", {
  once = true,
  callback = function()
    if string.find(vim.loop.cwd(), "/home/pedro/.config/nvim") then
      vim.fn.FugitiveDetect(vim.fn.expand "~/.dotfiles")
    end
  end,
  group = NvimRootGit,
})
au("Filetype", {
  pattern = { "lua", "vim", "toml" },
  once = true,
  callback = function()
    if string.find(vim.loop.cwd(), "/home/pedro/.config/nvim") then
      if vim.opt.filetype:get() ~= "TelescopePrompt" then
        vim.fn.FugitiveDetect(vim.fn.expand "~/.dotfiles")
      end
    end
  end,
  group = NvimRootGit,
})

local Mkdir = aug("Mkdir", clear)

au("BufWritePre", {
  callback = function ()
    local dir = vim.fn.expand "<afile>:p:h"

    print(dir)
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  group = Mkdir,
})

cmd("Worktree", require("telescope").extensions.git_worktree.git_worktrees, {})
cmd("WW", "SudaWrite", {})
cmd("DiffSaved", function ()
  vim.fn.DiffWithSaved()
end, {})
cmd("Dotfiles", "call FugitiveDetect(expand('~/.dotfiles'))", {})
