# Dotfiles
These are my configs files. I use arch an based linux, basically my development environment is `tmux` + `neovim`

## Requirements
Run these commands in a bash shell:

#### Installing linux programs
> Make sure your linux distro use `pacman`, otherwise install these programs with your favorite package manager

`sudo pacman -S fish rigrep fd bat fzf kitty alacritty gopls neovim-nightly-bin tmux nvm xclip ranger exa`


#### Installing npm packages
> Most of them are neovim language servers

`npm i -g prettier yarn bash-language-server dockerfile-language-server-nodejs graphql-language-service-cli intelephense
neovim pyright sql-language-server svelte-language-server tree-sitter-cli typescript typescript-language-server
vim-language-server vscode-css-languageserver-bin vscode-html-languageserver-bin vscode-json-languageserver
yaml-language-server ls_emmet`

#### Installing python packages

`python2 -m pip install --user --upgrade pynvim`

`python3 -m pip install --user --upgrade pynvim`

## Install
`cd ~ && git clone https://github.com/pedro757/dotfiles.git`
