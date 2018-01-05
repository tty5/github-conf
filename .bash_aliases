#if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#fi

#head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
#sed '1p;/a.out/!d'

stty -ixon

HISTSIZE=9000
export PROMPT_COMMAND="history -a"

export EDITOR=vim

alias r='cd ..'
alias v='vi'
alias rm='rm -f'
alias l=ls
alias vi=vim
