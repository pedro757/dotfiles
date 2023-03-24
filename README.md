# Dotfiles
These are my configs files. I use arch an based linux, basically my development environment is `tmux` + `neovim`

## Requirements
Run these commands in a bash shell:

## Install
`cd ~ && git clone https://github.com/pedro757/dotfiles.git .dotfiles/`

`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'`

`dotfiles checkout -f`

#### Installing linux programs
> Make sure your linux distro use `pacman`, otherwise install these programs with your favorite package manager

```
sudo pacman -S fish rigrep fd bat fzf kitty alacritty go gopls \
  neovim-nightly-bin tmux xclip exa awesome chromium pulseaudio deno zathura vlc \
  feh maim gopass httpie ttf-jetbrains-mono-nerd ttf-sourcecodepro-nerd \
  noto-fonts-emoji ttf-firacode-nerd rustup
```

#### Setting up podman
```
sudo pacman -S podman docker-compose fuse-overlayfs aardvark-dns

touch /etc/subuid
touch /etc/subgid

usermod --add-subuids 100000-150000 --add-subgids 100000-150000 $USER

podman system migrate
```

#### Installing fish plugins
`curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`

`fisher update`

#### Installing npm packages
> Most of them are neovim language servers

```
npm i -g yarn bash-language-server dockerfile-language-server-nodejs
graphql-language-service-cli intelephense neovim pyright sql-language-server
svelte-language-server tree-sitter-cli typescript typescript-language-server
vim-language-server vscode-langservers-extracted yaml-language-server ls_emmet
eslint_d @fsouza/prettierd @prisma/language-server @tailwindcss/language-server
pnpm
```

#### Installing rust stuff

`rustup component add rust-src`
`rustup component add rust-analyzer`

`cargo install selene stylua dua-cli`

#### Installing python packages

`python3 -m pip install --user --upgrade pynvim`
