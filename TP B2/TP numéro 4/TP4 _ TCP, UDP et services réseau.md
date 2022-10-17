# TP4 : TCP, UDP et services réseau

# I. First steps

🌞 **Déterminez, pour ces 5 applications, si c'est du TCP ou de l'UDP** + 🦈🦈🦈🦈🦈 **Bah ouais, captures Wireshark à l'appui évidemment.**

-- Spotify : 
IP: 2600:1901:1:c36::
Port: 443
Port Local: 56414
wireshark link : [`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/spotify.pcapng)

-- discord : 
IP: 162.159.130.234
Port: 443
Port Local: 51954
wireshark link : [`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/discord.pcapng)

-- opéra : 
IP: 2001:4c28:4000:722:185:26:182:94
Port: 443
Port Local: 51965
wireshark link : [`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/opéra.pcapng)

-- steam : 
IP: 92.123.238.137
Port: 443
Port Local: 50417
wireshark link : [`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/steam.pcapng)

-- osu : 
IP: 2606:4700:10::6816:4ab4
Port: 443
Port Local: 52318/52358
wireshark link : [`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/osu.pcapng)

Pour avoir les packets sur wireshark j'ai utilisé "tcp contains ..."

🌞 **Demandez aux OS**

```bash
$ netstat -bn | findstr 2600:1901:1:c36::
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:56893  [2600:1901:1:c36::]:443  ESTABLISHED

$ netstat -bn | findstr 162.159.130.234
  TCP    192.168.1.34:55897     162.159.130.234:443    ESTABLISHED

$ netstat -bn | findstr 2001:4c28
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:50458  [2001:4c28:4000:722:185:26:182:106]:443  ESTABLISHED

$ netstat -bn | findstr 92.123.238.137
  TCP    192.168.1.34:50330     92.123.238.137:443     ESTABLISHED
  TCP    192.168.1.34:50331     92.123.238.137:443     ESTABLISHED
  TCP    192.168.1.34:50332     92.123.238.137:443     ESTABLISHED
  TCP    192.168.1.34:50333     92.123.238.137:443     ESTABLISHED
  TCP    192.168.1.34:50340     92.123.238.137:443     ESTABLISHED
  TCP    192.168.1.34:50341     92.123.238.137:443     ESTABLISHED

$ netstat -bn | findstr 2606:4700:10::6816:4ab4
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:50153  [2606:4700:10::6816:4ab4]:443  ESTABLISHED
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:50154  [2606:4700:10::6816:4ab4]:443  ESTABLISHED
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:62226  [2606:4700:10::6816:4ab4]:443  TIME_WAIT
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:62243  [2606:4700:10::6816:4ab4]:443  TIME_WAIT
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:62251  [2606:4700:10::6816:4ab4]:443  ESTABLISHED
```
Les ports sont différents car les packets correspondent à des actions comme ouvrir une page internet opéra, changer de musique ou encore aller sur des pages différentes de steam du coup comme les actions on été faites deux fois une pour wireshark et une pour la commande donc je suis pratiquement sur que c'est la raison sauf si j'ai fait une erreur.

# II. Mise en place

## 1. SSH

🌞 **Examinez le trafic dans Wireshark**

Ssh utilise TCP
[`paquet ssh`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%204/Wireshark/ssh.pcapng)

🦈 **Je veux une capture clean avec le 3-way handshake, un peu de trafic au milieu et une fin de connexion**


Mon pc : 
```bash
$ netstat -bn
[ssh.exe]
  TCP    [2a02:8428:7d0e:fd01:2050:1fb3:117b:f53]:49416  [2603:1010:300::84]:443  FIN_WAIT_1
```

La Vm : 

```bash
[ersjyhag@localhost ~]$ ss | grep ssh
tcp   ESTAB  0      52                   192.168.1.101:ssh       192.168.1.196:49162
```

## 2. NFS

🌞 **Mettez en place un petit serveur NFS sur l'une des deux VMs**

Première VM
(Ps: Je fais le compte rendu après avoir tout fini car j'ai eu pas mal d'erreur donc peut-être que je vais oublier de noter dans le markdown les commandes que j'ai tapé)

```bash
[ersjyhag@ersjyhag ~]$ sudo dnf -y install nfs-utils
Last metadata expiration check: 3:36:37 ago on Mon 17 Oct 2022 09:38:28 AM CEST.
Package nfs-utils-1:2.5.4-10.el9.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!
[root@ersjyhag ~]$ cat /etc/idmapd.conf
[General]
#Verbosity = 0
# The following should be set to the local NFSv4 domain name
# The default is the host's DNS domain name.
Domain = srv.world
[...]
[root@ersjyhag ~]$ cat /etc/exports
/srv 192.168.1.101/24(rw,no_root_squash)
[root@ersjyhag ~]$ systemctl enable --now rpcbind nfs-server
[root@ersjyhag ~]$firewall-cmd --add-service=nfs
success
[root@ersjyhag ~]$firewall-cmd --add-service={nfs3,mountd,rpc-bind}
success
[root@ersjyhag ~]$firewall-cmd --runtime-to-permanent
success
```

Sur la deuxième VM (après les installs) : 
```bash
[root@localhost ~]$ mkdir /srv/test
[root@localhost ~]$ mount 192.168.1.102:/srv /srv/test
[root@localhost test]$ touch valentin
```

Puis une vérif sur la première VM : 

```bash
[ersjyhag@ersjyhag ~]$ ls /srv
fichier.txt  valentin
```

🌞 **Wireshark it !**

