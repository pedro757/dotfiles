# COLORSCHEME: gruvbox dark (medium)
set-option -g status "on"

# default statusbar color
set-option -g status-style bg=#3c3836,fg=#ebdbb2 # bg=bg1, fg=fg1

# default window title colors
set-window-option -g window-status-style bg=#fabd2f,fg=#3c3836 # bg=yellow, fg=bg1

# default window with an activity alert
set-window-option -g window-status-activity-style bg=#3c3836,fg=#a89984 # bg=bg1, fg=fg3

# active window title colors
set-window-option -g window-status-current-style bg=red,fg=#3c3836 # fg=bg1

# pane border
set-option -g pane-active-border-style fg=#d5c4a1 #fg2
set-option -g pane-border-style fg=#3c3836 #bg1

# message infos
set-option -g message-style bg=#504945,fg=#ebdbb2 # bg=bg2, fg=fg1

# writing commands inactive
set-option -g message-command-style bg=#504945,fg=#ebdbb2 # bg=fg3, fg=bg1

# pane number display
set-option -g display-panes-active-colour #d5c4a1 #fg2
set-option -g display-panes-colour #3c3836 #bg1

# clock
set-window-option -g clock-mode-colour #83a598 #blue

# bell
set-window-option -g window-status-bell-style bg=#fb4934,fg=#282828 # bg=red, fg=bg

## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
set-option -g status-justify "left"
set-option -g status-left-style none
set-option -g status-left-length "80"
set-option -g status-right-style none
set-option -g status-right-length "80"
set-window-option -g window-status-separator ""
set -g @prefix_highlight_fg '#a89984'
set -g @prefix_highlight_bg '#3c3836'

set-option -g status-left "#[bg=#a89984,fg=#282828] #S #[bg=#3c3836,fg=#a89984,nobold,noitalics,nounderscore]"
set-option -g status-right "#{prefix_highlight} #[bg=#3c3836,fg=#504945 nobold, nounderscore, noitalics]#[bg=#504945,fg=#a89984]  CPU: #{cpu_percentage} #[bg=#504945,fg=#3c3836]  #[bg=#504945,fg=#a89984] %Y-%m-%d #[bg=#504945,fg=#3c3836]  #[bg=#504945,fg=#a89984] %H:%M #[bg=#504945,fg=#a89984,nobold,noitalics,nounderscore]#[bg=#a89984,fg=#282828] #h "

set-window-option -g window-status-current-format "#[bg=#a89984,fg=#3c3836,nobold,noitalics,nounderscore]#[bg=#a89984,fg=#504945] #I #[bg=#a89984,fg=#504945,bold] #W #[bg=#3c3836,fg=#a89984,nobold,noitalics,nounderscore]"
set-window-option -g window-status-format "#[bg=#504945,fg=#3c3836,noitalics]#[bg=#504945,fg=#a89984] #I #[bg=#504945,fg=#3c3836] #[bg=#504945,fg=#a89984] #W #[bg=#3c3836,fg=#504945,noitalics]"

# vim: set ft=tmux tw=0 nowrap:
