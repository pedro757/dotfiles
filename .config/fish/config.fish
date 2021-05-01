set fish_greeting

alias vim="nvim"
alias old_vim="\vim"
alias dcompose="docker-compose"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

# set PATH /Users/MyUserName/.nvm/versions/node/v13.13.0/bin $PATH


# Functions needed for !! and !$
# Will only work in default (emacs) mode.
# Will NOT work in vi mode.
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

set -x EDITOR "nvim"
set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -g fish_color_search_match --background=#458588
