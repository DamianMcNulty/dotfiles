eval `dircolors`
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias less='less -R'
#Keep this last so it can override general settings!
if [ -f $HOME/dotfiles_local/bashrc ]; then
    . $HOME/dotfiles_local/bashrc
fi