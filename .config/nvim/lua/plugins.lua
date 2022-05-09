local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

return require('packer').startup{function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'karb94/neoscroll.nvim'
  use "b0o/incline.nvim"
  use {
    'sbdchd/neoformat',
    cmd = { 'Neoformat' }
  }
  use 'nacro90/numb.nvim'
  use 'jghauser/mkdir.nvim'
  use {
    'mhinz/vim-grepper',
    cmd = { 'Grepper', 'GrepperRg', 'GrepperAg', 'GrepperGrep' },
    keys = '<plug>(GrepperOperator)',
  }
  use 'ahmedkhalf/project.nvim'
  use 'ThePrimeagen/refactoring.nvim'
  use 'ThePrimeagen/git-worktree.nvim'
  use 'ThePrimeagen/harpoon'
  use {
    'numToStr/Comment.nvim',
  }
  -- DEBUG
  use {
    'michaelb/sniprun',
    run = 'bash ./install.sh',
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipClose",
      "SnipReset",
      "SnipTerminate",
      "SnipReplMemoryClean",
    }
  }
  use {
    "rcarriga/vim-ultest",
    run = ":UpdateRemotePlugins",
    requires = {
      "vim-test/vim-test",
    },
  }
  use 'mfussenegger/nvim-dap'
  -- use 'Pocco81/DAPInstall.nvim'
  use 'rcarriga/nvim-dap-ui'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'tami5/lspsaga.nvim'
  -- COMPLETION
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'lukas-reineke/cmp-rg'
  use {
    'petertriho/cmp-git',
    ft = 'gitcommit',
    config = function () require'cmp_git'.setup() end
  }
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle' },
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = 'markdown'
  }
  use {
    'jghauser/follow-md-links.nvim',
    ft = 'markdown',
    disable = true
  }
  use 'lewis6991/gitsigns.nvim'
  use {
    'rhysd/git-messenger.vim',
    cmd = { 'GitMessenger' },
    keys = '<Plug>(git-messenger)',
  }
  use {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen' }
  }

  use 'kyazdani42/nvim-tree.lua'
  use 'kevinhwang91/nvim-bqf'
  -- use 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
  use 'sjl/gundo.vim'

  -- Theme
  use {
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
  }
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use {
    'tpope/vim-characterize',
    keys = { 'ga' }
  }
  use {
    'tpope/vim-abolish',
    cmd = { 'Abolish', 'Subvert', '%Subvert' }
  }

  use {
    'junegunn/gv.vim',
    cmd = { 'GV', 'GV!', 'GV?' }
  }
  use 'haya14busa/is.vim'
  use 'haya14busa/vim-asterisk'
  use {
    'folke/zen-mode.nvim',
    requires = { 'folke/twilight.nvim' },
    cmd = { 'ZenMode' }
  }
  use {
    'preservim/vim-pencil',
    cmd = { 'Pencil', 'TogglePencil', 'PencilSoft', 'PencilHard', 'HardPencil', 'SoftPencil' },
  }

  -- TMUX
  use 'aserowy/tmux.nvim'

  use {
    'AndrewRadev/splitjoin.vim',
    keys = { 'gJ', 'gS' },
  }
  use {
    'chrisbra/NrrwRgn',
    cmd = { 'NarrowRegion', 'NarrowWindow' },
  }
  use {
    'godlygeek/tabular',
    cmd = { 'Tab', 'Tabularize' }
  }
  use {
    'lambdalisue/suda.vim',
    cmd = { 'SudaWrite', 'SudaRead', 'SudaEdit' }
  }
  use 'andymass/vim-matchup'
  use {
    "vuki656/package-info.nvim",
    config = function ()
      return require('package-info').setup()
    end,
    ft = { 'json' },
    cond = function()
      if vim.fn.expand("%") == 'package.json' then
        return true
      end
    end,
    requires = {
      'MunifTanjim/nui.nvim',
      cond = function()
        if vim.fn.expand("%") == 'package.json' then
          return true
        end
      end,
    }
  }
  use 'editorconfig/editorconfig-vim'
  use 'machakann/vim-sandwich'
  use 'wellle/targets.vim'
  use 'lewis6991/impatient.nvim'
  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime'
  }
  use 'nathom/filetype.nvim'
  use {
    'sQVe/sort.nvim',
    cmd = 'Sort',
    config = function()
      require("sort").setup{}
    end,
  }
  use 'b0o/schemastore.nvim'
  use 'booperlv/nvim-gomove'
  use 'folke/which-key.nvim'
  use 'abecodes/tabout.nvim'
  use 'tpope/vim-projectionist'
  use {'nyngwang/NeoZoom.lua', branch = 'neo-zoom-original'}
  use 'inkarkat/vim-ReplaceWithRegister'
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
}
