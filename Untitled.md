```bash
it4@node1:~$ sudo hostname node1.tp2.linux
```

```bash=
it4@node1:~$ sudo nano /etc/hostname
it4@node1:~$ cat /etc/hostname
node1.tp1.linux

it4@node1:~$ reboot

it4@node1:~$ hostname
node1.tp1.linux
```
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

```bash=
#déjà installé
it4@node1:~$ sudo apt install openssh-server
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
openssh-server is already the newest version (1:8.4p1-6ubuntu2).
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
```

```bash=
it4@node1:~$ systemctl start sshd
==== AUTHENTICATION COMPLETE ===
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

```bash=
C:\Users\valen>ssh it4@192.168.56.111
it4@node1:~$
```
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

#Port 1026
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

#PubkeyAuthentication yes

# Expect .ssh/authorized_keys2 to be disregarded by default in future.
#AuthorizedKeysFile     .ssh/authorized_keys .ssh/authorized_keys2

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
UsePAM yes

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes
PrintMotd no
#PrintLastLog yes
#TCPKeepAlive yes
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem       sftp    /usr/lib/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#       X11Forwarding no
#       AllowTcpForwarding no
#       PermitTTY no
#       ForceCommand cvs server

it4@node1:~$ sudo ss -ltnap
LISTEN  0       128             0.0.0.0:22          0.0.0.0:*      users:(("sshd",pid=576,fd=3))
ESTAB   0       36       192.168.56.111:22     192.168.56.1:64435  users:(("sshd",pid=935,fd=4),("sshd",pid=845,fd=4))
LISTEN  0       128                [::]:22             [::]:*      users:(("sshd",pid=576,fd=4))
```

