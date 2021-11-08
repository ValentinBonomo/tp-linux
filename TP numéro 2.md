# TP numéro 2 : 
## Prérequis : 
### 2. Nommer la machine 
#### Changer le nom de la machine : 
Première étape :
```bash=
it4@node1:~$ sudo hostname node1.tp2.linux
```
Deuxième étape :

```bash=
it4@node1:~$ sudo nano /etc/hostname
it4@node1:~$ cat /etc/hostname
node1.tp2.linux

it4@node1:~$ reboot

it4@node1:~$ hostname
node1.tp2.linux
```
### 3. Config Réseau

Vérification :
```bash=
#Depuis la vm
it4@node1:~$ ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=54 time=22.4 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=54 time=21.5 ms
^C
--- 1.1.1.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 21.506/21.960/22.415/0.454 ms
it4@node1:~$ ping ynov.com
PING ynov.com (92.243.16.143) 56(84) bytes of data.
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=1 ttl=50 time=24.0 ms
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=2 ttl=50 time=23.1 ms
^C
--- ynov.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 23.062/23.549/24.037/0.487 ms

#Mon Pc
C:\Users\valen>ping 192.168.56.111

Envoi d’une requête 'Ping'  192.168.56.111 avec 32 octets de données :
Réponse de 192.168.56.111 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.111 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.111 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.111 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 192.168.56.111:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```

## Partie 1 : 
### Setup du serveur SSH : 
#### 1. Installation du paquet ssh : 

```bash=
#déjà installé
it4@node1:~$ sudo apt install openssh-server
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
openssh-server is already the newest version (1:8.4p1-6ubuntu2).
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
```
#### 2. Lancement du service : 

```bash=
it4@node1:~$ systemctl start sshd
==== AUTHENTICATION COMPLETE ===
```
#### 3. Etude du service ssh : 
Analyse : 
```bash=
it4@node1:~$ sudo systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2021-10-25 11:10:10 CEST; 13min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 555 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 578 (sshd)
      Tasks: 1 (limit: 2314)
     Memory: 4.0M
        CPU: 65ms
     CGroup: /system.slice/ssh.service
             └─578 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

oct. 25 11:10:10 node1.tp1.linux systemd[1]: Starting OpenBSD Secure Shell server...
oct. 25 11:10:10 node1.tp1.linux sshd[578]: Server listening on 0.0.0.0 port 22.
oct. 25 11:10:10 node1.tp1.linux sshd[578]: Server listening on :: port 22.
oct. 25 11:10:10 node1.tp1.linux systemd[1]: Started OpenBSD Secure Shell server.
oct. 25 11:11:11 node1.tp1.linux sshd[842]: Accepted password for it4 from 192.168.56.1 port 59355 ssh2
oct. 25 11:11:11 node1.tp1.linux sshd[842]: pam_unix(sshd:session): session opened for user it4 by (uid=0)
oct. 25 11:17:05 node1.tp1.linux sshd[964]: Accepted password for it4 from 192.168.56.1 port 56172 ssh2
oct. 25 11:17:05 node1.tp1.linux sshd[964]: pam_unix(sshd:session): session opened for user it4 by (uid=0)
```

```bash=
it4@node1:~$ ps -e
    PID TTY          TIME CMD
 [...]
   1032 ?        00:00:00 sshd
   [...]
   
it4@node1:~$ sudo ss -ltnap
State   Recv-Q  Send-Q    Local Address:Port   Peer Address:Port  Process
ESTAB   0       0        192.168.56.111:22     192.168.56.1:56172  users:(("sshd",pid=1032,fd=4),("sshd",pid=964,fd=4))
LISTEN  0       128                [::]:22             [::]:*      users:(("sshd",pid=578,fd=4))
it4@node1:/var/log$ journalctl -u sshd
-- Journal begins at Tue 2021-10-19 11:28:41 CEST, ends at Mon 2021-10-25 11:40:22 CEST. --
-- No entries --
```


Connexion sur mon pc en ssh : 
```bash=
C:\Users\valen>ssh it4@192.168.56.111
it4@node1:~$
```
#### 4. Modification de la configuration du serveur : 

Modification : 
```bash=
it4@node1:~$ cd /etc/ssh
it4@node1:/etc/ssh$ sudo nano sshd_config
it4@node1:/etc/ssh$ cat sshd_config
#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

Include /etc/ssh/sshd_config.d/*.conf

Port 1026
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

[...]

it4@node1:~$ sudo reboot
```


## Attention : 
#### J'ai dû changer d'ordinateur donc dans la suite du tp certaine données seront différentes, comme par exemple l'adresse de ma nouvelle machine virtuelle. Bien sûr, j'ai fait exactement la même chose sur les deux machines, j'ai entrtée les même commandes et je suis parti d'une vm similaire en tout point avec l'ancienne.

Nouvelle connexion en ssh sur le nouveau port : 
```bash=
C:\Users\Utilisateur>ssh -p 1026 it4@192.168.56.103

it4@node1:~$ sudo ss -ltnap
State   Recv-Q  Send-Q    Local Address:Port   Peer Address:Port  Process
LISTEN  0       4096      127.0.0.53%lo:53          0.0.0.0:*      users:(("systemd-resolve",pid=405,fd=14))
LISTEN  0       128           127.0.0.1:631         0.0.0.0:*      users:(("cupsd",pid=528,fd=7))
LISTEN  0       128             0.0.0.0:1026        0.0.0.0:*      users:(("sshd",pid=547,fd=3))
ESTAB   0       36       192.168.56.103:1026   192.168.56.1:53932  users:(("sshd",pid=796,fd=4),("sshd",pid=758,fd=4))
LISTEN  0       128               [::1]:631            [::]:*      users:(("cupsd",pid=528,fd=6))
LISTEN  0       128                [::]:1026           [::]:*      users:(("sshd",pid=547,fd=4))
```

## Partie 2 : 
### Setup du serveur FTP : 
#### 1. Installation du serveur : 

Installation du paquet : 
```bash=
it4@node1:~$ sudo apt-get install vsftpd
it4@node1:~$ cd /etc/
it4@node1:/etc$ ls *vsftpd*
vsftpd.conf
```
#### 2. Lancement du service FTP : 

```bash=
it4@node1:/etc$ systemctl start vsftpd
it4@node1:/etc$ systemctl status vsftpd
● vsftpd.service - vsftpd FTP server
     Loaded: loaded (/lib/systemd/system/vsftpd.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-11-03 20:27:34 CET; 3min 31s ago
     [...]
```
#### 3. Etude du service FTP : 
Analyse : 
```bash=
it4@node1:/etc$ systemctl status vsftpd
● vsftpd.service - vsftpd FTP server
     Loaded: loaded (/lib/systemd/system/vsftpd.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-11-03 20:27:34 CET; 5min ago
   Main PID: 1124 (vsftpd)
      Tasks: 1 (limit: 2314)
     Memory: 688.0K
        CPU: 2ms
     CGroup: /system.slice/vsftpd.service
             └─1124 /usr/sbin/vsftpd /etc/vsftpd.conf

nov. 03 20:27:34 node1.tp2.linux systemd[1]: Starting vsftpd FTP server...
nov. 03 20:27:34 node1.tp2.linux systemd[1]: Started vsftpd FTP server.
it4@node1:/etc$ pstree -ph 1124
vsftpd(1124)
it4@node1:/etc$ sudo ss -ltnap | grep vsftpd
LISTEN  0       32                    *:21                *:*      users:(("vsftpd",pid=1124,fd=3))
it4@node1:/var/log$ journalctl -u vsftpd
-- Journal begins at Sat 2021-10-23 22:38:20 CEST, ends at Wed 2021-11-03 20:49:57 CET. --
nov. 03 20:27:34 node1.tp2.linux systemd[1]: Starting vsftpd FTP server...
nov. 03 20:27:34 node1.tp2.linux systemd[1]: Started vsftpd FTP server.
```

Pour le client j'ai utilisé l'application FileZilla.
```bash=
it4@node1:~$ sudo cat /var/log/vsftpd.log
Thu Nov  4 16:08:04 2021 [pid 1102] [it4] OK UPLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/Test2", 15 bytes, 27.18Kbyte/sec
Thu Nov  4 16:08:17 2021 [pid 1102] [it4] OK DOWNLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/aupload", 26 bytes, 2.15Kbyte/sec
it4@node1:~$ cd Documents/
it4@node1:~/Documents$ ls
1  aupload  Test2
```
Logs :
```bash=
it4@node1:~$ cd
it4@node1:~$ sudo cat /var/log/vsftpd.log | grep DOWNLOAD
Thu Nov  4 16:08:17 2021 [pid 1102] [it4] OK DOWNLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/aupload", 26 bytes, 2.15Kbyte/sec
it4@node1:~$ sudo cat /var/log/vsftpd.log | grep UPLOAD
Thu Nov  4 16:08:04 2021 [pid 1102] [it4] OK UPLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/Test2", 15 bytes, 27.18Kbyte/sec
```
#### 4. Modification de la configuration du serveur : 
Modifications : 
```bash=
it4@node1:~$ cd /etc/
it4@node1:/etc$ sudo nano vsftpd.conf
it4@node1:/etc$ cat vsftpd.conf
[...]
# Make sure PORT transfer connections originate from port 20 (ftp-data).
connect_from_port_20=YES
listen_port=1027
[...]
it4@node1:/etc$ service vsftpd restart
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentification requise pour redémarrer « vsftpd.service ».
Authenticating as: it4,,, (it4)
Password:
==== AUTHENTICATION COMPLETE ===
it4@node1:/etc$ sudo ss -lntap | grep vsftpd
LISTEN 0      32                  *:1027            *:*     users:(("vsftpd",pid=1160,fd=3))
```

```bash=
it4@node1:~$ cd Documents/
it4@node1:~/Documents$ nano 3
it4@node1:~/Documents$ ls
1  3  aupload  Test2
```
Nouvelle connexion avec le client : 
![](https://i.imgur.com/fB4Pepd.png)
```bash=
it4@node1:~/Documents$ sudo cat /var/log/vsftpd.log | grep DOWNLOAD
Thu Nov  4 21:15:08 2021 [pid 1200] [it4] OK DOWNLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/3", 27 bytes, 56.83Kbyte/sec
it4@node1:~/Documents$ sudo cat /var/log/vsftpd.log | grep UPLOAD
Thu Nov  4 21:15:04 2021 [pid 1195] [it4] OK UPLOAD: Client "::ffff:192.168.56.1", "/home/it4/Documents/pourvmfinal", 26 bytes, 52.79Kbyte/sec
```

## Partie 3 : 
### II. Jouer avec netcat : 

#### Lien via netcat entre la vm et mon pc : 
```bash=
#Installer netcat sur la vm
it4@node1:~$ sudo apt-get install netcat
```
Cette fois-ci pour installer netcat sur windows j'ai dû faire différemment, je suis allé sur ce site https://eternallybored.org/misc/netcat/ et j'ai téléchargé la version 1.11 .
Puis j'ai extrait le fichier dans le fichier System32 via le chemin : 
```bash=
C:\>cd Windows\System32\netcat-1.11
C:\Windows\System32\netcat-1.11>
```
Et enfin pour le lancer je dois executer un fichier puis rentrer l'ip de l'hôte et le port sur lequel je peux me connecter.
```bash=
C:\Windows\System32\netcat-1.11>dir
 Répertoire de C:\Windows\System32\netcat-1.11

05/11/2021  13:00    <DIR>          .
05/11/2021  13:00    <DIR>          ..
28/12/2004  11:23            12 166 doexec.c
09/07/1996  15:01             7 283 generic.h
06/11/1996  22:40            22 784 getopt.c
03/11/1994  19:07             4 765 getopt.h
06/02/1998  15:50            61 780 hobbit.txt
27/12/2004  17:37            18 009 license.txt
26/12/2010  13:31               301 Makefile
26/12/2010  13:26            36 528 nc.exe
26/12/2010  13:31            43 696 nc64.exe
29/12/2004  13:07            69 662 netcat.c
27/12/2004  17:44             6 833 readme.txt
C:\Windows\System32\netcat-1.11>nc.exe
Cmd line: IP [:PORT]
```
Pour lancer netcat sur la vm j'ai utilisé : 
```bash=
it4@node1:~$ nc -l -p 12345
```
Puis une fois cette commande effectué sur la vm, j'ai fais sur mon pc : 

```bash=
C:\Windows\System32\netcat-1.11>nc.exe
Cmd line: 192.168.56.103 12345

```
#### Stocker les données : 
```bash=
it4@node1:~$ cd Documents/
it4@node1:~/Documents$ nano historique.txt
it4@node1:~/Documents$ nc -l -p 12345 >> historique.txt
Salut la vm
Salut le pc
```
En même temps sur mon pc : 

```bash=
C:\Windows\System32\netcat-1.11>nc.exe
Cmd line: 192.168.56.103 12345
Salut la vm
Salut le pc
```

```bash=
it4@node1:~/Documents$ cat historique.txt
Salut la vm
```
### III. Un service basé sur netcat : 
#### 1. Créer le service : 

```bash=
it4@node1:~$ cd /etc/systemd/system/
it4@node1:/etc/systemd/system$ which nc
/usr/bin/nc
it4@node1:/etc/systemd/system$ sudo nano chat_tp2.service
it4@node1:/etc/systemd/system$ sudo systemctl daemon-reload
it4@node1:/etc/systemd/system$ sudo chmod 777 chat_tp2.service
it4@node1:/etc/systemd/system$ sudo systemctl daemon-reload
```
#### 2. Test test et retest : 

```bash=
it4@node1:/etc/systemd/system$ systemctl start chat_tp2.service
it4@node1:/etc/systemd/system$ systemctl status chat_tp2
● chat_tp2.service - Little chat service (TP2)
     Loaded: loaded (/etc/systemd/system/chat_tp2.service; disabled; vendor preset: enabled)
     Active: active (running) since Sat 2021-11-06 04:14:22 CET; 14s ago
   Main PID: 3873 (nc)
      Tasks: 1 (limit: 2314)
     Memory: 208.0K
        CPU: 817us
     CGroup: /system.slice/chat_tp2.service
             └─3873 /usr/bin/nc -l -p 12345

nov. 06 04:14:22 node1.tp2.linux systemd[1]: Started Little chat service (TP2).
it4@node1:/etc/systemd/system$ sudo ss -lntap | grep nc
LISTEN 0      1             0.0.0.0:12345      0.0.0.0:*     users:(("nc",pid=3978,fd=3))
it4@node1:/etc/systemd/system$ journalctl -xe -u chat_tp2

-- Journal begins at Sat 2021-10-23 22:38:20 CEST, ends at Sat 2021-11-06 04:14:54 CET. --
nov. 06 04:14:22 node1.tp2.linux systemd[1]: Started Little chat service (TP2).
░░ Subject: L'unité (unit) chat_tp2.service a terminé son démarrage
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ L'unité (unit) chat_tp2.service a terminé son démarrage, avec le résultat done.
```
Puis sur mon pc (et en même temps sur la vm voir la note suivante): 

```bash=
#1
C:\Windows\System32\netcat-1.11>nc.exe
Cmd line: 192.168.56.103 12345
Et c est la fin du tp
bon en vrai il etait vraiment cool
il m as et je suppose aussi aux autres enormement appris
appris je sais que j ai traine de fou pour le faire mais bon
en même temps ces vacances n etait pas de tout repos j ai eu pas mal de truc de sante a prevoir
bref
salut
^C
C:\Windows\System32\netcat-1.11>
```

```bash=
#2
it4@node1:/etc/systemd/system$ journalctl -xe -u chat_tp2 -f
-- Journal begins at Sat 2021-10-23 22:38:20 CEST. --
nov. 06 04:14:22 node1.tp2.linux systemd[1]: Started Little chat service (TP2).
░░ Subject: L'unité (unit) chat_tp2.service a terminé son démarrage
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ L'unité (unit) chat_tp2.service a terminé son démarrage, avec le résultat done.
nov. 06 04:17:13 node1.tp2.linux systemd[1]: chat_tp2.service: Deactivated successfully.
░░ Subject: Unit succeeded
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ The unit chat_tp2.service has successfully entered the 'dead' state.
nov. 06 04:22:36 node1.tp2.linux systemd[1]: Started Little chat service (TP2).
░░ Subject: L'unité (unit) chat_tp2.service a terminé son démarrage
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ L'unité (unit) chat_tp2.service a terminé son démarrage, avec le résultat done.
nov. 06 04:26:44 node1.tp2.linux nc[3978]: Et c est la fin du tp
nov. 06 04:26:56 node1.tp2.linux nc[3978]: bon en vrai il etait vraiment cool
nov. 06 04:27:21 node1.tp2.linux nc[3978]: il m as et je suppose aussi aux autres enormement appris
nov. 06 04:27:39 node1.tp2.linux nc[3978]: appris je sais que j ai traine de fou pour le faire mais bon
nov. 06 04:28:14 node1.tp2.linux nc[3978]: [95B blob data]
nov. 06 04:28:30 node1.tp2.linux nc[3978]: bref
nov. 06 04:28:34 node1.tp2.linux nc[3978]: salut
nov. 06 04:28:37 node1.tp2.linux systemd[1]: chat_tp2.service: Deactivated successfully.
░░ Subject: Unit succeeded
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ The unit chat_tp2.service has successfully entered the 'dead' state.
```