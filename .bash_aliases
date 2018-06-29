#if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#fi

#head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
#sed '1p;/a.out/!d'

stty -ixon

HISTSIZE=9000
export PROMPT_COMMAND="history -a"
shopt -s histappend

alias sshuttle--no-latency-control='sshuttle --no-latency-control'

export EDITOR=vim
alias pse='ps axo user,pid,spid,ppid,sid,pcpu,pmem,vsz,rss,tname,stat,start,time,args'
alias pst='pse --forest'

alias qemu-system-x86_64-lite='qemu-system-x86_64 -machine q35,accel=kvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit,nofw'
alias qemu-system-x86_64-kvm='/usr/bin/qemu-system-x86_64 -enable-kvm'
alias r='cd ..'
alias rm='rm -f'
alias l=ls
alias vi=vim
alias mergekvmconf='sh scripts/kconfig/merge_config.sh -m .config ~/github-conf/kvm_guest.conf'

PS1='\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\H\e[m \e[4m`pwd`\e[m\e[1;37m]\e[m\e[1;36m\e[m \e[1;35m[jobs \j `jobs | sed "s|^[^ ]* *[^ ]* *||g" |tr "\n" " "`]\e[m \n\$'
