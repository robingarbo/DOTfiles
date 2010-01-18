
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi



# Xiaowei Zhan personalized profile

alias ls='ls --color'
alias rm='rm -i'
alias nheader='tail -n +2'


export PATH=$PATH:~/bin:~/Sanger/prog

#export PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\H> \[\e[0m\]"
export PS1="\[\e[36;1m\]\u@\[\e[31;1m\]\H:\[\e[32;40m\]\w> \[\e[0m\]"

umask 077

export JAVA_HOME=/home/zhanxw/java
export QT_HOME=/home/zhanxw/qt4
export PATH=$JAVA_HOME/bin:$QT_HOME/bin:$PATH

function calc () {
    awk "BEGIN { print $* ; }"
}

function calcfx () {
    gawk -v CONVFMT="%12.2f" -v OFMT="%.9g"  "BEGIN { print $* ; }"
}

# enhanced cd, only need to type partial directory names
function cdh()
{  
    if [ $# = 0 ]; then
       cd
    else
        case $1 in
        .)  echo "you are already in " ;;
        ..) thisdir=`pwd`
            prevdir=`dirname $thisdir`
            cd $prevdir ;;
        *)  counter=`ls -l | grep "^d.*$1" |awk '{print $8}' |wc -l`
            counter=`expr $counter + 0`
            echo
            case $counter in
            1)  cd `ls --color=never | grep "$1"`
                pwd ;;
            0)  if test -d $1
                then cd $1
                else echo "no such directory"
                fi ;;
            *)  echo "the options are"
                for i in *$1*
                do test -d $i && echo "$i"
                done ;;
            esac ;;  
        esac
    fi
}


alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."

shopt -s cdspell

export HISTSIZE=450 
export HISTFILESIZE=450
export HISTCONTROL=ignoredups

alias fantasia="ssh zhanxw@fantasia.sph.umich.edu"
alias wonderland="ssh zhanxw@wonderland.sph.umich.edu"

alias gtest='./gtest --gtest_color=yes '

export R_LIBS=/home/zhanxw/Rpacks
export PATH=$PATH:~/git/bin

export PYTHONPATH="/home/zhanxw/python:/home/zhanxw/python/lib/python2.5/site-packages"

alias ht='htop -u zhanxw'
alias addpath='export PATH=$PATH:'

export CVSROOT=/group/csg/CVS
