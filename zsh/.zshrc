fpath+=("$HOME/.zsh/pure")

# Set up the prompt
autoload -Uz promptinit; promptinit
prompt pure

# set autoload path
fpath=(~/.zsh "${fpath[@]}")

# move cursor to end of line after history search completion
autoload -Uz fp kp ks

# every time we load .zshrc, ditch duplicate path entries
typeset -U PATH fpath

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Use vim keybindings
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward


# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt histignorealldups sharehistory
setopt HIST_IGNORE_SPACE

function ss(){ ssh mribeiro@$1 }

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias cf='cd $(fd -td | fzf)'
alias cp='cp -iv'
#alias mv='mv -iv'
alias rm='rm -v'
#alias ls='ls -hNF --color=auto --group-directories-first'
alias ll='ls -lh'
alias cpv='rsync -ah --info=progress2'
alias mkd='mkdir -pv'
alias r='TERM=xterm source ranger'       # source will  drop you in the last visited folder when you exit
alias c='clear'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'
alias g='git'
alias gc='git commit -a -m'
alias gs='git status'
alias up='sudo apt update && sudo apt upgrade -y'
alias ss='ss $1'
alias rskde='killall plasmashell; kstart plasmashell; exit'
alias jtags='ctags -R ./* && sed -i "" -E "/^(if|switch|function|module\.exports|it|describe).+language:js$/d" tags'
alias keys="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"
alias startkde="startx ~/.xinitrc kde"
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias zip='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>
alias sr='source ~/.zshrc'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" 
alias mkdir="mkdir -p"
alias fm='ranger'
alias pacs="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
alias pars="paru -Slq | fzf -m --preview 'cat <(paru -Si {1}) <(paru -Fl {1} | awk \"{print \$2}\")' | xargs -ro  paru -S"
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias p="pacman -Q | fzf"
alias wifi="nmtui-connect"
alias ls="exa --color=auto --icons"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat --color always --plain"
alias grep='grep --color=auto'
alias t="tmux"
alias ta="tmux a"
alias duf="du -sh * | sort -hr"
alias conda="micromamba"
alias vim="nvim"

# Fasd aliases
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias zz='fasd_cd -d -i' # cd with interactive selection

alias d >/dev/null && unalias d
alias v >/dev/null && unalias v
alias vd >/dev/null && unalias vd
alias z >/dev/null && unalias z

function d { folder=$(fasd -dR | awk '{print $2}' | fzf) && cd "$folder" }
function vv { file=$(fasd -fR | awk '{print $2}' | fzf) && nvim "$file" }

# edit given file or search in recently used files
function v {
    local file
    test -e "$1" && $EDITOR "$@" && return
    file=$(fasd -Rfl "$*" | fzf) && $EDITOR "${file}" || $EDITOR "$@"
}

# cd into the directory containing a recently used file
function vd {
    local dir
    local file
    file=$(fasd -Rfl "$*" | fzf) && dir=$(dirname "$file") && cd "$dir"
}

# cd into given dir or search in recently used dirs
function z {
    [ $# -eq 1 ] && test -d "$1" && cd "$1" && return
    local dir
    dir=$(fasd -Rdl "$*" | fzf) && cd "${dir}" || return 1
}

docker_prune() { docker system prune --volumes -fa }

# GO
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# JAVA
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/maven/bin:$PATH"

# JDK
export JAVA_HOME=/opt/homebrew/opt/openjdk@11
export PATH=$PATH:$JAVA_HOME/bin

# Spark
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
#export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
#export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH
export PYSPARK_PYTHON=/opt/micromamba/envs/etl/bin/python
export PYSPARK_DRIVER_PYTHON=/opt/micromamba/envs/etl/bin/python
#export PYSPARK_DRIVER_PYTHON=jupyter
#export PYSPARK_DRIVER_PYTHON_OPTS=notebook

# Hadoop
export HADOOP_HOME=/opt/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_SSH_OPTS="-p 22"
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export YARN_HOME=$HADOOP_HOME

# Hive
export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin
export CLASSPATH=$CLASSPATH:$HADOOP_HOME/lib/*:.
export CLASSPATH=$CLASSPATH:$HIVE_HOME/lib/*:.

# Derbi
export DERBY_HOME=/opt/derby
export PATH=$PATH:$DERBY_HOME/bin
export CLASSPATH=$CLASSPATH:$DERBY_HOME/lib/derby.jar:$DERBY_HOME/lib/derbytools.jar


# Sqoop
# export SQOOP_HOME=/opt/sqoop
# export PATH=$PATH:$SQOOP_HOME/bin

# Swift
export PATH=/opt/swift/usr/bin:$PATH

export TERM=screen-256color
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# export FZF_DEFAULT_OPTS='--height=50% --min-height=15 --reverse'
# export FZF_DEFAULT_COMMAND="fd . $HOME"
# export FZF_DEFAULT_COMMAND='fd --type file'
# export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --inline-info"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fasd --init auto)"
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd)"

export NODE_PATH=$(npm root -g)

fp() {
    RG_PREFIX="rga --rga-adapters=poppler --files-with-matches"
    local file
    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
        fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 0 {q} {}" \
            --phony -q "$1" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window="70%:wrap"
        )" &&
    zathura "$file" > /dev/null &
}

source $HOME/.config/broot/launcher/bash/br
#source ~/.zsh/fsh/fast-syntax-highlighting.plugin.zsh
alias k=kubectl
compdef __start_kubectl k

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/opt/homebrew/opt/micromamba/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/msoares/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/msoares/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/msoares/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/msoares/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<



source /Users/msoares/.config/broot/launcher/bash/br
