require "impatient"
vim.g.mapleader = " "
require "plugins"
require "packer_compiled"
require "config.variables"
require "options"
vim.cmd.colorscheme "micolor"
vim.cmd "source $HOME/.config/nvim/vim/abbrev.vim"
require "mappings"
require "config.telescope"
require "config.lsp"
require "config.treesitter"
require "config.others"
vim.cmd "source $HOME/.config/nvim/vim/functions.vim"
require "commands"
