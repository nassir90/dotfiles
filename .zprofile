export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export EUFS_MASTER="$HOME/naza/projects/ros/eufs"
export SCREENSHOT_DIR="$HOME/pictures/screenshots"
export CAR="$HOME/pictures/vehicle.png"
export MIDAS="$HOME/projects/cloned/MiDaS/"
export AWESOME_SEGMENTATION_FORK="$HOME/projects/python/ft_semantic_segmentation/scripts/"
export ROS_DOMAIN_ID=2
export IDEA_JDK="/usr/lib/jvm/java-11-openjdk/"
export GOPATH="$HOME/projects/go"
export PATH="$PATH:$HOME/bin:$GOPATH/bin:$HOME/bin/zsh:$HOME/.cargo/bin"
export TERMINAL=alacritty
export GNUPGHOME="$HOME/.config/gnupg/"
export SSH_AUTH_SOCK="`gpgconf --list-dirs agent-ssh-socket`"
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

source ~/.zshrc
