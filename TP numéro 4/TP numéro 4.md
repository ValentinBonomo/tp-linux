# TP4 : Une distribution orientée serveur

## I. Install de Rocky Linux : 

Réalisé lors du cours d'introduction au tp 4.

## II. Checklist : 

### Choisissez et définissez une IP à la VM : 

```bash=
[root@localhost eulamawaifu] cd /etc/sysconfig/network-scripts/
[root@localhost network-scripts] nano ifcfg-enp0s8
[root@localhost network-scripts] cat ifcfg-enp0s8
TYPE=Ethernet
BOOTPROTO=static
NAME=enp0s8
DEVICE=enp0s8
ONBOOT=yes
IPADDR=10.200.1.31
NETMASK=255.255.255.0
[root@localhost network-scripts] ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:4f:d3:15 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 86243sec preferred_lft 86243sec
    inet6 fe80::a00:27ff:fe4f:d315/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:64:3a:96 brd ff:ff:ff:ff:ff:ff
    inet 10.200.1.31/24 brd 10.200.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe64:3a96/64 scope link
       valid_lft forever preferred_lft forever
```

```bash=
[root@localhost network-scripts] systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-11-23 11:33:29 CET; 3min 59s ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 861 (sshd)
    Tasks: 1 (limit: 4946)
   Memory: 6.1M
   CGroup: /system.slice/sshd.service
           └─861 /usr/sbin/sshd -D -oCiphers=aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes256-cbc,aes128-gcm@openssh.com,aes128-ctr,aes128-cbc -oMACs=hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-128>

Nov 23 11:33:29 localhost.localdomain systemd[1]: Starting OpenSSH server daemon...
Nov 23 11:33:29 localhost.localdomain sshd[861]: Server listening on 0.0.0.0 port 22.
Nov 23 11:33:29 localhost.localdomain sshd[861]: Server listening on :: port 22.
Nov 23 11:33:29 localhost.localdomain systemd[1]: Started OpenSSH server daemon.
Nov 23 11:34:06 localhost.localdomain sshd[1444]: Accepted password for eulamawaifu from 10.200.1.1 port 57777 ssh2
Nov 23 11:34:06 localhost.localdomain sshd[1444]: pam_unix(sshd:session): session opened for user eulamawaifu by (uid=0)
```

Echange clés ssh : 

```bash=
# Server
[eulamawaifu@localhost ~]$ cat /home/eulamawaifu/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6yDDwLDtpWX6AwMFzGrMUMbyIYwK1LFuTll/ZEp2Zz/b8A/rQLJFpTVGAD8rFlk9dtbeUYol4gzlsf8jqTsdeXZYvIHfTKkPyJ20lzV1cM2wzP+BD6ZErQXQVKJkX9ScGopDBvymiYEB/EANmOa9iXFktSxyMugtUiOXIMkktd1PkOzQscOk5eWZfS53cqe5FhwlTnyyJA64Iubo8GoA7I5QDEL/m4+0Vq3bda1xQdunj7ZWyLfZyn5B72UZ7SGpBbK4AyC1/M4aHMc4xxuYehpfh+Tl5k6zVKJF+Xt0+xqZd7uAYJsZgeI1Hei9e1UtyX0NxHitInSy/lWTasgqP0gnBOxQxfs/bv3Qght7ScQe/8u6czW7+p9Eat/tjmm7rq6kBt4W33zQjIxo3AqLWRuq14YRvqkgtaJhSKm4Q4APV/yuR4g7pHXorDmKD1jrnptxmiUssRMb3IexTiV8SZvqO1Gf1bboWUggITkcYDnjI/31+3Nv1q3ypHWWrPmEBu/8ihd+q95frI5y84QWg61VAgCVMj4E58cVGHGugLPUHaBXke6ODi5cq5XowNyU56amLYCgD4Y3tsrTSQeCat3/CcumPiNP3NBiy1F+RHICCqEy04zj8WNGQvZd7C/G5xOcNRqjGd/4wrhNu8jFZYWjQDfUrktApwsWEWnNC1Q== valen@LAPTOP-ACKKC5UV
```

```bash=
#Mon PC
C:\Users\valen\.ssh> type id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
```

```bash=
[root@localhost eulamawaifu] ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=113 time=24.1 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=113 time=25.0 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=113 time=26.9 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=113 time=26.2 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=113 time=24.6 ms
^C
--- 8.8.8.8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms
rtt min/avg/max/mdev = 24.100/25.379/26.947/1.045 ms
```

```bash=
[root@localhost eulamawaifu] hostname node1.tp4.linux
[root@localhost eulamawaifu] nano /etc/hostname
[root@localhost eulamawaifu] cat /etc/hostname
node1.tp4.linux
[root@localhost eulamawaifu] hostname
node1.tp4.linux
```

## III. Mettre en place un service : 

### 2. Install : 

```bash=
[root@localhost eulamawaifu] dnf install nginx
Last metadata expiration check: 1:01:06 ago on Tue 23 Nov 2021 11:01:08 AM CET.
Dependencies resolved.
========================================================================================================================
 Package                            Architecture  Version                                        Repository        Size
========================================================================================================================
Installing:
 nginx                              x86_64        1:1.14.1-9.module+el8.4.0+542+81547229         appstream        566 k
[...]
Complete!
[root@localhost eulamawaifu] systemctl start nginx
[root@localhost eulamawaifu] systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-23 12:02:33 CET; 5s ago
  Process: 4277 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 4276 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 4274 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 4279 (nginx)
    Tasks: 2 (limit: 4946)
   Memory: 6.7M
   CGroup: /system.slice/nginx.service
           ├─4279 nginx: master process /usr/sbin/nginx
           └─4280 nginx: worker process

Nov 23 12:02:33 node1.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 23 12:02:33 node1.tp4.linux nginx[4276]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 23 12:02:33 node1.tp4.linux nginx[4276]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 23 12:02:33 node1.tp4.linux systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argume>
Nov 23 12:02:33 node1.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
[root@localhost eulamawaifu] systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
```
### 3. Analyse : 

```bash=
[root@localhost eulamawaifu] ps -ef | grep nginx
root        4279       1  0 12:02 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       4280    4279  0 12:02 ?        00:00:00 nginx: worker process
root        4316    1676  0 12:08 pts/0    00:00:00 grep --color=auto nginx
[root@localhost eulamawaifu] ss -lntap | grep nginx
LISTEN 0      128          0.0.0.0:80        0.0.0.0:*     users:(("nginx",pid=4280,fd=8),("nginx",pid=4279,fd=8))
LISTEN 0      128             [::]:80           [::]:*     users:(("nginx",pid=4280,fd=9),("nginx",pid=4279,fd=9))
#Donc nginx utilise le port 80
[root@node1 nginx] cat nginx.conf | grep root
        root         /usr/share/nginx/html;
[root@node1 nginx] cd /usr/share/nginx/html/
[root@node1 html] ls
404.html  50x.html  index.html  nginx-logo.png  poweredby.png
[root@node1 html] ls -l
total 20
-rw-r--r--. 1 root root 3332 Jun 10 11:09 404.html
-rw-r--r--. 1 root root 3404 Jun 10 11:09 50x.html
-rw-r--r--. 1 root root 3429 Jun 10 11:09 index.html
-rw-r--r--. 1 root root  368 Jun 10 11:09 nginx-logo.png
-rw-r--r--. 1 root root 1800 Jun 10 11:09 poweredby.png
```
### 4. Visite du service web : 

```bash=
[root@node1 html] firewall-cmd --add-port=80/tcp --permanent
success
[root@node1 html] firewall-cmd --reload
success
[root@node1 html] firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8
  sources:
  services: cockpit dhcpv6-client ssh
  ports: 80/tcp
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

```bash=
[root@node1 html] curl http://10.200.1.31
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
[...]
[root@node1 nginx] nano nginx.conf
[root@node1 nginx] cat nginx.conf | grep 8080
        listen       8080 default_server;
        listen       [::]:8080 default_server;
[root@node1 nginx] sudo systemctl restart nginx
[root@node1 nginx] systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-23 12:52:47 CET; 9s ago
  Process: 4636 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 4633 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 4631 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 4638 (nginx)
    Tasks: 2 (limit: 4946)
   Memory: 3.7M
   CGroup: /system.slice/nginx.service
           ├─4638 nginx: master process /usr/sbin/nginx
           └─4639 nginx: worker process

Nov 23 12:52:47 node1.tp4.linux systemd[1]: nginx.service: Succeeded.
Nov 23 12:52:47 node1.tp4.linux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Nov 23 12:52:47 node1.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 23 12:52:47 node1.tp4.linux nginx[4633]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 23 12:52:47 node1.tp4.linux nginx[4633]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 23 12:52:47 node1.tp4.linux systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argum>
Nov 23 12:52:47 node1.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
[root@node1 nginx] ss -lntap | grep nginx
LISTEN 0      128          0.0.0.0:8080      0.0.0.0:*     users:(("nginx",pid=4639,fd=8),("nginx",pid=4638,fd=8))
LISTEN 0      128             [::]:8080         [::]:*     users:(("nginx",pid=4639,fd=9),("nginx",pid=4638,fd=9))
[root@node1 nginx] sudo firewall-cmd --remove-port=80/tcp --permanent
success
[root@node1 nginx] sudo firewall-cmd --add-port=8080/tcp --permanent
success
[root@node1 nginx] curl http://10.200.1.31:8080
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
[root@node1 nginx] useradd web -m -p dbc
[root@node1 nginx] ls /home/
eulamawaifu  web
```

```bash=
[root@node1 nginx] nano nginx.conf
[root@node1 nginx] cat nginx.conf | grep web
user web;
[root@node1 nginx] systemctl restart nginx.service
[root@node1 nginx] systemctl status nginx.service
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-23 13:07:39 CET; 7s ago
  Process: 4850 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 4847 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 4845 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 4852 (nginx)
    Tasks: 2 (limit: 4946)
   Memory: 3.6M
   CGroup: /system.slice/nginx.service
           ├─4852 nginx: master process /usr/sbin/nginx
           └─4853 nginx: worker process

Nov 23 13:07:39 node1.tp4.linux systemd[1]: nginx.service: Succeeded.
Nov 23 13:07:39 node1.tp4.linux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Nov 23 13:07:39 node1.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 23 13:07:39 node1.tp4.linux nginx[4847]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 23 13:07:39 node1.tp4.linux nginx[4847]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 23 13:07:39 node1.tp4.linux systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argum>
Nov 23 13:07:39 node1.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
[root@node1 nginx] ps -ef | grep nginx
root        4852       1  0 13:07 ?        00:00:00 nginx: master process /usr/sbin/nginx
web         4853    4852  0 13:07 ?        00:00:00 nginx: worker process
root        4865    4405  0 13:08 pts/0    00:00:00 grep --color=auto nginx
```

```bash=
[root@node1 nginx] cd /var/
[root@node1 var] mkdir www
[root@node1 var] cd www/
[root@node1 www] mkdir super_site_web
[root@node1 www] cd super_site_web/
[root@node1 super_site_web] nano index.html
[root@node1 super_site_web] cat index.html
<h1>toto</h1>
[root@node1 super_site_web] chown web:web index.html
[root@node1 super_site_web] ls -l
total 4
-rw-r--r--. 1 web web 14 Nov 23 13:10 index.html
[root@node1 nginx] nano nginx.conf
[root@node1 nginx] cat nginx.conf | grep super_site_web
        root         /var/www/super_site_web/;
        include /var/www/super_site_web/default.d/*.conf;
            location = /var/www/super_site_web/40x.html {
            location = /var/www/super_site_web/50x.html {
[root@node1 nginx] systemctl restart nginx.service
[root@node1 nginx] systemctl status nginx.service
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-23 13:12:51 CET; 7s ago
  Process: 4924 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 4922 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 4920 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 4926 (nginx)
    Tasks: 2 (limit: 4946)
   Memory: 3.7M
   CGroup: /system.slice/nginx.service
           ├─4926 nginx: master process /usr/sbin/nginx
           └─4927 nginx: worker process

Nov 23 13:12:51 node1.tp4.linux systemd[1]: nginx.service: Succeeded.
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 23 13:12:51 node1.tp4.linux nginx[4922]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 23 13:12:51 node1.tp4.linux nginx[4922]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 23 13:12:51 node1.tp4.linux systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argum>
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
...skipping...
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-23 13:12:51 CET; 7s ago
  Process: 4924 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 4922 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 4920 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 4926 (nginx)
    Tasks: 2 (limit: 4946)
   Memory: 3.7M
   CGroup: /system.slice/nginx.service
           ├─4926 nginx: master process /usr/sbin/nginx
           └─4927 nginx: worker process

Nov 23 13:12:51 node1.tp4.linux systemd[1]: nginx.service: Succeeded.
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 23 13:12:51 node1.tp4.linux nginx[4922]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 23 13:12:51 node1.tp4.linux nginx[4922]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 23 13:12:51 node1.tp4.linux systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argum>
Nov 23 13:12:51 node1.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
[root@node1 nginx] curl http://10.200.1.31:8080
<h1>toto</h1>
```