# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/naza/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey -v
bindkey '' history-incremental-pattern-search-backward
PS1='%m %1d> '

# Aliases
alias .=source
alias vi=nvim
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -1'
alias grep='grep --color=auto'
alias vi="nvim"
alias loffice="libreoffice"
alias py="python3"
alias fl="ls | fzf --multi"
alias fcd='cd "`ls -1 | fzf`"'
alias zf='zathura "`fl`"'

# Variables
export ANDROID_SDK_HOME="/home/naza/packages/android-sdk/tools/"
export ANDROID_HOME="/home/naza/packages/android-sdk/"
export EDITOR=nvim
