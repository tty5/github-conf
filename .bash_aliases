#if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#fi

#head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
#sed '1p;/a.out/!d'

stty -ixon

HISTSIZE=9000
export PROMPT_COMMAND="history -a"
shopt -s histappend

source <(crictl completion bash)
source <(kubectl completion bash)
alias sshuttle-all='sshuttle  -l 0.0.0.0 -D --no-latency-control --pidfile /tmp/sshuttle.pid -x 11.0.0.0/8 -x 10.0.0.0/8 -x 30.0.0.0/8 -x 172.16.0.0/12 -x 192.168.0.0/16 0/0'
alias psshuttle-all='proxychains4 -q sshuttle  -D --no-latency-control --pidfile /tmp/sshuttle.pid -x 11.0.0.0/8 -x 10.0.0.0/8 -x 30.0.0.0/8 -x 172.16.0.0/12 -x 192.168.0.0/16 0/0'

alias sh=bash
export EDITOR=vim
alias pse='ps axo user,pid,spid,ppid,pgid,sid,pcpu,pmem,vsz,rss,tname,stat,start,time,args'
alias pst='ps axo user,pid,spid,ppid,pgid,sid,pcpu,pmem,vsz,rss,tname,stat,start,time,args --forest'
alias tmfile="grep -A 1 'base64 ' ~/tmux-histroy/rfile  |tail -1 | sed 's/[ \t]*$//' |base64 -d"

alias qemu-system-x86_64-lite='qemu-system-x86_64 -machine q35,accel=kvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit,nofw'
alias qemu-system-x86_64-kvm='/usr/bin/qemu-system-x86_64 -enable-kvm'
alias r='cd ..'
alias rm='rm -f'
alias l=ls
alias gosrc='cd /root/gopath/src/'
alias vi=vim
alias mergekvmconf='sh scripts/kconfig/merge_config.sh -m .config ~/github-conf/kvm_guest.conf'
alias numfmti='numfmt --to=iec'
alias rs-on='iptables -t nat -A OUTPUT -p tcp -j REDSOCKS'
alias rs-off='iptables -t nat --delete OUTPUT -p tcp -j REDSOCKS'

alias rs-pon='iptables -t nat -A PREROUTING -p tcp -j REDSOCKS'
alias rs-poff='iptables -t nat --delete PREROUTING -p tcp -j REDSOCKS'
alias rs='iptables -t nat -L OUTPUT |grep REDSOCKS > /dev/null ; if [ $? == 0 ]; then rs-poff; rs-off ;else rs-on; rs-pon; fi'

oc='\e[m'
wh='\e[1;37m'
gr='\e[1;32m'
yl='\e[1;33m'
rd='\e[1;35m'

PS1="\n${wh}[${gr}\u${yl}@${rd}\H"
PS1="$PS1 "${wh}'`pwd`]'
PS1="$PS1 "${rd}'[`iptables -t nat -L OUTPUT |grep REDSOCKS > /dev/null && echo rs-on`]'
PS1="$PS1 "${rd}'[`iptables -t nat -L PREROUTING |grep REDSOCKS > /dev/null && echo rs-pon`]'
PS1="$PS1 "${gr}'[shlvl $SHLVL]'
PS1="$PS1 "${rd}'[jobs \j `jobs | sed "s|^[^ ]* *[^ ]* *||g" |tr "\n" " "`]'${oc}'\n\$'

export PATH=/root/gopath/compile/go/bin/:$PATH
export PATH=/root/gopath/bin:$PATH
export GOPATH=/root/gopath
export PATH=$(echo $PATH | sed 's/:/\n/g' | awk '!x[$0]++' | tr -s '\n' ':' | sed 's/:$//g')
