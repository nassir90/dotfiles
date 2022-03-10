source $HOME/.zshrc

export PATH="$PATH:$HOME/bin"
export IDEA_JDK="/usr/lib/jvm/java-11-openjdk/"
export GNUPGHOME="$HOME/.config/gnupg/"

export SSH_AUTH_SOCK="`gpgconf --list-dirs agent-ssh-socket`"
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
