eval `dircolors`
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias less='less -R'
export JAVA_HOME="/usr/java/jdk1.7.0_25"
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:/usr/java/jdk1.7.0_25/bin

#Keep this last so it can override general settings!
if [ -f $HOME/dotfiles_local/bashrc ]; then
    . $HOME/dotfiles_local/bashrc
fi
