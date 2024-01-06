set fish_greeting

alias vim="nvim"
alias old_vim="\vim"
alias dcompose="docker-compose"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'
alias la='exa --long --icons --git -a'
alias ll='exa --long --icons --git'
# alias bun='sde -chip-check-disable -- bun'

# set PATH /Users/MyUserName/.nvm/versions/node/v13.13.0/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/go/bin $PATH

# Functions needed for !! and !$
# Will only work in default (emacs) mode.
# Will NOT work in vi mode.

# function __history_previous_command
#   switch (commandline -t)
#   case "!"
#     commandline -t $history[1]; commandline -f repaint
#   case "*"
#     commandline -i !
#   end
# end
#
# function __history_previous_command_arguments
#   switch (commandline -t)
#   case "!"
#     commandline -t ""
#     commandline -f history-token-search-backward
#   case "*"
#     commandline -i '$'
#   end
# end
# # The bindings for !! and !$
# bind ! __history_previous_command
# bind '$' __history_previous_command_arguments

# bind \cj 'history-search-forward'
# bind \ck 'history-search-backward'
# bind \cl 'execute'

set -x EDITOR "nvim"
set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -gx GPG_TTY (tty)

# set --global tide_character_icon "➜"
# set --global tide_prompt_add_newline_before false
# set --global tide_left_prompt_suffix

if status --is-interactive
  abbr --add --global celar clear
  abbr --add --global clar clear
  abbr --add --global claer clear
  abbr --add --global cñear clear
  abbr --add --global cleara clear
  abbr --add --global clra clear
  abbr --add --global clare clear
  abbr --add --global clera clear
  abbr --add --global clrea clear
  abbr --add --global clre clear
  abbr --add --global pnpn pnpm
end

# Created by `pipx` on 2022-02-23 01:40:52
set PATH $PATH /home/pedro/.local/bin

starship init fish | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
rtx activate fish | source
