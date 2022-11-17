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

🌞 **Faites en sorte que Apache tourne sur un autre port**

```bash
[ersjyhag@web ~]$ sudo nano /etc/httpd/conf/httpd.conf
[ersjyhag@web ~]$ cat /etc/httpd/conf/httpd.conf | grep Listen
Listen 99
[ersjyhag@web ~]$ sudo firewall-cmd --add-port 99/tcp
success
[ersjyhag@web ~]$ sudo firewall-cmd --remove-port 80/tcp
success
[ersjyhag@web ~]$ sudo firewall-cmd --list-port
99/tcp
[ersjyhag@web ~]$ sudo ss -altpn | grep httpd
LISTEN 0      511                *:99              *:*    users:(("httpd",pid=2061,fd=4),("httpd",pid=2060,fd=4),("httpd",pid=2059,fd=4),("httpd",pid=2057,fd=4))
[ersjyhag@web ~]$ curl localhost:99
<!doctype html>
<html>
[...]
</html>
```

```bash
valen@LAPTOP-ACKKC5UV MINGW64 ~
$ curl 10.102.1.11:99
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
[...]
</html>
```

[`/etc/httpd/conf/httpd.conf`](https://github.com/ValentinBonomo/tp-linux/blob/main/(Linux)%20TP%20B2/TP2/file/etc/httpd/conf/httpd.conf)

# II. Une stack web plus avancée

## 2. Setup

🌞 **Install de MariaDB sur `db.tp2.linux`**

```bash
[ersjyhag@db ~]$ sudo dnf install mariadb-server -yq
uavc:  op=setenforce lsm=selinux enforcing=0 res=1uavc:  op=load_policy lsm=selinux seqno=2 res=1
[ersjyhag@db ~]$ sudo systemctl enable mariadb
Created symlink /etc/systemd/system/mysql.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/mysqld.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/multi-user.target.wants/mariadb.service → /usr/lib/systemd/system/mariadb.service.
[ersjyhag@db ~]$ sudo systemctl start mariadb


[ersjyhag@db ~]$ sudo mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!
[...]
Switch to unix_socket authentication [Y/n] y
Enabled successfully!
Reloading privilege tables..
 ... Success!
[...]
Change the root password? [Y/n] n
 ... skipping.
[...]
Remove anonymous users? [Y/n] y
 ... Success!
[...]
Disallow root login remotely? [Y/n]
 ... Success!
 [...]

Remove test database and access to it? [Y/n]
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!
[...]
Reload privilege tables now? [Y/n]
 ... Success!

Cleaning up...
Thanks for using MariaDB!
[ersjyhag@db ~]$ sudo ss -altpn | grep maria
LISTEN 0      80                 *:3306            *:*    users:(("mariadbd",pid=3099,fd=19))
```

🌞 **Préparation de la base pour NextCloud**

```bash
[ersjyhag@db ~]$ sudo mysql -u root -p
[sudo] password for ersjyhag:
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 22
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'nextcloud'@'10.102.1.11' IDENTIFIED BY 'pewpewpew';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'10.102.1.11';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)
```

🌞 **Exploration de la base de données**

```bash
[ersjyhag@web ~]$ mysql -u nextcloud -h 10.102.1.12 -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 24
Server version: 5.5.5-10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| nextcloud          |
+--------------------+
2 rows in set (0.01 sec)

mysql> USE nextcloud;
Database changed
mysql> SHOW TABLES;
Empty set (0.00 sec)

```

🌞 **Trouver une commande SQL qui permet de lister tous les utilisateurs de la base de données**

```bash
MariaDB [(none)]> CREATE USER 'root'@'10.102.1.11' IDENTIFIED BY '';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON root.* TO 'root'@'10.102.1.11';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> SELECT user,host FROM mysql.user;
+-------------+-------------+
| User        | Host        |
+-------------+-------------+
| nextcloud   | 10.102.1.11 |
| root        | 10.102.1.11 |
| mariadb.sys | localhost   |
| mysql       | localhost   |
| root        | localhost   |
+-------------+-------------+
5 rows in set (0.000 sec)
#J'ai add un user root pour le web au cas ou j'ai besoin de me co en root sur l'autre machine
```

### B. Serveur Web et NextCloud

🌞 **Install de PHP**

```bash
[ersjyhag@web ~]$ sudo dnf config-manager --set-enabled crb
[ersjyhag@web ~]$ sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
Rocky Linux 9 - BaseOS                                                                  9.9 kB/s | 3.6 kB     00:00
[...]
Complete!
[ersjyhag@web ~]$ dnf module list php
[...]
Remis Modular repository for Enterprise Linux 9 - x86_64
Name                Stream                 Profiles                                 Summary
php                 remi-7.4               common [d], devel, minimal               PHP scripting language
php                 remi-8.0               common [d], devel, minimal               PHP scripting language
php                 remi-8.1               common [d], devel, minimal               PHP scripting language
php                 remi-8.2               common [d], devel, minimal               PHP scripting language

[ersjyhag@web ~]$ sudo dnf module enable php:remi-8.1 -y
Extra Packages for Enterprise Linux 9 - x86_64                                          8.3 MB/s |  11 MB     00:01
[...]
Complete!
[ersjyhag@web ~]$ sudo dnf install -y php81-php
Last metadata expiration check: 0:00:40 ago on Thu 17 Nov 2022 11:18:53 AM CET.
[...]
Complete!
```

🌞 **Install de tous les modules PHP nécessaires pour NextCloud**

```bash
[ersjyhag@web ~]$ sudo dnf install -y libxml2 openssl php81-php php81-php-ctype php81-php-curl php81-php-gd php81-php-iconv php81-php-json php81-php-libxml php81-php-mbstring php81-php-openssl php81-php-posix php81-php-session php81-php-xml php81-php-zip php81-php-zlib php81-php-pdo php81-php-mysqlnd php81-php-intl php81-php-bcmath php81-php-gmp
Last metadata expiration check: 0:02:19 ago on Thu 17 Nov 2022 11:18:53 AM CET.
[...]
Complete!
```

🌞 **Récupérer NextCloud**

```bash
[ersjyhag@web ~]$ sudo mkdir /var/www/tp2_nextcloud/
[ersjyhag@web ~]$ sudo curl https://download.nextcloud.com/server/prereleases/nextcloud-25.0.0rc3.zip -o nextcloud.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  168M  100  168M    0     0  12.7M      0  0:00:13  0:00:13 --:--:-- 6572k
[ersjyhag@web ~]$ ls
ftp_folder  nextcloud.zip
[ersjyhag@web ~]$ sudo dnf -y install unzip
Last metadata expiration check: 0:08:57 ago on Thu 17 Nov 2022 11:18:53 AM CET.
Dependencies resolved.
[...]
Complete!
[ersjyhag@web ~]$ sudo unzip nextcloud.zip -d /var/www/tp2_nextcloud/
[...]
  inflating: /var/www/tp2_nextcloud/nextcloud/config/config.sample.php
  inflating: /var/www/tp2_nextcloud/nextcloud/config/.htaccess
#Vérif
[ersjyhag@web ~]$ ls /var/www/tp2_nextcloud/
nextcloud
[ersjyhag@web ~]$ ls /var/www/tp2_nextcloud/nextcloud/
3rdparty  config       core      index.html  occ           ocs-provider  resources   themes
apps      console.php  cron.php  index.php   ocm-provider  public.php    robots.txt  updater
AUTHORS   COPYING      dist      lib         ocs           remote.php    status.php  version.php
[ersjyhag@web ~]$ ls -al /var/www/tp2_nextcloud/
total 4
drwxr-xr-x.  3 root root   23 Nov 17 11:29 .
drwxr-xr-x.  5 root root   54 Nov 17 11:23 ..
drwxr-xr-x. 14 root root 4096 Oct  6 14:47 nextcloud
```

🌞 **Adapter la configuration d'Apache**

```bash
[ersjyhag@web ~]$ cd /etc/httpd/conf/
[ersjyhag@web conf]$ sudo nano httpdannexe.conf
[ersjyhag@web conf]$ cat httpdannexe.conf
<VirtualHost *:80>
[...]
</VirtualHost>
````

🌞 **Redémarrer le service Apache** pour qu'il prenne en compte le nouveau fichier de conf

```bash
[ersjyhag@web conf]$ sudo systemctl restart httpd.service
```

### C. Finaliser l'installation de NextCloud

Je rattrappe d'abord ma bêtise :
```bash
[ersjyhag@web httpd]$ sudo mv /etc/httpd/conf/httpdannexe.conf /etc/httpd/conf.d/
```

🌞 **Exploration de la base de données**

```bash
[ersjyhag@web httpd]$ mysql -u ersjyhag -h 10.102.1.12 -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 161
Server version: 5.5.5-10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql> SHOW TABLES;
+-----------------------------+
| Tables_in_nextcloud         |
+-----------------------------+
| oc_accounts                 |
| oc_accounts_data            |
| oc_activity                 |
| oc_activity_mq              |
| oc_addressbookchanges       |
| oc_addressbooks             |
| oc_appconfig                |
| oc_authorized_groups        |
| oc_authtoken                |
| oc_bruteforce_attempts      |
| oc_calendar_invitations     |
| oc_calendar_reminders       |
| oc_calendar_resources       |
| oc_calendar_resources_md    |
| oc_calendar_rooms           |
| oc_calendar_rooms_md        |
| oc_calendarchanges          |
| oc_calendarobjects          |
| oc_calendarobjects_props    |
| oc_calendars                |
| oc_calendarsubscriptions    |
| oc_cards                    |
| oc_cards_properties         |
| oc_circles_circle           |
| oc_circles_event            |
| oc_circles_member           |
| oc_circles_membership       |
| oc_circles_mount            |
| oc_circles_mountpoint       |
| oc_circles_remote           |
| oc_circles_share_lock       |
| oc_circles_token            |
| oc_collres_accesscache      |
| oc_collres_collections      |
| oc_collres_resources        |
| oc_comments                 |
| oc_comments_read_markers    |
| oc_dav_cal_proxy            |
| oc_dav_shares               |
| oc_direct_edit              |
| oc_directlink               |
| oc_federated_reshares       |
| oc_file_locks               |
| oc_file_metadata            |
| oc_filecache                |
| oc_filecache_extended       |
| oc_files_trash              |
| oc_flow_checks              |
| oc_flow_operations          |
| oc_flow_operations_scope    |
| oc_group_admin              |
| oc_group_user               |
| oc_groups                   |
| oc_jobs                     |
| oc_known_users              |
| oc_login_flow_v2            |
| oc_migrations               |
| oc_mimetypes                |
| oc_mounts                   |
| oc_notifications            |
| oc_notifications_pushhash   |
| oc_notifications_settings   |
| oc_oauth2_access_tokens     |
| oc_oauth2_clients           |
| oc_photos_albums            |
| oc_photos_albums_files      |
| oc_photos_collaborators     |
| oc_preferences              |
| oc_privacy_admins           |
| oc_profile_config           |
| oc_properties               |
| oc_ratelimit_entries        |
| oc_reactions                |
| oc_recent_contact           |
| oc_schedulingobjects        |
| oc_share                    |
| oc_share_external           |
| oc_storages                 |
| oc_storages_credentials     |
| oc_systemtag                |
| oc_systemtag_group          |
| oc_systemtag_object_mapping |
| oc_text_documents           |
| oc_text_sessions            |
| oc_text_steps               |
| oc_trusted_servers          |
| oc_twofactor_backupcodes    |
| oc_twofactor_providers      |
| oc_user_status              |
| oc_user_transfer_owner      |
| oc_users                    |
| oc_vcategory                |
| oc_vcategory_to_object      |
| oc_webauthn                 |
| oc_whats_new                |
+-----------------------------+
95 rows in set (0.000 sec)
```
Donc 95 entrées ont été crée.
