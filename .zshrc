fpath+=("$HOME/.zsh/pure")

# Set up the prompt
autoload -Uz promptinit; promptinit
prompt pure

# Use vim keybindings 
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt histignorealldups sharehistory

function ss(){
  ssh mribeiro@$1
}

alias c='clear'
alias get='sudo apt-get install -y'
alias ls='ls -la'
alias upg='sudo apt-get upgrade'
alias up='sudo apt-get update'
alias rem='sudo apt-get remove -y' 
alias fabs='cd /home/marco/fab && . venv/bin/activate'
alias addproxy='export {http,https,ftp}_proxy="http://marco.ribeiro:$password@pac.sicoob.com.br:80"'
alias rmproxy='export {http,https,ftp}_proxy="" && export {HTTP,HTTPS,FTP}_PROXY=""'
alias ss='ss $1'
alias rskde='killall plasmashell; kstart plasmashell; exit'
alias jtags='ctags -R ./* && sed -i "" -E "/^(if|switch|function|module\.exports|it|describe).+language:js$/d" tags'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'''


# set autoload path
fpath=(~/.zsh "${fpath[@]}")

# move cursor to end of line after history search completion
autoload -Uz fp kp ks 

# every time we load .zshrc, ditch duplicate path entries
typeset -U PATH fpath


# JDK
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Spark
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS=notebook
export PYSPARK_PYTHON=/opt/anaconda/anaconda3/envs/ml/bin/python

# Swift
export PATH=/opt/swift/usr/bin:$PATH

# ~/.local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/snap/bin

export TERM=screen-256color
export FZF_DEFAULT_OPTS='--height=50% --min-height=15 --reverse'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
