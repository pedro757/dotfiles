local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath "data"
      .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use {
      "neovim/nvim-lspconfig",
      after = "LuaSnip",
      requires = {
        {
          "jose-elias-alvarez/null-ls.nvim",
        },
        {
          "jose-elias-alvarez/typescript.nvim",
        }
      },
      config = function()
        require "plugins.lsp"
      end,
    }
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "norcalli/nvim-colorizer.lua"
    use "karb94/neoscroll.nvim"
    use "b0o/incline.nvim"
    use {
      "nacro90/numb.nvim",
      event = "CmdlineEnter",
      config = 'require("numb").setup()',
    }
    use {
      "mhinz/vim-grepper",
      cmd = { "Grepper", "GrepperRg", "GrepperAg", "GrepperGrep" },
      keys = "<plug>(GrepperOperator)",
    }
    use "ahmedkhalf/project.nvim"
    use "ThePrimeagen/refactoring.nvim"
    use "ThePrimeagen/git-worktree.nvim"
    use "ThePrimeagen/harpoon"
    use {
      "numToStr/Comment.nvim",
      keys = { "gcc", "gc", "gb", "gbc" },
      config = function()
        require "plugins.comment"
      end,
    }
    -- DEBUG
    use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = {
        "SnipRun",
        "SnipInfo",
        "SnipClose",
        "SnipReset",
        "SnipTerminate",
        "SnipReplMemoryClean",
      },
    }
    -- use {
    --   "nvim-neotest/neotest",
    --   requires = {
    --     "nvim-neotest/neotest-python",
    --     "haydenmeade/neotest-jest",
    --     "nvim-neotest/neotest-plenary",
    --     {
    --       "vim-test/vim-test",
    --       opt = true,
    --     },
    --     "nvim-neotest/neotest-vim-test",
    --   },
    --   config = function()
    --     require('neotest').setup({
    --       icons = {
    --         failed = " ",
    --         passed = " ",
    --         running = " ",
    --         skipped = " ",
    --         unknown = " "
    --       },
    --       adapters = {
    --         require("neotest-python")({
    --           dap = { justMyCode = false },
    --         }),
    --         require("neotest-plenary"),
    --         require('neotest-jest')({
    --           jestCommand = "npm test --"
    --         }),
    --         require("neotest-vim-test")({
    --           ignore_file_types = {
    --             "python",
    --             "vim",
    --             "lua",
    --             "javascript",
    --             "typescript",
    --             "typescriptreact",
    --             "javascriptreact",
    --           },
    --         }),
    --       }
    --     })
    --   end
    -- }
    use {
      "mfussenegger/nvim-dap"
    }
    -- use "rcarriga/nvim-dap-ui"
    use "lukas-reineke/indent-blankline.nvim"
    use "tami5/lspsaga.nvim"

    -- COMPLETION
    use {
      "L3MON4D3/LuaSnip",
      event = { "InsertEnter", "CmdlineEnter" },
      config = function()
        require "plugins.snippets"
      end,
    }
    use {
      "onsails/lspkind-nvim",
      event = { "InsertEnter", "CmdlineEnter" },
    }
    use {
      "hrsh7th/nvim-cmp",
      after = { "LuaSnip", "lspkind-nvim" },
      config = function()
        require "plugins.cmp"
      end,
    }
    use {
      "jcha0713/cmp-tw2css",
      after = "nvim-cmp",
    }
    use {
      "dcampos/cmp-emmet-vim",
      after = "nvim-cmp",
    }
    use {
      "mattn/emmet-vim",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-cmdline",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-nvim-lua",
      -- ft = "lua",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-nvim-lsp",
    }
    use {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      after = "nvim-cmp",
    }
    use {
      "lukas-reineke/cmp-rg",
      after = "nvim-cmp",
    }
    use {
      "petertriho/cmp-git",
      ft = "gitcommit",
      after = "nvim-cmp",
      config = function()
        require("cmp_git").setup()
      end,
    }
    use {
      "saadparwaiz1/cmp_luasnip",
      after = "nvim-cmp",
    }
    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use {
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle" },
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
    }
    use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require "plugins.autopairs"
      end,
    }
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    }
    use {
      "jghauser/follow-md-links.nvim",
      ft = "markdown",
      disable = true,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require "plugins.gitsigns"
      end,
    }
    use {
      "rhysd/git-messenger.vim",
      cmd = { "GitMessenger" },
      keys = "<Plug>(git-messenger)",
    }
    use {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen" },
    }

    use "kyazdani42/nvim-tree.lua"
    use {
      "kevinhwang91/nvim-bqf",
      ft = "qf",
    }

    -- Theme
    use {
      "NTBBloodbath/galaxyline.nvim",
      branch = "main",
    }
    use {
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
    }
    use "tpope/vim-fugitive"
    use {
      "tpope/vim-obsession",
      cmd = { "Obsession", "Obsess" },
    }
    use "tpope/vim-repeat"
    use "tpope/vim-sleuth"
    use {
      "tpope/vim-characterize",
      keys = { "ga" },
    }
    use {
      "tpope/vim-abolish",
      cmd = { "Abolish", "Subvert", "%Subvert" },
    }

    use {
      "junegunn/gv.vim",
      cmd = { "GV", "GV!", "GV?" },
    }
    -- use {
    --   "haya14busa/vim-asterisk",
    --   requires = {
    --     {
    --       "haya14busa/is.vim",
    --       -- keys = { "/", "n", "N", "*", "#" },
    --       opt = false,
    --     },
    --   },
    --   keys = {
    --     "<Plug>(asterisk-z*)<Plug>(is-nohl-1)",
    --     "<Plug>(asterisk-gz*)<Plug>(is-nohl-1)",
    --     "<Plug>(asterisk-z#)<Plug>(is-nohl-1)",
    --     "<Plug>(asterisk-gz#)<Plug>(is-nohl-1)",
    --   },
    -- }
    use {
      "folke/zen-mode.nvim",
      requires = {
        {
          "folke/twilight.nvim",
          opt = true,
        },
      },
      cmd = { "ZenMode" },
    }
    use {
      "preservim/vim-pencil",
      cmd = {
        "Pencil",
        "TogglePencil",
        "PencilSoft",
        "PencilHard",
        "HardPencil",
        "SoftPencil",
      },
    }

    -- -- TMUX
    -- use "aserowy/tmux.nvim"

    use {
      "AndrewRadev/splitjoin.vim",
      keys = { "gJ", "gS" },
    }
    use {
      "chrisbra/NrrwRgn",
      cmd = { "NarrowRegion", "NarrowWindow" },
    }
    use {
      "godlygeek/tabular",
      cmd = { "Tabularize" },
    }
    use "andymass/vim-matchup"
    use {
      "vuki656/package-info.nvim",
      config = function()
        require("package-info").setup()
      end,
      -- after = "nui.nvim",
      ft = { "json" },
      cond = function()
        if vim.fn.expand "%" == "package.json" then
          return true
        end
      end,
    }
    use {
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end,
    }
    use "wellle/targets.vim"
    use "lewis6991/impatient.nvim"
    use {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
    }
    use {
      "sQVe/sort.nvim",
      cmd = "Sort",
      config = function()
        require("sort").setup {}
      end,
    }
    use "b0o/schemastore.nvim"
    use {
      "booperlv/nvim-gomove",
      config = 'require("gomove").setup {}',
      opt = true,
      keys = { "<A-k>", "<A-j>", "<A-h>", "<A-l>" },
    }
    use "folke/which-key.nvim"
    use {
      "nyngwang/NeoZoom.lua",
      branch = "neo-zoom-original",
      cmd = { "NeoZoomToggle" },
    }
    use {
      "inkarkat/vim-ReplaceWithRegister",
      keys = { "<Plug>ReplaceWithRegisterOperator" },
    }
    use {
      "gbprod/stay-in-place.nvim",
      config = function()
        require("stay-in-place").setup {}
      end,
    }
    use {
      "mrshmllow/document-color.nvim",
      config = function()
        require("document-color").setup {
          mode = "foreground",
        }
      end,
    }
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  },
}
