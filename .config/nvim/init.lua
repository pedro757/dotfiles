vim.g.mapleader = " "
vim.cmd.colorscheme "farout"
vim.cmd "source $HOME/.config/nvim/vim/abbrev.vim"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "folke/neodev.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "kyazdani42/nvim-web-devicons",
  "norcalli/nvim-colorizer.lua",
  "karb94/neoscroll.nvim",
  "b0o/incline.nvim",
  "ahmedkhalf/project.nvim",
  "ThePrimeagen/refactoring.nvim",
  "ThePrimeagen/git-worktree.nvim",
  "ThePrimeagen/harpoon",
  "wellle/targets.vim",
  "folke/which-key.nvim",
  "b0o/schemastore.nvim",
  "nvim-lualine/lualine.nvim",
  "kyazdani42/nvim-tree.lua",
  "lukas-reineke/indent-blankline.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-sleuth",
  "andymass/vim-matchup",
  "mfussenegger/nvim-dap",
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "mhinz/vim-grepper",
    cmd = { "Grepper", "GrepperRg", "GrepperAg", "GrepperGrep" },
    keys = "<plug>(GrepperOperator)",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("typescript-tools").setup {}
        end,
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = { "gcc", "gc", "gb", "gbc" },
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      end
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup {}
    end,
  },
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Delete",
      "Move",
      "Chmod",
      "Rename",
      "Copy",
      "Duplicate",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Llocate",
      "Wall",
      "SudoWrite",
      "SudoEdit",
    },
  },
  {
    "tpope/vim-obsession",
    cmd = { "Obsession", "Obsess" },
  },
  {
    "tpope/vim-characterize",
    keys = { "ga" },
  },
  {
    "tpope/vim-abolish",
    cmd = { "Abolish", "Subvert" },
  },
  {
    "junegunn/gv.vim",
    cmd = { "GV" },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
      },
    },
    cmd = { "ZenMode" },
  },
  {
    "preservim/vim-pencil",
    cmd = {
      "Pencil",
      "TogglePencil",
      "PencilSoft",
      "PencilHard",
      "HardPencil",
      "SoftPencil",
    },
  },
  {
    "Wansmer/treesj",
    keys = { "gJ", "gS" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesj").setup {}
      vim.keymap.set("n", "gJ", require("treesj").join, { desc = "Join lines" })
      vim.keymap.set(
        "n",
        "gS",
        require("treesj").split,
        { desc = "Split lines" }
      )
    end,
  },
  {
    "chrisbra/NrrwRgn",
    cmd = { "NarrowRegion", "NarrowWindow" },
  },
  {
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },
  {
    "vuki656/package-info.nvim",
    config = function()
      require("package-info").setup()
    end,
    ft = { "json" },
    cond = function()
      if vim.fn.expand "%" == "package.json" then
        return true
      end
    end,
  },
  {
    "saecki/crates.nvim",
    ft = "toml",
    cond = function()
      if vim.fn.expand "%" == "Cargo.toml" then
        return true
      end
    end,
    config = function()
      require("crates").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "sQVe/sort.nvim",
    cmd = "Sort",
    config = function()
      require("sort").setup {}
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = 'require("numb").setup()',
  },
  {
    "booperlv/nvim-gomove",
    config = 'require("gomove").setup {}',
    lazy = true,
    keys = { "<A-k>", "<A-j>", "<A-h>", "<A-l>" },
  },
  {
    "nyngwang/NeoZoom.lua",
    branch = "neo-zoom-original",
    cmd = { "NeoZoomToggle" },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        shell = "/usr/bin/fish",
        autochdir = true,
      }
    end,
  },
  "hrsh7th/cmp-cmdline",
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "windwp/nvim-autopairs",
      "jcha0713/cmp-tw2css",
      "dcampos/cmp-emmet-vim",
      "mattn/emmet-vim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      {
        "hrsh7th/cmp-nvim-lua",
        ft = "lua",
      },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "lukas-reineke/cmp-rg",
      {
        "petertriho/cmp-git",
        ft = "gitcommit",
        config = function()
          require("cmp_git").setup()
        end,
      },
    },
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipClose",
      "SnipReset",
      "SnipTerminate",
      "SnipReplMemoryClean",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        filetypes = {
          markdown = true,
          sh = function()
            if
              string.match(
                vim.fs.basename(vim.api.nvim_buf_get_name(0)),
                "^%.env.*"
              )
            then
              return false
            end
            return true
          end,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = "<C-n>",
            accept_line = "<C-e>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "jghauser/follow-md-links.nvim",
    ft = "markdown",
    enabled = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
  },
  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = "<Plug>(git-messenger)",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "nyngwang/NeoZoom.lua",
    branch = "neo-zoom-original",
    cmd = { "NeoZoomToggle" },
  },
  {
    "gbprod/stay-in-place.nvim",
    config = function()
      require("stay-in-place").setup {}
    end,
  },
  {
    "mrshmllow/document-color.nvim",
    config = function()
      require("document-color").setup {
        mode = "foreground",
      }
    end,
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    enabled = false,
    config = function()
      require("ts-node-action").setup {}
    end,
  },
}

require "options"
require("lazy").setup(plugins)
require "config.variables"
require "mappings"
require "config.others"
vim.cmd "source $HOME/.config/nvim/vim/functions.vim"
require "commands"
