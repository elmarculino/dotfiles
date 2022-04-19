typeset -U PATH path

export LC_CTYPE=pt_BR.UTF-8
export SUDO_ASKPASS="$HOME/.local/bin/dpass"

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

# Disable files
export LESSHISTFILE=-

# Default Apps
export EDITOR="nvim"
export READER="zathura"
export VISUAL="vim"
export TERMINAL="alacritty"
export BROWSER="brave"
export VIDEO="mpv"
export IMAGE="sxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"
export WM="bspwm"


