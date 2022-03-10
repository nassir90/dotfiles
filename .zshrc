# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey '' hgistory-incremental-pattern-search-backward
bindkey -e
PS1='%m %1d> '

# Aliases
alias .=source
alias r.='source ~/.zshrc'
alias ls='ls --color=auto'
alias ll='ls -l -I "*~"'
alias la='ls -A'
alias l='ls -I "*~"'
alias l1='ls -1 -I "*~"'
alias grep='grep --color=auto'
alias vi=nvim
alias loffice=libreoffice
alias py=python3
alias fl="ls $1 | fzf --multi"
alias fcd='cd "`ls -1 | fzf`"'
alias at=alacritty-themes
alias em='emacs -nw'
alias vi=em
alias cd="echo Stop using cd. Just type the directory name.; cd "

# Functions

function zf {
        selection="`fl`"
        if [ -n "$selection" ]
        then
                file "$selection" | grep -q PDF \
                        && zathura "$selection" \
                        || echo "'$selection' is not a PDF"
        fi
}

# Variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ANDROID_SDK_HOME="$HOME/packages/android-sdk/tools/"
export ANDROID_HOME="$HOME/packages/android-sdk/"
export EDITOR=nvim
export B="/media/blackboard-crawler/downloads"
export Be="/media/blackboard-crawler/downloads/CSU11031-202122: Electronics and Information Technology/"

export ROS_DOMAIN_ID=2
source /opt/ros2/galactic/setup.zsh
