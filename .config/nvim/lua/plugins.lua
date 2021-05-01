vim.cmd('packadd packer.nvim')
-- vim._update_package_paths()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  -- use 'folke/lsp-colors.nvim'
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'karb94/neoscroll.nvim'
  use 'sbdchd/neoformat'
  -- DEBUG

  use 'glepnir/indent-guides.nvim'
  use 'glepnir/lspsaga.nvim'
  -- Snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/nvim-compe'
  use 'rafamadriz/friendly-snippets'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use { 'npxbr/glow.nvim', run = ':GlowInstall' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use { 'michaelb/sniprun', run = 'install.sh'}
  use 'lewis6991/gitsigns.nvim'

  -- ranger
  use 'kevinhwang91/rnvimr'
  use 'kevinhwang91/nvim-bqf'

  -- Theme
  use 'morhetz/gruvbox'
  -- Statusline
  use 'vim-airline/vim-airline'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  use 'tpope/vim-commentary'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-abolish'

  use 'airblade/vim-rooter'
  use 'junegunn/gv.vim'
  use 'junegunn/vim-slash'
  use 'haya14busa/vim-asterisk'

  -- TMUX
  use 'christoomey/vim-tmux-navigator'
  use 'roxma/vim-tmux-clipboard'

  use 'lambdalisue/suda.vim'
  use 'andymass/vim-matchup'
  use 'editorconfig/editorconfig-vim'
  use 'mattn/emmet-vim'
  use 'machakann/vim-sandwich'
  use 'wellle/targets.vim'
end)
