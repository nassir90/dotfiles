# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload select-word-style
select-word-style bash

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
fpath=(~/bin/zsh/{,completions} $fpath)
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey '' history-incremental-pattern-search-backward
bindkey -e
prompt='%m %1d> '

# Aliases
alias .=source
alias .z='source ~/.zshrc'
alias .r='source ./install/setup.zsh'
alias ls='ls --color=auto'
alias ll='ls -l -I "*~"'
alias la='ls -A'
alias l='ls -I "*~"'
alias l1='ls -1 -I "*~"'
alias grep='grep --color=auto'
alias loffice=libreoffice
alias pyrc='python3 -i ~/.config/pythonrc'
alias py=python3
alias at=alacritty-themes
alias em='emacsclient'
alias sb='sbcl --noinform --script'
alias sbclr='rlwrap sbcl'
alias another='alacritty &!'

xdg-set-opener () {
        [ ! ${#*} -eq 2 ] && return
        application="$1"
        mimetype=$(xdg-mime query filetype "$2")
        echo -n "'$application'" will open "'$mimetype'". 'Continue? [y/N] '
	read -k answer
	echo
	[ $answer = y ] && xdg-mime default "$application" "$mimetype" || echo 'Ok. Not changing anything.'
}

fcd () {
    cd $(ff -d $*)
}

ff () {
        local depth_arg=(-maxdepth 1)
        local header_suffix="(cwd: $(pwd))"
        local header="Pick a file"
	local filename_format='%f'
        
        while getopts frdDs:m: name
        do
                case $name in
                        f) type_arg=(-type f) ;;
                        d) header="Pick a directory"
                           implicit_fields=".."
                           type_arg=(-type d) ;;
                        s) header_suffix="$OPTARG" ;;
                        m) depth_arg=(-maxdepth $OPTARG) ;;
			D) filename_format='%h/%f' ;;
                        r) filename_format='%h/%f'
			   depth_arg= ;;
			?) return 1 ;;
                esac
        done
        
        shift $[ OPTIND - 1 ]

	local basename

        find $1 $depth_arg $type_arg -printf "$filename_format\\n" \
                | awk "{print} BEGIN {print \"$implicit_fields\"}" \
                | fzf --header="$header $header_suffix" --header-first --multi \
                | read basename

	[ -n "$1" ] && echo $1/$basename || echo $basename
}

cd () {
    [ -n "$1" ] && selection="$1" || selection=~
    pushd -q "$selection" || return 1
}

dirstack () {
    for dir in $dirstack ; do echo $dir ; done
}

scd () {
    [ -z "$1" ] && dirstack | sort -u | grep -v "^$(pwd)$" | fzf --header-first --header="Pick a directory (cwd: $(pwd))" | read selection \
	    || selection="$1"
    cd "$selection"
}

fof () {
    local suffix selection
    
    getopts n name && \
	if [ $name = n ]
	then
	    suffix=\&
	    1=
	fi
    
    shift $[ $OPTIND - 1 ]
    
    [ -f "$1" ] && selection="$1" || ff -f "$1" | read selection

    if [ -n "$selection" ] ; then
        command="xdg-open '$selection'"
        [ zsh = $(basename $SHELL) ] && print -s $command
        $SHELL -c "$command $suffix"
    fi      
}

help () {
    [ -n "$1" ] && (cat /usr/share/zsh/5.8.1/help/$1 2>/dev/null || echo No help for "'$1'" found... && return 1)
}

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ANDROID_SDK_HOME="$HOME/packages/android-sdk/tools/"
export ANDROID_HOME="$HOME/packages/android-sdk/"
export EDITOR=nvim
export B="/media/blackboard-crawler/downloads"
export Be="/media/blackboard-crawler/downloads/CSU11031-202122: Electronics and Information Technology/"

export ROS_DOMAIN_ID=2
source /opt/ros2/galactic/setup.zsh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
