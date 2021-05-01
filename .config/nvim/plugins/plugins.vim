call plug#begin("~/.config/nvim/plugged")
  " 0.5 NIGHTLY
  Plug 'neovim/nvim-lspconfig'
  Plug 'onsails/lspkind-nvim'
  " Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'karb94/neoscroll.nvim'
  Plug 'sbdchd/neoformat'
  " Plug 'ahmadie/workspace.vim'
  " Plug 'dosimple/workspace.vim'
  " DEBUG
  Plug 'michaelb/sniprun', {'do': 'bash install.sh'}

  Plug 'glepnir/indent-guides.nvim'
  Plug 'glepnir/lspsaga.nvim'
  " Snippets
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'hrsh7th/nvim-compe'
  Plug 'rafamadriz/friendly-snippets'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  Plug 'lewis6991/gitsigns.nvim'

  " ranger
  Plug 'kevinhwang91/rnvimr',
  Plug 'kevinhwang91/nvim-bqf'

  " Theme
  Plug 'morhetz/gruvbox'
  " Statusline
  Plug 'vim-airline/vim-airline'
  " Plug 'mhinz/vim-signify'
  Plug 'lambdalisue/suda.vim'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-abolish'

  Plug 'airblade/vim-rooter'
  " noh in search
  Plug 'junegunn/gv.vim'
  Plug 'junegunn/vim-slash'
  Plug 'haya14busa/vim-asterisk'

  " TMUX
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'roxma/vim-tmux-clipboard'

  " Plug 'alvan/vim-closetag'
  " Plug 'adelarsq/vim-matchit'
  Plug 'andymass/vim-matchup'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'mattn/emmet-vim'
  Plug 'machakann/vim-sandwich'
  Plug 'wellle/targets.vim'
call plug#end()
