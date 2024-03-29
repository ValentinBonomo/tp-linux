# TP1 : (re)Familiaration avec un système GNU/Linux

## 0. Préparation de la machine

🌞 **Setup de deux machines Rocky Linux configurées de façon basique.**

Pour l'instant je me co avec 192.168.1.107 pour changer l'hostname et l'ip puis après j'utilise la bonne ip pour les pings et autres.

VM1:
```bash
[ersjyhag@localhost ~]$ sudo hostname node1.tp1.b2
[ersjyhag@localhost ~]$ hostname
node1.tp1.b2
PS C:\Users\Utilisateur> ssh ersjyhag@192.168.1.106
Last login: Mon Nov 14 11:49:10 2022 from 192.168.1.1
[ersjyhag@localhost ~]$ echo 'node1.tp1.b2' | sudo tee /etc/hostname
[sudo] password for ersjyhag:
node1.tp1.b2
[ersjyhag@localhost ~]$ sudo reboot
[ersjyhag@node1 ~]$
```

VM2 :
```bash
[ersjyhag@localhost ~]$ sudo hostname node2.tp1.b2
[ersjyhag@localhost ~]$ hostname
node2.tp1.b2
PS C:\Users\Utilisateur> ssh ersjyhag@192.168.1.107
Last login: Mon Nov 14 11:49:10 2022 from 192.168.1.1
[ersjyhag@localhost ~]$ echo 'node2.tp1.b2' | sudo tee /etc/hostname
[sudo] password for ersjyhag:
node2.tp1.b2
[ersjyhag@localhost ~]$ sudo reboot
[ersjyhag@node2 ~]$
```

VM1:
```bash
[ersjyhag@node1 ~]$ ls /etc/sysconfig/network-scripts
[ersjyhag@node1 ~]$ sudo nano /etc/sysconfig/network-scripts/ifcfg-enp0s8
[ersjyhag@node1 ~]$ sudo cat /etc/sysconfig/network-scripts/ifcfg-enp0s8
DEVICE=enp0s8

BOOTPROTO=static
ONBOOT=yes

IPADDR=10.101.1.11
NETMASK=255.255.255.0
[ersjyhag@node1 ~]$ sudo systemctl restart NetworkManager
[ersjyhag@node1 ~]$ sudo reboot
[ersjyhag@node1 ~]$ 
[ersjyhag@node1 ~]$ ip a | grep enp0s8
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 10.101.1.11/24 brd 10.101.1.255 scope global noprefixroute enp0s8
```

VM2:
```bash
[ersjyhag@node2 ~]$ ls /etc/sysconfig/network-scripts
[ersjyhag@node2 ~]$ sudo nano /etc/sysconfig/network-scripts/ifcfg-enp0s8
[ersjyhag@node2 ~]$ sudo cat /etc/sysconfig/network-scripts/ifcfg-enp0s8
DEVICE=enp0s8

BOOTPROTO=static
ONBOOT=yes

IPADDR=10.101.1.12
NETMASK=255.255.255.0
[ersjyhag@node2 ~]$ sudo systemctl restart NetworkManager
[ersjyhag@node2 ~]$ sudo reboot
[ersjyhag@node2 ~]$ 
[ersjyhag@node2 ~]$ ip a | grep enp0s8
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 10.101.1.12/24 brd 10.101.1.255 scope global noprefixroute enp0s8
```


VM1:

```bash
[ersjyhag@node1 ~]$ sudo nano /etc/resolv.conf
[ersjyhag@node1 ~]$ cat /etc/resolv.conf
# Generated by NetworkManager
search tp1.b2
nameserver 1.1.1.1
[ersjyhag@node1 ~]$ ping 10.101.1.12
PING 10.101.1.12 (10.101.1.12) 56(84) bytes of data.
64 bytes from 10.101.1.12: icmp_seq=1 ttl=64 time=0.268 ms
64 bytes from 10.101.1.12: icmp_seq=2 ttl=64 time=0.226 ms
64 bytes from 10.101.1.12: icmp_seq=3 ttl=64 time=0.303 ms
^C
--- 10.101.1.12 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2087ms
rtt min/avg/max/mdev = 0.226/0.265/0.303/0.031 ms
[ersjyhag@node1 ~]$ dig 1.1.1.1

; <<>> DiG 9.16.23-RH <<>> 1.1.1.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 26528
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;1.1.1.1.                       IN      A

;; AUTHORITY SECTION:
.                       86400   IN      SOA     a.root-servers.net. nstld.verisign-grs.com. 2022111400 1800 900 604800 86400

;; Query time: 13 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Mon Nov 14 12:20:35 CET 2022
;; MSG SIZE  rcvd: 111
```

VM2:

```bash
[ersjyhag@node2 ~]$ sudo nano /etc/resolv.conf
[ersjyhag@node2 ~]$ cat /etc/resolv.conf
# Generated by NetworkManager
search tp1.b2
nameserver 1.1.1.1
[ersjyhag@node2 ~]$ ping 10.101.1.11
PING 10.101.1.11 (10.101.1.11) 56(84) bytes of data.
64 bytes from 10.101.1.11: icmp_seq=1 ttl=64 time=0.271 ms
64 bytes from 10.101.1.11: icmp_seq=2 ttl=64 time=0.315 ms
64 bytes from 10.101.1.11: icmp_seq=3 ttl=64 time=0.226 ms
^C
--- 10.101.1.11 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2055ms
rtt min/avg/max/mdev = 0.226/0.270/0.315/0.036 ms
[ersjyhag@node2 ~]$ dig 1.1.1.1
; <<>> DiG 9.16.23-RH <<>> 1.1.1.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 42144
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;1.1.1.1.                       IN      A

;; AUTHORITY SECTION:
.                       85828   IN      SOA     a.root-servers.net. nstld.verisign-grs.com. 2022111400 1800 900 604800 86400

;; Query time: 13 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Mon Nov 14 12:15:51 CET 2022
;; MSG SIZE  rcvd: 111

```

VM1:
```bash
[ersjyhag@node1 ~]$ sudo nano /etc/hosts
[ersjyhag@node1 ~]$ cat /etc/hosts | grep 10.101.1.12
10.101.1.12 node2.tp1.b2
[ersjyhag@node1 ~]$ ping node2.tp1.b2
PING node2.tp1.b2 (10.101.1.12) 56(84) bytes of data.
64 bytes from node2.tp1.b2 (10.101.1.12): icmp_seq=1 ttl=64 time=0.271 ms
64 bytes from node2.tp1.b2 (10.101.1.12): icmp_seq=2 ttl=64 time=0.377 ms
64 bytes from node2.tp1.b2 (10.101.1.12): icmp_seq=3 ttl=64 time=0.303 ms
^C
--- node2.tp1.b2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2046ms
rtt min/avg/max/mdev = 0.271/0.317/0.377/0.044 ms
```

VM2:

```bash
[ersjyhag@node2 ~]$ sudo nano /etc/hosts
[sudo] password for ersjyhag:
[ersjyhag@node2 ~]$ cat /etc/hosts | grep 10.101.1.11
10.101.1.11 node1.tp1.b2
[ersjyhag@node2 ~]$ ping node1.tp1.b2
PING node1.tp1.b2 (10.101.1.11) 56(84) bytes of data.
64 bytes from node1.tp1.b2 (10.101.1.11): icmp_seq=1 ttl=64 time=0.223 ms
64 bytes from node1.tp1.b2 (10.101.1.11): icmp_seq=2 ttl=64 time=0.251 ms
^C
--- node1.tp1.b2 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1028ms
rtt min/avg/max/mdev = 0.223/0.237/0.251/0.014 ms
```

## I. Utilisateurs

### 1. Création et configuration

🌞 **Ajouter un utilisateur à la machine**

```bash
[ersjyhag@node2 ~]$ sudo useradd -d /home/newuser -s /bin/sh newuser
[ersjyhag@node2 ~]$ cat /etc/passwd | grep newuser
newuser:x:1001:1001::/home/newuser:/bin/sh
```

🌞 **Créer un nouveau groupe `admins`**

```bash
[ersjyhag@node2 ~]$ sudo groupadd admins
[ersjyhag@node2 ~]$ sudo visudo /etc/sudoers
shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
[ersjyhag@node2 ~]$ sudo cat /etc/sudoers | grep admins
%admins ALL=(ALL)       ALL
```

🌞 **Ajouter votre utilisateur à ce groupe `admins`**

```bash
[ersjyhag@node2 ~]$ sudo usermod -aG admins newuser
```
### 2. SSH

🌞 **Pour cela...**

```bash
#Terminal noraml
PS C:\Users\Utilisateur> ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\Utilisateur/.ssh/id_rsa):
C:\Users\Utilisateur/.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase):
Your identification has been saved in C:\Users\Utilisateur/.ssh/id_rsa.
Your public key has been saved in C:\Users\Utilisateur/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:SSf+zE08l8I6q/lW47l2sW3QQsX7rDpU1NnFhAT35oQ utilisateur@DESKTOP-2A4B044
The keys randomart image is:
+---[RSA 4096]----+
|            .oo**|
|             .o+*|


#GIT BASH
Utilisateur@DESKTOP-2A4B044 MINGW64 ~
$ ssh-copy-id ersjyhag@10.101.1.12
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/c/Users/Utilisateur/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ersjyhag@10.101.1.12s password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'ersjyhag@10.101.1.12'"
and check to make sure that only the key(s) you wanted were added.
```
🌞 **Assurez vous que la connexion SSH est fonctionnelle**, sans avoir besoin de mot de passe.

```bash
PS C:\Users\Utilisateur> ssh ersjyhag@10.101.1.12
Last login: Thu Nov 17 00:45:10 2022 from 10.101.1.1
[ersjyhag@node2 ~]$
```

## II. Partitionnement

