#if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#fi

#head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
#sed '1p;/a.out/!d'

stty -ixon

HISTSIZE=9000
export PROMPT_COMMAND="history -a"
shopt -s histappend

alias sshuttle--no-latency-control='sshuttle  --auto-nets --dns --no-latency-control -x 11.0.0.0/8 -x 10.0.0.0/8 -x 30.0.0.0/8'

alias sh=bash
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

oc='\e[m'
wh='\e[1;37m'
gr='\e[1;32m'
yl='\e[1;33m'
rd='\e[1;35m'

PS1="\n${wh}[${gr}\u${yl}@${rd}\H"
PS1="$PS1 "${wh}'`pwd`]'
PS1="$PS1 "${gr}'[shlvl $SHLVL]'
PS1="$PS1 "${rd}'[jobs \j `jobs | sed "s|^[^ ]* *[^ ]* *||g" |tr "\n" " "`]'${oc}'\n\$'

export PATH=/root/code/go/bin:$PATH
export PATH=/root/go/bin:$PATH
export GOPATH=/root/go
export PATH=$(echo $PATH | sed 's/:/\n/g' | awk '!x[$0]++' | tr -s '\n' ':' | sed 's/:$//g')
