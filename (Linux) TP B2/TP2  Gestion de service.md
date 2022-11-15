# TP2 : Gestion de service

# I. Un premier serveur web

## 1. Installation

🌞 **Installer le serveur Apache**
```bash
[ersjyhag@web ~]$ sudo dnf install -y httpd
Last metadata expiration check: 0:28:49 ago on Tue 15 Nov 2022 11:15:46 AM CET.
Dependencies resolved.
========================================================================================================================
 Package                          Architecture          Version                          Repository                Size
========================================================================================================================
Installing:
 httpd                            x86_64                2.4.51-7.el9_0                   appstream                1.4 M
[...]
Complete!
[ersjyhag@web ~]$ sudo vim /etc/httpd/conf/httpd.conf
[ersjyhag@web ~]$ cat /etc/httpd/conf/httpd.conf | grep '#'
```

🌞 **Démarrer le service Apache**

```bash
[ersjyhag@web ~]$ sudo systemctl start httpd.service
[ersjyhag@web ~]$ systemctl status httpd.service
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
     Active: active (running) since Tue 2022-11-15 11:59:30 CET; 20s ago
       Docs: man:httpd.service(8)
   Main PID: 1190 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 213 (limit: 5905)
     Memory: 25.1M
        CPU: 1.695s
     CGroup: /system.slice/httpd.service
             ├─1190 /usr/sbin/httpd -DFOREGROUND
             ├─1191 /usr/sbin/httpd -DFOREGROUND
             ├─1192 /usr/sbin/httpd -DFOREGROUND
             ├─1244 /usr/sbin/httpd -DFOREGROUND
             └─1245 /usr/sbin/httpd -DFOREGROUND

Nov 15 11:59:28 web.tp2.linux systemd[1]: Starting The Apache HTTP Server...
Nov 15 11:59:30 web.tp2.linux systemd[1]: Started The Apache HTTP Server.
Nov 15 11:59:30 web.tp2.linux httpd[1190]: Server configured, listening on: port 80
[ersjyhag@web ~]$ sudo systemctl enable httpd.service
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
[ersjyhag@web ~]$ sudo firewall-cmd --add-port 80/tcp
success
#Je suis allé voir dans la conf pour savoir le port a ouvrir
[ersjyhag@web ~]$ ss -al | grep httpd
u_str LISTEN 0      100                   /etc/httpd/run/cgisock.1485 22185                         * 0
```

🌞 **TEST**

```bash
[ersjyhag@web ~]$ systemctl status httpd.service
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Tue 2022-11-15 12:16:43 CET; 1min 5s ago
       Docs: man:httpd.service(8)
   Main PID: 1485 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 213 (limit: 5905)
     Memory: 24.7M
        CPU: 792ms
     CGroup: /system.slice/httpd.service
             ├─1485 /usr/sbin/httpd -DFOREGROUND
             ├─1486 /usr/sbin/httpd -DFOREGROUND
             ├─1487 /usr/sbin/httpd -DFOREGROUND
             ├─1488 /usr/sbin/httpd -DFOREGROUND
             └─1489 /usr/sbin/httpd -DFOREGROUND

Nov 15 12:16:43 web.tp2.linux systemd[1]: Starting The Apache HTTP Server...
Nov 15 12:16:43 web.tp2.linux systemd[1]: Started The Apache HTTP Server.
Nov 15 12:16:43 web.tp2.linux httpd[1485]: Server configured, listening on: port 80
```
Comme on peut le voir à la ligne 3 du dernier morceau de code le service est enable donc il va se lancer au démarrage de la VM.

```bash
[ersjyhag@web ~]$ curl localhost
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
        height: 100%;
        width: 100%;
      }
[...]
</html>
```

Sur Mon Pc :

```bash
valen@LAPTOP-ACKKC5UV MINGW64 ~
$ curl 10.102.1.11
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
[...]
</html>
```

## 2. Avancer vers la maîtrise du service

🌞 **Le service Apache...**

```bash
[ersjyhag@web ~]$ cat /etc/httpd/conf/httpd.conf | grep DirectoryIndex
    DirectoryIndex index.html
```

🌞 **Déterminer sous quel utilisateur tourne le processus Apache**

```bash
[ersjyhag@web ~]$ cat /etc/httpd/conf/httpd.conf | grep "User "
User apache
[ersjyhag@web ~]$ ps -ef | grep httpd
root        1485       1  0 12:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1486    1485  0 12:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1487    1485  0 12:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1488    1485  0 12:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1489    1485  0 12:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
ersjyhag    1754     831  0 12:31 pts/0    00:00:00 grep --color=auto httpd
[ersjyhag@web ~]$ ls -al /usr/share/testpage/
total 12
drwxr-xr-x.  2 root root   24 Nov 15 11:44 .
drwxr-xr-x. 82 root root 4096 Nov 15 11:44 ..
-rw-r--r--.  1 root root 7620 Jul  6 04:37 index.html
# Les trois fichiers ont donc minimum la permission r (read) pour tout le monde
```

🌞 **Changer l'utilisateur utilisé par Apache**

```bash
[ersjyhag@web ~]$ cat /etc/passwd | grep Apache
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
[ersjyhag@web ~]$ sudo useradd NewApache --home /usr/share/httpd --shell /sbin/nologin
useradd: warning: the home directory /usr/share/httpd already exists.
useradd: Not copying any file from skel directory into it.
[ersjyhag@web ~]$ cat /etc/passwd | grep NewApache
NewApache:x:1001:1001::/usr/share/httpd:/sbin/nologin
[ersjyhag@web ~]$ sudo nano /etc/httpd/conf/httpd.conf
[ersjyhag@web ~]$ cat /etc/httpd/conf/httpd.conf | grep "User "
User NewApache
[ersjyhag@web ~]$ sudo systemctl restart httpd.service
[ersjyhag@web ~]$ ps -ef | grep httpd
root        1799       1  7 12:44 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
NewApac+    1800    1799  0 12:44 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
NewApac+    1801    1799  0 12:44 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
NewApac+    1802    1799  0 12:44 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
NewApac+    1803    1799  0 12:44 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
ersjyhag    2016     831  0 12:45 pts/0    00:00:00 grep --color=auto httpd
```