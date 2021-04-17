#if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#fi

#head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
#sed '1p;/a.out/!d'

#PS1=${PS1/\\n\\$/}
#PS1="$PS1 "${yl}'[mid]'
#PS1="$PS1$oc\n\$"

tty -s && stty -ixon

HISTSIZE=9000
export PROMPT_COMMAND="history -a"
shopt -s histappend

if [[ x"$OS" != x"Windows_NT" ]]; then alias sd='cd /sd'; fi;

if [[ $(tty) == "/dev/ttyS0" ]]; then resize; fi

# source <(crictl completion bash)
# source <(kubectl completion bash)

# kubectl completion bash > /usr/share/bash-completion/completions/kubectl
# crictl completion bash > /usr/share/bash-completion/completions/crictl

alias sshuttle-all='sshuttle -l 0.0.0.0 --method nft --no-latency-control --pidfile /tmp/sshuttle.pid -x 127.0.0.0/8 -x 10.0.0.0/8 -x 11.0.0.0/8 -x 30.0.0.0/8 -x 172.16.0.0/12 -x 192.168.0.0/16 -x 100.64.0.0/10 -x 169.254.0.0/16 -x 224.0.0.0/4 -x 240.0.0.0/4 0/0'


grep1() {
    read -e line; echo "$line"; grep "$@"
}

param-echo() {
    printf 'Argument is __%s__\n' "$@"
}

socat-tty() {
    socat stdin,raw,echo=0,escape=0x1d "$@"
}

vim-trim() {
    sed -i 's/[ ]*$//' "$1" && vim "$1"
}

function faketty { script -qefc "$(printf "'%s' " "$@")"; }

rs() {
   if [[ "$#" == "0" ]]; then
     rs-trg;
   else
     rs-on; eval "$@"; rs-off;
   fi
}

rs-trg(){
    nft list chain ip redsocks red-output > /dev/null 2>&1 ;
    if [ $? == 0 ]; then rs-off; else rs-on; fi
}

rs-init() {
    exip="$1"
    nft list chain ip redsocks red-local > /dev/null 2>&1 && nft delete table ip redsocks;
    nft create table ip redsocks && \
    nft add chain ip redsocks red-local && \
    nft add rule ip redsocks red-local meta skgid eq 1080 return && \
    for lip in $(echo $exip | tr , ' '); do nft add rule ip redsocks red-local ip daddr $lip return; done && \
    nft add rule ip redsocks red-local ip daddr 10.0.0.0/8 return && \
    nft add rule ip redsocks red-local ip daddr 11.0.0.0/8 return && \
    nft add rule ip redsocks red-local ip daddr 30.0.0.0/8 return && \
    nft add rule ip redsocks red-local ip daddr 100.64.0.0/10 return && \
    nft add rule ip redsocks red-local ip daddr 127.0.0.0/8 return && \
    nft add rule ip redsocks red-local ip daddr 169.254.0.0/16 return && \
    nft add rule ip redsocks red-local ip daddr 172.16.0.0/12 return && \
    nft add rule ip redsocks red-local ip daddr 192.168.0.0/16 return && \
    nft add rule ip redsocks red-local ip daddr 224.0.0.0/4 return && \
    nft add rule ip redsocks red-local ip daddr 240.0.0.0/4 return && \
    nft add rule ip redsocks red-local ip saddr 192.168.1.15 ip protocol tcp counter redirect to :12342 && \
    nft add rule ip redsocks red-local ip saddr 192.168.1.16 ip protocol tcp counter redirect to :12342 && \
    nft add rule ip redsocks red-local ip protocol tcp counter redirect to :12341
}

rs-on() {
    nft list chain ip redsocks red-local > /dev/null 2>&1 || rs-init

    nft add chain ip redsocks red-output { type nat hook output priority 0\; };
    nft add rule ip redsocks red-output ip protocol tcp counter jump red-local;

    nft add chain ip redsocks red-prerouting { type nat hook prerouting priority 0\; } ;
    nft add rule ip redsocks red-prerouting ip protocol tcp counter jump red-local;
}

rs-off() {
    nft delete chain ip redsocks red-output
    nft delete chain ip redsocks red-prerouting
}


export EDITOR=vim

ossutil64-k-cp-s() {
    echo -- ossutil64-key cp "$@"
    ossutil64-key cp "$@"
    sfile="$2"
    [[ $sfile == */ ]] && sfile="$2"$(basename $1)
    echo -- ossutil64-key sign --disable-encode-slash "$sfile"
    ossutil64-key sign --disable-encode-slash "$sfile" |cut -d '?' -f 1
}

journalctl-u() {
    journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show --value -p InvocationID "$1") "${@:2}"
}

openssl-enc() {
    openssl enc -rc4 -e -pass pass:"$1"
}

openssl-dec() {
    openssl enc -rc4 -d -pass pass:"$1"
}

# 显示光标
alias cursor-on='echo -e "\033[?25h"'

alias cp >/dev/null 2>&1; if [[ "$?" == "0" ]]; then unalias cp; fi
alias mv >/dev/null 2>&1; if [[ "$?" == "0" ]]; then unalias mv; fi
alias rm >/dev/null 2>&1; if [[ "$?" == "0" ]]; then unalias rm; fi
alias ls >/dev/null 2>&1; if [[ "$?" == "0" ]]; then unalias ls; fi

alias ls='ls --color=auto'
alias ll='ls -l'

alias r='cd ..'
alias rm='rm -f'
alias l=ls
alias watch='watch -n1'
alias t='tmux a -t one'


alias dd-byte='dd oflag=seek_bytes iflag=skip_bytes,count_bytes status=none'
alias pse='ps axo user,pid,spid,ppid,pgid,sid,pcpu,pmem,vsz,rss,tname,stat,start,time,args'
alias pst='ps axo user,pid,spid,ppid,pgid,sid,pcpu,pmem,vsz,rss,tname,stat,start,time,args --forest'

alias tmfile="grep -A 1 'base64 ' ~/tmux-histroy/rfile  |tail -1 | sed 's/[ \t]*$//' |base64 -d"

alias conf-update='bash -c "cd; cd github-conf; git st; git fetch; git co origin/master"'
alias c-g='curl gstatic.com'
alias c-b='curl baidu.com'

alias e-b='exec bash'

alias display-1920='xrandr -s "1920x1017_60.00"'
alias display-2560='xrandr -s "2560x1346_60.00"'

alias qemu-system-x86_64-lite='qemu-system-x86_64 -machine q35,accel=kvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit,nofw'
alias qemu-system-x86_64-kvm='/usr/bin/qemu-system-x86_64 -enable-kvm'

alias gosrc='cd /sd/gopath/src'
alias go-code='cd /sd/code'

alias vi=vim
alias kvm-mergeconf='sh scripts/kconfig/merge_config.sh -m .config /sd/github-conf/kvm_guest.conf'

alias numfmti='numfmt --to=iec'

oc='\e[m'
wh='\e[1;37m'
gr='\e[1;32m'
yl='\e[1;33m'
rd='\e[1;35m'

if [[ -f /mid ]]; then mid=$(cat /mid); else mid=$(hostname -I |cut -d ' '  -f 1); fi;

PS1="\n${yl}$mid ${wh}[${gr}\u${yl}@${rd}\h"
PS1="$PS1 "${wh}'`pwd`]'

shtret=0; command -v sshuttle > /dev/null 2>&1 && shtret=1
if [[ $shtret == 1 ]]; then
    PS1="$PS1 "${rd}'[`iptables -nt nat -L OUTPUT |grep sshuttle > /dev/null && echo ipt-sht`]'
fi

nftret=0; command -v nft > /dev/null 2>&1 && nftret=1
if [[ $nftret == 1 ]]; then
    PS1="$PS1 "${rd}'[`nft list tables |grep sshuttle > /dev/null && echo nft-sht`]'
    PS1="$PS1 "${rd}'[`nft list chain ip redsocks red-output > /dev/null 2>&1 && echo rs-on`]'
fi

PS1="$PS1 "${gr}'[shlvl $SHLVL]'
PS1="$PS1 "${yl}'[jobs \j `jobs | sed "s|^[^ ]* *[^ ]* *||g" |tr "\n" " "`]'
# PS1="$PS1 "${rd}'[mid $mid ]'

PS1="$PS1"${oc}'\n\$'

export PATH=/sd/gopath/compile/go/bin/:$PATH
export PATH=/sd/gopath/bin:$PATH
export GOPATH=/sd/gopath
export PATH=$(echo $PATH | sed 's/:/\n/g' | awk '!x[$0]++' | tr -s '\n' ':' | sed 's/:$//g')


