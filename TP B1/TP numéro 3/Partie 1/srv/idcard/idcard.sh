#!/bin/bash

MACHINE="Machine name : "
echo -n $MACHINE > machine.txt

NOMDEMACHINE=$(hostname)
echo $NOMDEMACHINE >> nommachine

SPACE=' '
echo -n $SPACE >> machine.txt

head -n 1  nommachine >> machine.txt

OS="OS "
echo -n $OS > os.txt

OSR=$(cat /etc/os-release | grep NAME | grep -v VERSION | grep -v PRETTY | grep -v COD | cut -d'"' -f2)
echo -n $OSR >> os.txt

OSVERSION=" and kernel version is "
echo -n $OSVERSION >> os.txt

cat /proc/version | cut -d" " -f3 >> os.txt

IP="IP : "
echo -n $IP > ip.txt

ip a | grep inet| grep 192 | cut -d" " -f6 >> ip.txt

MEM="RAM : "
echo -n $MEM > mem.txt

USED=$(free -mh | grep Mem: | cut -d' ' -f47 | cut -d"G" -f1)
echo -n $USED >> mem.txt

RAM="Go RAM restante sur "
echo -n $RAM >> mem.txt

DISPO=$(free -mh | grep Mem: | cut -d' ' -f12 | cut -d"G" -f1)
echo -n $DISPO >> mem.txt

RAMG="Go RAM totale"
echo $RAMG >> mem.txt

DISQUE="Disque : "
echo -n $DISQUE > stockage.txt

STORAGE=$(df -h | grep /dev/sda3 | cut -d" " -f17 | cut -d"G" -f1)
echo -n $STORAGE >> stockage.txt

DISQUED="Go space left"
echo $DISQUED >> stockage.txt

TOP="Top 5 processes by RAM usage :"
echo $TOP > ram.txt

ps -eo %mem,command | sort | tail -n 6 | head -n 5 | cut -d"." -f2 | cut -c3- > ramprog.txt

TOP1="	- "
echo -n $TOP1 >> ram.txt

head -n 5 ramprog.txt | tail -n 1 >> ram.txt

TOP2="  - "
echo -n $TOP2 >> ram.txt

head -n 4 ramprog.txt | tail -n 1 >> ram.txt

TOP3="  - "
echo -n $TOP3 >> ram.txt

head -n 3 ramprog.txt | tail -n 1 >> ram.txt

TOP4="  - "
echo -n $TOP4 >> ram.txt

head -n 2 ramprog.txt | tail -n 1 >> ram.txt

TOP5="  - "
echo -n $TOP5 >> ram.txt

head -n 1 ramprog.txt >> ram.txt

PORT="Listening ports :"
echo $PORT > lisport.txt

ss -lntap | grep LISTEN | head -n 3 | cut -d":" -f2 | cut -d" " -f1 > port.txt
ss -lntap | grep LISTEN | head -n 3 | cut -d":" -f4 | cut -d" " -f1 | cut -d'"' -f2 > programmeport.txt

PORT1="  - "
echo -n $PORT1 >> lisport.txt

CORPORT1=$(head -n 1 port.txt)
echo -n $CORPORT1 >> lisport.txt

DPORT1="  : "
echo -n $DPORT1 >> lisport.txt

head -n 1 programmeport.txt >> lisport.txt

PORT2="  - "
echo -n $PORT2 >> lisport.txt

CORPORT2=$(head -n 2 port.txt | tail -n 1)
echo -n $CORPORT2 >> lisport.txt

DPORT2="  : "
echo -n $DPORT2 >> lisport.txt

head -n 2 programmeport.txt | tail -n 1 >> lisport.txt

PORT3="  - "
echo -n $PORT3 >> lisport.txt

CORPORT3=$(head -n 3 port.txt | tail -n 1)
echo -n $CORPORT3 >> lisport.txt

DPORT3="  : "
echo -n $DPORT3 >> lisport.txt

head -n 3 programmeport.txt | tail -n 1 >> lisport.txt

URL="Here's your random cat : "
echo -n $URL > url.txt

curl -s  https://api.thecatapi.com/v1/images/search | awk -F 'url":"' '{print $2}' | cut -d'"' -f1 >> url.txt

cat machine.txt os.txt ip.txt mem.txt stockage.txt ram.txt lisport.txt url.txt

