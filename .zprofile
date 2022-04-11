source $HOME/.zshrc

export IDEA_JDK="/usr/lib/jvm/java-11-openjdk/"
export GNUPGHOME="$HOME/.config/gnupg/"
export GOPATH="$HOME/projects/go"
export PATH="$PATH:$HOME/bin:$GOPATH/bin:$HOME/bin/zsh:$HOME/.cargo/bin"
export TERMINAL=alacritty
export SSH_AUTH_SOCK="`gpgconf --list-dirs agent-ssh-socket`"
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
