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
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  -- use 'karb94/neoscroll.nvim'
  use {
    'sbdchd/neoformat',
    cmd = { 'Neoformat' }
  }
  use 'nacro90/numb.nvim'
  use 'jghauser/mkdir.nvim'
  use 'mhinz/vim-grepper'
  use 'ahmedkhalf/project.nvim'
  use 'ThePrimeagen/refactoring.nvim'
  use 'ThePrimeagen/git-worktree.nvim'
  use 'b3nj5m1n/kommentary'
  -- DEBUG
  use { 'michaelb/sniprun', run = 'install.sh'}
  use 'Iron-E/nvim-cartographer'
  use {
    "rcarriga/vim-ultest",
    requires = {"vim-test/vim-test"},
    run = ":UpdateRemotePlugins",
    cond = function()
      return vim.fn.has "python3" == 1
    end,
  }
  use 'mfussenegger/nvim-dap'
  use 'Pocco81/DAPInstall.nvim'
  use 'rcarriga/nvim-dap-ui'

  -- use 'glepnir/indent-guides.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'glepnir/lspsaga.nvim'

  -- COMPLETION
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'lukas-reineke/cmp-rg'
  -- use 'hrsh7th/cmp-emoji'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
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
  use 'sjl/gundo.vim'

  -- Theme
  use 'morhetz/gruvbox'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require'config/statusline' end,
  }
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
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
  use 'preservim/vim-pencil'

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
    requires = "MunifTanjim/nui.nvim",
  }
  use 'editorconfig/editorconfig-vim'
  use 'machakann/vim-sandwich'
  use 'wellle/targets.vim'
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
}
