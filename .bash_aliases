alias grep='egrep --color'
alias e='emacs'
alias df='df -h'
alias du='du -h'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -i'

if [[ $OSTYPE =~ ^darwin ]]; then
    alias ls='gls -F -h --color=auto --group-directories-first'
else
    alias ls='ls -F -h --color=auto'
fi
