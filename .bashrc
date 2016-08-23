# Call OS-specific customizations
if [[ $OSTYPE =~ ^linux ]]; then
    source ~/.bashrc_linux
elif [[ $OSTYPE =~ ^darwin ]]; then
    source ~/.bashrc_mac
elif [[ $OSTYPE =~ ^cygwin ]]; then
    source ~/.bashrc_cygwin
elif [[ $OSTYPE =~ ^solaris ]]; then
    source ~/.bashrc_solaris
fi

# Scripts
export PATH=$PATH:~/bin

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Prompt
export PS1="<\d, \t \u@\h: \w>\n\! \$ "

# Pager
export PAGER='less -i'

##### Shell options

# Don't let shell redirects clobber files. Use |> to force.
set -o noclobber

# Don't wait for job termination notification.
set -o notify

# Don't use ^D to exit.
set -o ignoreeof

# Use case-insensitive filename globbing.
shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache.
shopt -s cdspell

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Disable the Ctrl-S shortcut that sets XON/XOFF.
stty -ixon

##### History options

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# on a substitution, let the user verify it first
shopt -s histverify

# and on a failed substitution, put it back on the commandline
shopt -s histreedit

# don't put duplicate lines in the history. See bash(1) for more options
# # ... or force ignoredups and ignorespace
export HISTCONTROL=ignoredups:ignorespace

# TODO: consider using histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

if [ -r ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -r ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
