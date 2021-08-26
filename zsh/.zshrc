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

function ss(){ ssh mribeiro@$1 }

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias cf='cd $(fd -td | fzf)'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias ls='ls -hNF --color=auto --group-directories-first'
alias ll='ls -lh'
alias cpv='rsync -ah --info=progress2'
alias mkd='mkdir -pv'
alias r='source ranger'       # source will  drop you in the last visited folder when you exit
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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias keys="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

# Fasd aliases
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e vim'       # quick opening files with vim

# JDK
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Spark
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
export PYSPARK_PYTHON=/home/marco/anaconda3/envs/spark/bin/python
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
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export YARN_HOME=$HADOOP_HOME

# Sqoop
export SQOOP_HOME=/opt/sqoop
export PATH=$PATH:$SQOOP_HOME/bin

# Swift
export PATH=/opt/swift/usr/bin:$PATH

# nvm - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_PATH=$(npm root -g)

# ~/.local/bin
export PATH=$PATH:~/.local/bin

export TERM=screen-256color
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# export FZF_DEFAULT_OPTS='--height=50% --min-height=15 --reverse'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fasd --init auto)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

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

source ~/.config/broot/launcher/bash/br
source ~/.zsh/fsh/fast-syntax-highlighting.plugin.zsh
