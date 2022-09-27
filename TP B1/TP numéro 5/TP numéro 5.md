# TP5 : P'tit cloud perso

## I. Setup DB : 

### Installer MariaDB sur la machine db.tp5.linux : 

```bash=
[eulamawaifu@db ~]$ sudo dnf install mariadb-server
Rocky Linux 8 - AppStream                                                                12 kB/s | 4.8 kB     00:00
Rocky Linux 8 - AppStream                                                               4.2 MB/s | 8.2 MB     00:01
Rocky Linux 8 - BaseOS                                                                   12 kB/s | 4.3 kB     00:00
Rocky Linux 8 - BaseOS                                                                  3.7 MB/s | 3.5 MB     00:00
Rocky Linux 8 - Extras                                                                  9.5 kB/s | 3.5 kB     00:00
Rocky Linux 8 - Extras                                                                   17 kB/s |  10 kB     00:00
Dependencies resolved.
========================================================================================================================
 Package                           Architecture  Version                                         Repository        Size
========================================================================================================================
Installing:
 mariadb-server                    x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream         16 M
Installing dependencies:
 mariadb                           x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream        6.0 M
 mariadb-common                    x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream         62 k
 mariadb-connector-c               x86_64        3.1.11-2.el8_3                                  appstream        199 k
 mariadb-connector-c-config        noarch        3.1.11-2.el8_3                                  appstream         14 k
 mariadb-errmsg                    x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream        233 k
 perl-Carp                         noarch        1.42-396.el8                                    baseos            29 k
 perl-DBD-MySQL                    x86_64        4.046-3.module+el8.4.0+577+b8fe2d92             appstream        155 k
 perl-DBI                          x86_64        1.641-3.module+el8.4.0+509+59a8d9b3             appstream        739 k
 perl-Data-Dumper                  x86_64        2.167-399.el8                                   baseos            57 k
 perl-Digest                       noarch        1.17-395.el8                                    appstream         26 k
 perl-Digest-MD5                   x86_64        2.55-396.el8                                    appstream         36 k
 perl-Encode                       x86_64        4:2.97-3.el8                                    baseos           1.5 M
 perl-Errno                        x86_64        1.28-420.el8                                    baseos            75 k
 perl-Exporter                     noarch        5.72-396.el8                                    baseos            33 k
 perl-File-Path                    noarch        2.15-2.el8                                      baseos            37 k
 perl-File-Temp                    noarch        0.230.600-1.el8                                 baseos            62 k
 perl-Getopt-Long                  noarch        1:2.50-4.el8                                    baseos            62 k
 perl-HTTP-Tiny                    noarch        0.074-1.el8                                     baseos            57 k
 perl-IO                           x86_64        1.38-420.el8                                    baseos           141 k
 perl-MIME-Base64                  x86_64        3.15-396.el8                                    baseos            30 k
 perl-Math-BigInt                  noarch        1:1.9998.11-7.el8                               baseos           194 k
 perl-Math-Complex                 noarch        1.59-420.el8                                    baseos           107 k
 perl-Net-SSLeay                   x86_64        1.88-1.module+el8.4.0+512+d4f0fc54              appstream        378 k
 perl-PathTools                    x86_64        3.74-1.el8                                      baseos            89 k
 perl-Pod-Escapes                  noarch        1:1.07-395.el8                                  baseos            19 k
 perl-Pod-Perldoc                  noarch        3.28-396.el8                                    baseos            85 k
 perl-Pod-Simple                   noarch        1:3.35-395.el8                                  baseos           212 k
 perl-Pod-Usage                    noarch        4:1.69-395.el8                                  baseos            33 k
 perl-Scalar-List-Utils            x86_64        3:1.49-2.el8                                    baseos            67 k
 perl-Socket                       x86_64        4:2.027-3.el8                                   baseos            58 k
 perl-Storable                     x86_64        1:3.11-3.el8                                    baseos            97 k
 perl-Term-ANSIColor               noarch        4.06-396.el8                                    baseos            45 k
 perl-Term-Cap                     noarch        1.17-395.el8                                    baseos            22 k
 perl-Text-ParseWords              noarch        3.30-395.el8                                    baseos            17 k
 perl-Text-Tabs+Wrap               noarch        2013.0523-395.el8                               baseos            23 k
 perl-Time-Local                   noarch        1:1.280-1.el8                                   baseos            32 k
 perl-URI                          noarch        1.73-3.el8                                      appstream        115 k
 perl-Unicode-Normalize            x86_64        1.25-396.el8                                    baseos            81 k
 perl-constant                     noarch        1.33-396.el8                                    baseos            24 k
 perl-interpreter                  x86_64        4:5.26.3-420.el8                                baseos           6.3 M
 perl-libnet                       noarch        3.11-3.el8                                      appstream        120 k
 perl-libs                         x86_64        4:5.26.3-420.el8                                baseos           1.6 M
 perl-macros                       x86_64        4:5.26.3-420.el8                                baseos            71 k
 perl-parent                       noarch        1:0.237-1.el8                                   baseos            19 k
 perl-podlators                    noarch        4.11-1.el8                                      baseos           117 k
 perl-threads                      x86_64        1:2.21-2.el8                                    baseos            60 k
 perl-threads-shared               x86_64        1.58-2.el8                                      baseos            47 k
 psmisc                            x86_64        23.1-5.el8                                      baseos           150 k
Installing weak dependencies:
 mariadb-backup                    x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream        6.1 M
 mariadb-gssapi-server             x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream         50 k
 mariadb-server-utils              x86_64        3:10.3.28-1.module+el8.4.0+427+adf35707         appstream        1.1 M
 perl-IO-Socket-IP                 noarch        0.39-5.el8                                      appstream         46 k
 perl-IO-Socket-SSL                noarch        2.066-4.module+el8.4.0+512+d4f0fc54             appstream        297 k
 perl-Mozilla-CA                   noarch        20160104-7.module+el8.4.0+529+e3b3e624          appstream         14 k
Enabling module streams:
 mariadb                                         10.3
 perl                                            5.26
 perl-DBD-MySQL                                  4.046
 perl-DBI                                        1.641
 perl-IO-Socket-SSL                              2.066
 perl-libwww-perl                                6.34

Transaction Summary
========================================================================================================================
Install  55 Packages

Total download size: 43 M
Installed size: 192 M
Is this ok [y/N]: y
Downloading Packages:
Rocky Linux 8 - BaseOS                  106% [==========================================-]  11 kB/s | 3.2 kB     --:-- E(1/55): mariadb-common-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm                 339 kB/s |  62 kB     00:00
(2/55): mariadb-connector-c-3.1.11-2.el8_3.x86_64.rpm                                   1.8 MB/s | 199 kB     00:00
(3/55): mariadb-connector-c-config-3.1.11-2.el8_3.noarch.rpm                            279 kB/s |  14 kB     00:00
(4/55): mariadb-errmsg-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm                 1.7 MB/s | 233 kB     00:00
(5/55): mariadb-gssapi-server-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm          1.0 MB/s |  50 kB     00:00
(6/55): mariadb-backup-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm                 2.9 MB/s | 6.1 MB     00:02
(7/55): mariadb-server-utils-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm           921 kB/s | 1.1 MB     00:01
(8/55): perl-DBD-MySQL-4.046-3.module+el8.4.0+577+b8fe2d92.x86_64.rpm                   3.0 MB/s | 155 kB     00:00
(9/55): perl-DBI-1.641-3.module+el8.4.0+509+59a8d9b3.x86_64.rpm                         1.9 MB/s | 739 kB     00:00
(10/55): perl-Digest-1.17-395.el8.noarch.rpm                                            593 kB/s |  26 kB     00:00
(11/55): perl-Digest-MD5-2.55-396.el8.x86_64.rpm                                        854 kB/s |  36 kB     00:00
(12/55): perl-IO-Socket-IP-0.39-5.el8.noarch.rpm                                        1.1 MB/s |  46 kB     00:00
(13/55): perl-IO-Socket-SSL-2.066-4.module+el8.4.0+512+d4f0fc54.noarch.rpm              2.5 MB/s | 297 kB     00:00
(14/55): perl-Mozilla-CA-20160104-7.module+el8.4.0+529+e3b3e624.noarch.rpm              398 kB/s |  14 kB     00:00
(15/55): mariadb-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm                       1.4 MB/s | 6.0 MB     00:04
(16/55): perl-Net-SSLeay-1.88-1.module+el8.4.0+512+d4f0fc54.x86_64.rpm                  2.2 MB/s | 378 kB     00:00
(17/55): perl-URI-1.73-3.el8.noarch.rpm                                                 2.5 MB/s | 115 kB     00:00
(18/55): perl-libnet-3.11-3.el8.noarch.rpm                                              2.4 MB/s | 120 kB     00:00
(19/55): perl-Carp-1.42-396.el8.noarch.rpm                                              685 kB/s |  29 kB     00:00
(20/55): perl-Data-Dumper-2.167-399.el8.x86_64.rpm                                      1.2 MB/s |  57 kB     00:00
(21/55): perl-Errno-1.28-420.el8.x86_64.rpm                                             1.3 MB/s |  75 kB     00:00
(22/55): perl-Exporter-5.72-396.el8.noarch.rpm                                          661 kB/s |  33 kB     00:00
(23/55): perl-File-Path-2.15-2.el8.noarch.rpm                                           864 kB/s |  37 kB     00:00
(24/55): perl-File-Temp-0.230.600-1.el8.noarch.rpm                                      1.3 MB/s |  62 kB     00:00
(25/55): perl-Getopt-Long-2.50-4.el8.noarch.rpm                                         1.3 MB/s |  62 kB     00:00
(26/55): perl-HTTP-Tiny-0.074-1.el8.noarch.rpm                                          995 kB/s |  57 kB     00:00
(27/55): perl-Encode-2.97-3.el8.x86_64.rpm                                              4.3 MB/s | 1.5 MB     00:00
(28/55): perl-IO-1.38-420.el8.x86_64.rpm                                                2.3 MB/s | 141 kB     00:00
(29/55): perl-MIME-Base64-3.15-396.el8.x86_64.rpm                                       670 kB/s |  30 kB     00:00
(30/55): perl-Math-Complex-1.59-420.el8.noarch.rpm                                      2.3 MB/s | 107 kB     00:00
(31/55): perl-Math-BigInt-1.9998.11-7.el8.noarch.rpm                                    2.2 MB/s | 194 kB     00:00
(32/55): perl-PathTools-3.74-1.el8.x86_64.rpm                                           1.9 MB/s |  89 kB     00:00
(33/55): perl-Pod-Escapes-1.07-395.el8.noarch.rpm                                       411 kB/s |  19 kB     00:00
(34/55): perl-Pod-Perldoc-3.28-396.el8.noarch.rpm                                       1.9 MB/s |  85 kB     00:00
(35/55): perl-Pod-Usage-1.69-395.el8.noarch.rpm                                         760 kB/s |  33 kB     00:00
(36/55): perl-Pod-Simple-3.35-395.el8.noarch.rpm                                        2.0 MB/s | 212 kB     00:00
(37/55): perl-Scalar-List-Utils-1.49-2.el8.x86_64.rpm                                   1.4 MB/s |  67 kB     00:00
(38/55): perl-Socket-2.027-3.el8.x86_64.rpm                                             1.2 MB/s |  58 kB     00:00
(39/55): perl-Storable-3.11-3.el8.x86_64.rpm                                            1.9 MB/s |  97 kB     00:00
(40/55): perl-Term-ANSIColor-4.06-396.el8.noarch.rpm                                    942 kB/s |  45 kB     00:00
(41/55): perl-Term-Cap-1.17-395.el8.noarch.rpm                                          487 kB/s |  22 kB     00:00
(42/55): perl-Text-ParseWords-3.30-395.el8.noarch.rpm                                   443 kB/s |  17 kB     00:00
(43/55): perl-Text-Tabs+Wrap-2013.0523-395.el8.noarch.rpm                               546 kB/s |  23 kB     00:00
(44/55): perl-Time-Local-1.280-1.el8.noarch.rpm                                         804 kB/s |  32 kB     00:00
(45/55): perl-Unicode-Normalize-1.25-396.el8.x86_64.rpm                                 1.8 MB/s |  81 kB     00:00
(46/55): perl-constant-1.33-396.el8.noarch.rpm                                          644 kB/s |  24 kB     00:00
(47/55): perl-libs-5.26.3-420.el8.x86_64.rpm                                            1.8 MB/s | 1.6 MB     00:00
(48/55): perl-macros-5.26.3-420.el8.x86_64.rpm                                          1.5 MB/s |  71 kB     00:00
(49/55): perl-parent-0.237-1.el8.noarch.rpm                                             471 kB/s |  19 kB     00:00
(50/55): perl-podlators-4.11-1.el8.noarch.rpm                                           1.5 MB/s | 117 kB     00:00
(51/55): perl-threads-2.21-2.el8.x86_64.rpm                                             1.4 MB/s |  60 kB     00:00
(52/55): perl-threads-shared-1.58-2.el8.x86_64.rpm                                       88 kB/s |  47 kB     00:00
(53/55): psmisc-23.1-5.el8.x86_64.rpm                                                   1.7 MB/s | 150 kB     00:00
(54/55): perl-interpreter-5.26.3-420.el8.x86_64.rpm                                     2.5 MB/s | 6.3 MB     00:02
(55/55): mariadb-server-10.3.28-1.module+el8.4.0+427+adf35707.x86_64.rpm                1.8 MB/s |  16 MB     00:09
------------------------------------------------------------------------------------------------------------------------
Total                                                                                   4.2 MB/s |  43 MB     00:10
Running transaction check
Transaction check succeeded.
Running transaction test
https://gitlab.com/it4lik/b1-linux-2021/-/blob/master/tp/5/db.mdTransaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : mariadb-connector-c-config-3.1.11-2.el8_3.noarch                                              1/55
[...]
Complete!
[eulamawaifu@db ~]$ systemctl start mariadb.service
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'mariadb.service'.
Authenticating as: EulaMaWAIFU (eulamawaifu)
Password:
==== AUTHENTICATION COMPLETE ====
[eulamawaifu@db ~]$ systemctl status mariadb
● mariadb.service - MariaDB 10.3 database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2021-11-25 11:38:48 CET; 15s ago
     Docs: man:mysqld(8)
           https://mariadb.com/kb/en/library/systemd/
  Process: 4664 ExecStartPost=/usr/libexec/mysql-check-upgrade (code=exited, status=0/SUCCESS)
  Process: 4529 ExecStartPre=/usr/libexec/mysql-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
  Process: 4505 ExecStartPre=/usr/libexec/mysql-check-socket (code=exited, status=0/SUCCESS)
 Main PID: 4632 (mysqld)
   Status: "Taking your SQL requests now..."
    Tasks: 30 (limit: 4946)
   Memory: 79.1M
   CGroup: /system.slice/mariadb.service
           └─4632 /usr/libexec/mysqld --basedir=/usr

Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: See the MariaDB Knowledgebase at http://mariadb.com/kb or the
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: MySQL manual for more instructions.
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: Please report any problems at http://mariadb.org/jira
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: The latest information about MariaDB is available at http://ma>
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: You can find additional information about the MySQL part at:
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: http://dev.mysql.com
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: Consider joining "MariaDB's strong and vibrant community":
Nov 25 11:38:48 db.tp5.linux mysql-prepare-db-dir[4529]: https://mariadb.org/get-involved/
Nov 25 11:38:48 db.tp5.linux mysqld[4632]: 2021-11-25 11:38:48 0 [Note] /usr/libexec/mysqld (mysqld 10.3.28-MariaDB) st>
Nov 25 11:38:48 db.tp5.linux systemd[1]: Started MariaDB 10.3 database server.
[eulamawaifu@db ~]$ sudo systemctl enable mariadb
Created symlink /etc/systemd/system/mysql.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/mysqld.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/multi-user.target.wants/mariadb.service → /usr/lib/systemd/system/mariadb.service.
[eulamawaifu@db ~]$ sudo ss -lntap | grep mysqld
LISTEN 0      80                 *:3306            *:*     users:(("mysqld",pid=4632,fd=21))
[eulamawaifu@db ~]$ pstree | grep mysqld
        |-mysqld---29*[{mysqld}]
[eulamawaifu@db ~]$ ps -ef | grep mysqld
mysql       4632       1  0 11:38 ?        00:00:00 /usr/libexec/mysqld --basedir=/usr
eulamaw+    4797    1454  0 11:54 pts/0    00:00:00 grep --color=auto mysqld
#mysql est le process lancé par mariadb
[eulamawaifu@db ~]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
[eulamawaifu@db ~]$ sudo firewall-cmd --reload
success
[eulamawaifu@db ~]$ sudo mysql_secure_installation

"NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] n
 ... skipping.

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure."

Thanks for using MariaDB!
[eulamawaifu@db ~]$ sudo mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 14
Server version: 10.3.28-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'nextcloud'@'10.5.1.11' IDENTIFIED BY 'meow';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'10.5.1.11';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)
[eulamawaifu@web selinux]$ sudo dnf provides mysql
[sudo] password for eulamawaifu:
Last metadata expiration check: 0:28:44 ago on Thu 25 Nov 2021 11:37:54 AM CET.
mysql-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64 : MySQL client programs and shared libraries
Repo        : appstream
Matched from:
Provide    : mysql = 8.0.26-1.module+el8.4.0+652+6de068a7
[eulamawaifu@web selinux]$ sudo dnf install mysql
Last metadata expiration check: 0:30:36 ago on Thu 25 Nov 2021 11:37:54 AM CET.
Dependencies resolved.
========================================================================================================================
 Package                            Architecture   Version                                      Repository         Size
========================================================================================================================
Installing:
 mysql                              x86_64         8.0.26-
[...]
Complete!
[eulamawaifu@web ~]$ mysql -p -h 10.5.1.12 -P 3306 -u nextcloud nextcloud
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 5.5.5-10.3.28-MariaDB MariaDB Server

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW TABLES;
Empty set (0.00 sec)
[eulamawaifu@db ~]$ sudo dnf install httpd
Last metadata expiration check: 0:17:24 ago on Thu 25 Nov 2021 12:10:00 PM CET.
Dependencies resolved.
========================================================================================================================
 Package                     Architecture     Version                                         Repository           Size
========================================================================================================================
Installing:
 httpd                       x86_64           2.4.37-
[...]
Complete!
[eulamawaifu@db ~]$ systemctl start httpd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'httpd.service'.
Authenticating as: EulaMaWAIFU (eulamawaifu)
Password:
==== AUTHENTICATION COMPLETE ====
[eulamawaifu@db ~]$ systemctl enable httpd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ====
Authentication is required to manage system service or unit files.
Authenticating as: EulaMaWAIFU (eulamawaifu)
Password:
==== AUTHENTICATION COMPLETE ====
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ====
Authentication is required to reload the systemd state.
Authenticating as: EulaMaWAIFU (eulamawaifu)
Password:
==== AUTHENTICATION COMPLETE ====
[eulamawaifu@db ~]$ sudo ss -lntap | grep httpd
LISTEN 0      128                *:80              *:*     users:(("httpd",pid=5496,fd=4),("httpd",pid=5495,fd=4),("httpd",pid=5494,fd=4),("httpd",pid=5492,fd=4))
[eulamawaifu@db ~]$ sudo ps -ef | grep httpd
root        5492       1  0 12:29 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      5493    5492  0 12:29 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      5494    5492  0 12:29 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      5495    5492  0 12:29 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      5496    5492  0 12:29 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
eulamaw+    5767    1454  0 12:30 pts/0    00:00:00 grep --color=auto httpd
[eulamawaifu@db ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[eulamawaifu@db ~]$ sudo firewall-cmd --reload
success
C:\Users\valen>curl http://10.5.1.12
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
        body {
  background: rgb(20,72,50);
  background: -moz-linear-gradient(180deg, rgba(20,72,50,1) 30%, rgba(0,0,0,1) 90%)  ;
  background: -webkit-linear-gradient(180deg, rgba(20,72,50,1) 30%, rgba(0,0,0,1) 90%) ;
  background: linear-gradient(180deg, rgba(20,72,50,1) 30%, rgba(0,0,0,1) 90%);
  background-repeat: no-repeat;
  background-attachment: fixed;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#3c6eb4",endColorstr="#3c95b4",GradientType=1);
        color: white;
        font-size: 0.9em;
        font-weight: 400;
        font-family: 'Montserrat', sans-serif;
        margin: 0;
        padding: 10em 6em 10em 6em;
        box-sizing: border-box;

      }


  h1 {
    text-align: center;
    margin: 0;
    padding: 0.6em 2em 0.4em;
    color: #fff;
    font-weight: bold;
    font-family: 'Montserrat', sans-serif;
    font-size: 2em;
  }
  h1 strong {
    font-weight: bolder;
    font-family: 'Montserrat', sans-serif;
  }
  h2 {
    font-size: 1.5em;
    font-weight:bold;
  }

  .title {
    border: 1px solid black;
    font-weight: bold;
    position: relative;
    float: right;
    width: 150px;
    text-align: center;
    padding: 10px 0 10px 0;
    margin-top: 0;
  }

  .description {
    padding: 45px 10px 5px 10px;
    clear: right;
    padding: 15px;
  }

  .section {
    padding-left: 3%;
   margin-bottom: 10px;
  }

  img {

    padding: 2px;
    margin: 2px;
  }
  a:hover img {
    padding: 2px;
    margin: 2px;
  }

  :link {
    color: rgb(199, 252, 77);
    text-shadow:
  }
  :visited {
    color: rgb(122, 206, 255);
  }
  a:hover {
    color: rgb(16, 44, 122);
  }
  .row {
    width: 100%;
    padding: 0 10px 0 10px;
  }

  footer {
    padding-top: 6em;
    margin-bottom: 6em;
    text-align: center;
    font-size: xx-small;
    overflow:hidden;
    clear: both;
  }

  .summary {
    font-size: 140%;
    text-align: center;
  }

  #rocky-poweredby img {
    margin-left: -10px;
  }

  #logos img {
    vertical-align: top;
  }

  /* Desktop  View Options */

  @media (min-width: 768px)  {

    body {
      padding: 10em 20% !important;
    }

    .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6,
    .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
      float: left;
    }

    .col-md-1 {
      width: 8.33%;
    }
    .col-md-2 {
      width: 16.66%;
    }
    .col-md-3 {
      width: 25%;
    }
    .col-md-4 {
      width: 33%;
    }
    .col-md-5 {
      width: 41.66%;
    }
    .col-md-6 {
      border-left:3px ;
      width: 50%;


    }
    .col-md-7 {
      width: 58.33%;
    }
    .col-md-8 {
      width: 66.66%;
    }
    .col-md-9 {
      width: 74.99%;
    }
    .col-md-10 {
      width: 83.33%;
    }
    .col-md-11 {
      width: 91.66%;
    }
    .col-md-12 {
      width: 100%;
    }
  }

  /* Mobile View Options */
  @media (max-width: 767px) {
    .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6,
    .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12 {
      float: left;
    }

    .col-sm-1 {
      width: 8.33%;
    }
    .col-sm-2 {
      width: 16.66%;
    }
    .col-sm-3 {
      width: 25%;
    }
    .col-sm-4 {
      width: 33%;
    }
    .col-sm-5 {
      width: 41.66%;
    }
    .col-sm-6 {
      width: 50%;
    }
    .col-sm-7 {
      width: 58.33%;
    }
    .col-sm-8 {
      width: 66.66%;
    }
    .col-sm-9 {
      width: 74.99%;
    }
    .col-sm-10 {
      width: 83.33%;
    }
    .col-sm-11 {
      width: 91.66%;
    }
    .col-sm-12 {
      width: 100%;
    }
    h1 {
      padding: 0 !important;
    }
  }


  </style>
  </head>
  <body>
    <h1>HTTP Server <strong>Test Page</strong></h1>

    <div class='row'>

      <div class='col-sm-12 col-md-6 col-md-6 '></div>
          <p class="summary">This page is used to test the proper operation of
            an HTTP server after it has been installed on a Rocky Linux system.
            If you can read this page, it means that the software it working
            correctly.</p>
      </div>

      <div class='col-sm-12 col-md-6 col-md-6 col-md-offset-12'>


        <div class='section'>
          <h2>Just visiting?</h2>

          <p>This website you are visiting is either experiencing problems or
          could be going through maintenance.</p>

          <p>If you would like the let the administrators of this website know
          that you've seen this page instead of the page you've expected, you
          should send them an email. In general, mail sent to the name
          "webmaster" and directed to the website's domain should reach the
          appropriate person.</p>

          <p>The most common email address to send to is:
          <strong>"webmaster@example.com"</strong></p>

          <h2>Note:</h2>
          <p>The Rocky Linux distribution is a stable and reproduceable platform
          based on the sources of Red Hat Enterprise Linux (RHEL). With this in
          mind, please understand that:

        <ul>
          <li>Neither the <strong>Rocky Linux Project</strong> nor the
          <strong>Rocky Enterprise Software Foundation</strong> have anything to
          do with this website or its content.</li>
          <li>The Rocky Linux Project nor the <strong>RESF</strong> have
          "hacked" this webserver: This test page is included with the
          distribution.</li>
        </ul>
        <p>For more information about Rocky Linux, please visit the
          <a href="https://rockylinux.org/"><strong>Rocky Linux
          website</strong></a>.
        </p>
        </div>
      </div>
      <div class='col-sm-12 col-md-6 col-md-6 col-md-offset-12'>
        <div class='section'>

          <h2>I am the admin, what do I do?</h2>

        <p>You may now add content to the webroot directory for your
        software.</p>

        <p><strong>For systems using the
        <a href="https://httpd.apache.org/">Apache Webserver</strong></a>:
        You can add content to the directory <code>/var/www/html/</code>.
        Until you do so, people visiting your website will see this page. If
        you would like this page to not be shown, follow the instructions in:
        <code>/etc/httpd/conf.d/welcome.conf</code>.</p>

        <p><strong>For systems using
        <a href="https://nginx.org">Nginx</strong></a>:
        You can add your content in a location of your
        choice and edit the <code>root</code> configuration directive
        in <code>/etc/nginx/nginx.conf</code>.</p>

        <div id="logos">
          <a href="https://rockylinux.org/" id="rocky-poweredby"><img src= "icons/poweredby.png" alt="[ Powered by Rocky Linux ]" /></a> <!-- Rocky -->
          <img src="poweredby.png" /> <!-- webserver -->
        </div>
      </div>
      </div>

      <footer class="col-sm-12">
      <a href="https://apache.org">Apache&trade;</a> is a registered trademark of <a href="https://apache.org">the Apache Software Foundation</a> in the United States and/or other countries.<br />
      <a href="https://nginx.org">NGINX&trade;</a> is a registered trademark of <a href="https://">F5 Networks, Inc.</a>.
      </footer>

  </body>
</html>
```
```bash=
[eulamawaifu@db ~]$ sudo dnf install epel-release
[sudo] password for eulamawaifu:
Last metadata expiration check: 0:29:36 ago on Thu 25 Nov 2021 12:10:00 PM CET.
Dependencies resolved.
========================================================================================================================
 Package                         Architecture              Version                      Repository                 Size
========================================================================================================================
Installing:
 epel-release                    noarch                    8-13.el8                     extras                     23 k

Transaction Summary
========================================================================================================================
Install  1 Package

Total download size: 23 k
Installed size: 35 k
Is this ok [y/N]: y
Downloading Packages:
epel-release-8-13.el8.noarch.rpm                                                        161 kB/s |  23 kB     00:00
------------------------------------------------------------------------------------------------------------------------
Total                                                                                    56 kB/s |  23 kB     00:00
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : epel-release-8-13.el8.noarch                                                                   1/1
  Running scriptlet: epel-release-8-13.el8.noarch                                                                   1/1
  Verifying        : epel-release-8-13.el8.noarch                                                                   1/1

Installed:
  epel-release-8-13.el8.noarch

Complete!
[eulamawaifu@db ~]$ sudo dnf update
Extra Packages for Enterprise Linux 8 - x86_64                                          4.1 MB/s |  11 MB     00:02
Extra Packages for Enterprise Linux Modular 8 - x86_64                                  924 kB/s | 958 kB     00:01
Last metadata expiration check: 0:00:01 ago on Thu 25 Nov 2021 12:39:55 PM CET.
Dependencies resolved.
Nothing to do.
Complete!
[eulamawaifu@db ~]$ sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
Last metadata expiration check: 0:01:07 ago on Thu 25 Nov 2021 12:39:55 PM CET.
remi-release-8.rpm                                                                      142 kB/s |  26 kB     00:00
Dependencies resolved.
========================================================================================================================
 Package                      Architecture           Version                         Repository                    Size
========================================================================================================================
Installing:
 remi-release                 noarch                 8.5-1.el8.remi                  @commandline                  26 k

Transaction Summary
========================================================================================================================
Install  1 Package

Total size: 26 k
Installed size: 20 k
Is this ok [y/N]: y
Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : remi-release-8.5-1.el8.remi.noarch                                                             1/1
  Verifying        : remi-release-8.5-1.el8.remi.noarch                                                             1/1

Installed:
  remi-release-8.5-1.el8.remi.noarch

Complete!
[eulamawaifu@db ~]$ dnf module enable php:remi-7.4
Error: This command has to be run with superuser privileges (under the root user on most systems).
[eulamawaifu@db ~]$ sudo !!
sudo dnf module enable php:remi-7.4
Remi's Modular repository for Enterprise Linux 8 - x86_64                               2.2 kB/s | 858  B     00:00
Remi's Modular repository for Enterprise Linux 8 - x86_64                               3.0 MB/s | 3.1 kB     00:00
Importing GPG key 0x5F11735A:
 Userid     : "Remi's RPM repository <remi@remirepo.net>"
 Fingerprint: 6B38 FEA7 231F 87F5 2B9C A9D8 5550 9759 5F11 735A
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el8
Is this ok [y/N]: y
Remi's Modular repository for Enterprise Linux 8 - x86_64                               1.5 MB/s | 870 kB     00:00
Safe Remi's RPM repository for Enterprise Linux 8 - x86_64                              2.4 kB/s | 858  B     00:00
Safe Remi's RPM repository for Enterprise Linux 8 - x86_64                              3.0 MB/s | 3.1 kB     00:00
Importing GPG key 0x5F11735A:
 Userid     : "Remi's RPM repository <remi@remirepo.net>"
 Fingerprint: 6B38 FEA7 231F 87F5 2B9C A9D8 5550 9759 5F11 735A
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el8
Is this ok [y/N]: y
Safe Remi's RPM repository for Enterprise Linux 8 - x86_64                              2.1 MB/s | 2.0 MB     00:00
Last metadata expiration check: 0:00:01 ago on Thu 25 Nov 2021 12:41:26 PM CET.
Dependencies resolved.
========================================================================================================================
 Package                     Architecture               Version                       Repository                   Size
========================================================================================================================
Enabling module streams:
 php                                                    remi-7.4

Transaction Summary
========================================================================================================================

Is this ok [y/N]: y
Complete!
[eulamawaifu@db ~]$ sudo dnf install zip unzip libxml2 openssl php74-php php74-php-ctype php74-php-curl php74-php-gd php74-php-iconv php74-php-json php74-php-libxml php74-php-mbstring php74-php-openssl php74-php-posix php74-php-session php74-php-xml php74-php-zip php74-php-zlib php74-php-pdo php74-php-mysqlnd php74-php-intl php74-php-bcmath php74-php-gmp
Last metadata expiration check: 0:00:14 ago on Thu 25 Nov 2021 12:41:26 PM CET.
Package zip-3.0-23.el8.x86_64 is already installed.
Package unzip-6.0-45.el8_4.x86_64 is already installed.
Package libxml2-2.9.7-11.el8.x86_64 is already installed.
Package openssl-1:1.1.1k-4.el8.x86_64 is already installed.
Dependencies resolved.
========================================================================================================================
 Package                           Architecture         Version                           Repository               Size
========================================================================================================================
Installing:
 php74-php                         x86_64               7.4.26-1.el8.remi                 remi-safe               1.5 M
 php74-php-bcmath                  x86_64               7.4.26-1.el8.remi                 remi-safe                88 k
 php74-php-common                  x86_64               7.4.26-1.el8.remi                 remi-safe               710 k
 php74-php-gd                      x86_64               7.4.26-1.el8.remi                 remi-safe                93 k
 php74-php-gmp                     x86_64               7.4.26-1.el8.remi                 remi-safe                84 k
 php74-php-intl                    x86_64               7.4.26-1.el8.remi                 remi-safe               201 k
 php74-php-json                    x86_64               7.4.26-1.el8.remi                 remi-safe                82 k
 php74-php-mbstring                x86_64               7.4.26-1.el8.remi                 remi-safe               492 k
 php74-php-mysqlnd                 x86_64               7.4.26-1.el8.remi                 remi-safe               200 k
 php74-php-pdo                     x86_64               7.4.26-1.el8.remi                 remi-safe               130 k
 php74-php-pecl-zip                x86_64               1.20.0-1.el8.remi                 remi-safe                58 k
 php74-php-process                 x86_64               7.4.26-1.el8.remi                 remi-safe                92 k
 php74-php-xml                     x86_64               7.4.26-1.el8.remi                 remi-safe               180 k
Installing dependencies:
 environment-modules               x86_64               4.5.2-1.el8                       baseos                  420 k
 gd                                x86_64               2.2.5-7.el8                       appstream               143 k
 jbigkit-libs                      x86_64               2.1-14.el8                        appstream                54 k
 libXpm                            x86_64               3.5.12-8.el8                      appstream                57 k
 libicu69                          x86_64               69.1-1.el8.remi                   remi-safe               9.6 M
 libjpeg-turbo                     x86_64               1.5.3-12.el8                      appstream               156 k
 libsodium                         x86_64               1.0.18-2.el8                      epel                    162 k
 libtiff                           x86_64               4.0.9-20.el8                      appstream               187 k
 libwebp                           x86_64               1.0.0-5.el8                       appstream               271 k
 oniguruma5php                     x86_64               6.9.7.1-1.el8.remi                remi-safe               210 k
 php74-libzip                      x86_64               1.8.0-1.el8.remi                  remi-safe                69 k
 php74-runtime                     x86_64               1.0-3.el8.remi                    remi-safe               1.1 M
 scl-utils                         x86_64               1:2.0.2-14.el8                    appstream                46 k
 tcl                               x86_64               1:8.6.8-2.el8                     baseos                  1.1 M
Installing weak dependencies:
 php74-php-cli                     x86_64               7.4.26-1.el8.remi                 remi-safe               3.1 M
 php74-php-fpm                     x86_64               7.4.26-1.el8.remi                 remi-safe               1.6 M
 php74-php-opcache                 x86_64               7.4.26-1.el8.remi                 remi-safe               275 k
 php74-php-sodium                  x86_64               7.4.26-1.el8.remi                 remi-safe                87 k

Transaction Summary
========================================================================================================================
Install  31 Packages

Total download size: 23 M
Installed size: 76 M
Is this ok [y/N]: y
Downloading Packages:
(1/31): jbigkit-libs-2.1-14.el8.x86_64.rpm                                              277 kB/s |  54 kB     00:00
(2/31): libXpm-3.5.12-8.el8.x86_64.rpm                                                  292 kB/s |  57 kB     00:00
(3/31): gd-2.2.5-7.el8.x86_64.rpm                                                       662 kB/s | 143 kB     00:00
(4/31): libjpeg-turbo-1.5.3-12.el8.x86_64.rpm                                           1.2 MB/s | 156 kB     00:00
(5/31): libwebp-1.0.0-5.el8.x86_64.rpm                                                  2.2 MB/s | 271 kB     00:00
(6/31): libtiff-4.0.9-20.el8.x86_64.rpm                                                 1.1 MB/s | 187 kB     00:00
(7/31): scl-utils-2.0.2-14.el8.x86_64.rpm                                               933 kB/s |  46 kB     00:00
(8/31): environment-modules-4.5.2-1.el8.x86_64.rpm                                      4.3 MB/s | 420 kB     00:00
(9/31): libsodium-1.0.18-2.el8.x86_64.rpm                                               1.3 MB/s | 162 kB     00:00
(10/31): oniguruma5php-6.9.7.1-1.el8.remi.x86_64.rpm                                    971 kB/s | 210 kB     00:00
(11/31): php74-libzip-1.8.0-1.el8.remi.x86_64.rpm                                       906 kB/s |  69 kB     00:00
(12/31): tcl-8.6.8-2.el8.x86_64.rpm                                                     2.0 MB/s | 1.1 MB     00:00
(13/31): php74-php-bcmath-7.4.26-1.el8.remi.x86_64.rpm                                  672 kB/s |  88 kB     00:00
(14/31): php74-php-7.4.26-1.el8.remi.x86_64.rpm                                         2.6 MB/s | 1.5 MB     00:00
(15/31): php74-php-common-7.4.26-1.el8.remi.x86_64.rpm                                  3.9 MB/s | 710 kB     00:00
(16/31): php74-php-fpm-7.4.26-1.el8.remi.x86_64.rpm                                     5.2 MB/s | 1.6 MB     00:00
(17/31): php74-php-gd-7.4.26-1.el8.remi.x86_64.rpm                                      2.1 MB/s |  93 kB     00:00
(18/31): php74-php-gmp-7.4.26-1.el8.remi.x86_64.rpm                                     1.9 MB/s |  84 kB     00:00
(19/31): php74-php-intl-7.4.26-1.el8.remi.x86_64.rpm                                    3.7 MB/s | 201 kB     00:00
(20/31): php74-php-json-7.4.26-1.el8.remi.x86_64.rpm                                    1.7 MB/s |  82 kB     00:00
(21/31): php74-php-cli-7.4.26-1.el8.remi.x86_64.rpm                                     2.9 MB/s | 3.1 MB     00:01
(22/31): php74-php-mbstring-7.4.26-1.el8.remi.x86_64.rpm                                5.1 MB/s | 492 kB     00:00
(23/31): php74-php-mysqlnd-7.4.26-1.el8.remi.x86_64.rpm                                 2.8 MB/s | 200 kB     00:00
(24/31): php74-php-opcache-7.4.26-1.el8.remi.x86_64.rpm                                 4.8 MB/s | 275 kB     00:00
(25/31): php74-php-pdo-7.4.26-1.el8.remi.x86_64.rpm                                     2.7 MB/s | 130 kB     00:00
(26/31): php74-php-pecl-zip-1.20.0-1.el8.remi.x86_64.rpm                                1.3 MB/s |  58 kB     00:00
(27/31): php74-php-process-7.4.26-1.el8.remi.x86_64.rpm                                 2.0 MB/s |  92 kB     00:00
(28/31): php74-php-sodium-7.4.26-1.el8.remi.x86_64.rpm                                  1.4 MB/s |  87 kB     00:00
(29/31): php74-php-xml-7.4.26-1.el8.remi.x86_64.rpm                                     3.4 MB/s | 180 kB     00:00
(30/31): libicu69-69.1-1.el8.remi.x86_64.rpm                                            4.8 MB/s | 9.6 MB     00:01
(31/31): php74-runtime-1.0-3.el8.remi.x86_64.rpm                                        4.7 MB/s | 1.1 MB     00:00
------------------------------------------------------------------------------------------------------------------------
Total                                                                                   6.0 MB/s |  23 MB     00:03
Extra Packages for Enterprise Linux 8 - x86_64                                          1.6 MB/s | 1.6 kB     00:00
Importing GPG key 0x2F86D6A1:
 Userid     : "Fedora EPEL (8) <epel@fedoraproject.org>"
 Fingerprint: 94E2 79EB 8D8F 25B2 1810 ADF1 21EA 45AB 2F86 D6A1
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8
Is this ok [y/N]: y
Key imported successfully
Safe Remi's RPM repository for Enterprise Linux 8 - x86_64                              3.0 MB/s | 3.1 kB     00:00
Importing GPG key 0x5F11735A:
 Userid     : "Remi's RPM repository <remi@remirepo.net>"
 Fingerprint: 6B38 FEA7 231F 87F5 2B9C A9D8 5550 9759 5F11 735A
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el8
Is this ok [y/N]: y
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : libjpeg-turbo-1.5.3-12.el8.x86_64                                                             1/31
  Installing       : oniguruma5php-6.9.7.1-1.el8.remi.x86_64                                                       2/31
  Installing       : libicu69-69.1-1.el8.remi.x86_64                                                               3/31
  Installing       : libsodium-1.0.18-2.el8.x86_64                                                                 4/31
  Installing       : tcl-1:8.6.8-2.el8.x86_64                                                                      5/31
  Running scriptlet: tcl-1:8.6.8-2.el8.x86_64                                                                      5/31
  Installing       : environment-modules-4.5.2-1.el8.x86_64                                                        6/31
  Running scriptlet: environment-modules-4.5.2-1.el8.x86_64                                                        6/31
  Installing       : scl-utils-1:2.0.2-14.el8.x86_64                                                               7/31
  Installing       : php74-runtime-1.0-3.el8.remi.x86_64                                                           8/31
  Running scriptlet: php74-runtime-1.0-3.el8.remi.x86_64                                                           8/31
  Installing       : php74-php-json-7.4.26-1.el8.remi.x86_64                                                       9/31
  Installing       : php74-php-common-7.4.26-1.el8.remi.x86_64                                                    10/31
  Installing       : php74-php-pdo-7.4.26-1.el8.remi.x86_64                                                       11/31
  Installing       : php74-php-cli-7.4.26-1.el8.remi.x86_64                                                       12/31
  Installing       : php74-php-fpm-7.4.26-1.el8.remi.x86_64                                                       13/31
  Running scriptlet: php74-php-fpm-7.4.26-1.el8.remi.x86_64                                                       13/31
  Installing       : php74-php-mbstring-7.4.26-1.el8.remi.x86_64                                                  14/31
  Installing       : php74-php-opcache-7.4.26-1.el8.remi.x86_64                                                   15/31
  Installing       : php74-php-sodium-7.4.26-1.el8.remi.x86_64                                                    16/31
  Installing       : php74-php-xml-7.4.26-1.el8.remi.x86_64                                                       17/31
  Installing       : php74-libzip-1.8.0-1.el8.remi.x86_64                                                         18/31
  Installing       : libwebp-1.0.0-5.el8.x86_64                                                                   19/31
  Installing       : libXpm-3.5.12-8.el8.x86_64                                                                   20/31
  Installing       : jbigkit-libs-2.1-14.el8.x86_64                                                               21/31
  Running scriptlet: jbigkit-libs-2.1-14.el8.x86_64                                                               21/31
  Installing       : libtiff-4.0.9-20.el8.x86_64                                                                  22/31
  Installing       : gd-2.2.5-7.el8.x86_64                                                                        23/31
  Running scriptlet: gd-2.2.5-7.el8.x86_64                                                                        23/31
  Installing       : php74-php-gd-7.4.26-1.el8.remi.x86_64                                                        24/31
  Installing       : php74-php-pecl-zip-1.20.0-1.el8.remi.x86_64                                                  25/31
  Installing       : php74-php-7.4.26-1.el8.remi.x86_64                                                           26/31
  Installing       : php74-php-mysqlnd-7.4.26-1.el8.remi.x86_64                                                   27/31
  Installing       : php74-php-bcmath-7.4.26-1.el8.remi.x86_64                                                    28/31
  Installing       : php74-php-gmp-7.4.26-1.el8.remi.x86_64                                                       29/31
  Installing       : php74-php-intl-7.4.26-1.el8.remi.x86_64                                                      30/31
  Installing       : php74-php-process-7.4.26-1.el8.remi.x86_64                                                   31/31
  Running scriptlet: php74-php-process-7.4.26-1.el8.remi.x86_64                                                   31/31
  Running scriptlet: php74-php-fpm-7.4.26-1.el8.remi.x86_64                                                       31/31
  Verifying        : gd-2.2.5-7.el8.x86_64                                                                         1/31
  Verifying        : jbigkit-libs-2.1-14.el8.x86_64                                                                2/31
  Verifying        : libXpm-3.5.12-8.el8.x86_64                                                                    3/31
  Verifying        : libjpeg-turbo-1.5.3-12.el8.x86_64                                                             4/31
  Verifying        : libtiff-4.0.9-20.el8.x86_64                                                                   5/31
  Verifying        : libwebp-1.0.0-5.el8.x86_64                                                                    6/31
  Verifying        : scl-utils-1:2.0.2-14.el8.x86_64                                                               7/31
  Verifying        : environment-modules-4.5.2-1.el8.x86_64                                                        8/31
  Verifying        : tcl-1:8.6.8-2.el8.x86_64                                                                      9/31
  Verifying        : libsodium-1.0.18-2.el8.x86_64                                                                10/31
  Verifying        : libicu69-69.1-1.el8.remi.x86_64                                                              11/31
  Verifying        : oniguruma5php-6.9.7.1-1.el8.remi.x86_64                                                      12/31
  Verifying        : php74-libzip-1.8.0-1.el8.remi.x86_64                                                         13/31
  Verifying        : php74-php-7.4.26-1.el8.remi.x86_64                                                           14/31
  Verifying        : php74-php-bcmath-7.4.26-1.el8.remi.x86_64                                                    15/31
  Verifying        : php74-php-cli-7.4.26-1.el8.remi.x86_64                                                       16/31
  Verifying        : php74-php-common-7.4.26-1.el8.remi.x86_64                                                    17/31
  Verifying        : php74-php-fpm-7.4.26-1.el8.remi.x86_64                                                       18/31
  Verifying        : php74-php-gd-7.4.26-1.el8.remi.x86_64                                                        19/31
  Verifying        : php74-php-gmp-7.4.26-1.el8.remi.x86_64                                                       20/31
  Verifying        : php74-php-intl-7.4.26-1.el8.remi.x86_64                                                      21/31
  Verifying        : php74-php-json-7.4.26-1.el8.remi.x86_64                                                      22/31
  Verifying        : php74-php-mbstring-7.4.26-1.el8.remi.x86_64                                                  23/31
  Verifying        : php74-php-mysqlnd-7.4.26-1.el8.remi.x86_64                                                   24/31
  Verifying        : php74-php-opcache-7.4.26-1.el8.remi.x86_64                                                   25/31
  Verifying        : php74-php-pdo-7.4.26-1.el8.remi.x86_64                                                       26/31
  Verifying        : php74-php-pecl-zip-1.20.0-1.el8.remi.x86_64                                                  27/31
  Verifying        : php74-php-process-7.4.26-1.el8.remi.x86_64                                                   28/31
  Verifying        : php74-php-sodium-7.4.26-1.el8.remi.x86_64                                                    29/31
  Verifying        : php74-php-xml-7.4.26-1.el8.remi.x86_64                                                       30/31
  Verifying        : php74-runtime-1.0-3.el8.remi.x86_64                                                          31/31

Installed:
  environment-modules-4.5.2-1.el8.x86_64                      gd-2.2.5-7.el8.x86_64
  jbigkit-libs-2.1-14.el8.x86_64                              libXpm-3.5.12-8.el8.x86_64
  libicu69-69.1-1.el8.remi.x86_64                             libjpeg-turbo-1.5.3-12.el8.x86_64
  libsodium-1.0.18-2.el8.x86_64                               libtiff-4.0.9-20.el8.x86_64
  libwebp-1.0.0-5.el8.x86_64                                  oniguruma5php-6.9.7.1-1.el8.remi.x86_64
  php74-libzip-1.8.0-1.el8.remi.x86_64                        php74-php-7.4.26-1.el8.remi.x86_64
  php74-php-bcmath-7.4.26-1.el8.remi.x86_64                   php74-php-cli-7.4.26-1.el8.remi.x86_64
  php74-php-common-7.4.26-1.el8.remi.x86_64                   php74-php-fpm-7.4.26-1.el8.remi.x86_64
  php74-php-gd-7.4.26-1.el8.remi.x86_64                       php74-php-gmp-7.4.26-1.el8.remi.x86_64
  php74-php-intl-7.4.26-1.el8.remi.x86_64                     php74-php-json-7.4.26-1.el8.remi.x86_64
  php74-php-mbstring-7.4.26-1.el8.remi.x86_64                 php74-php-mysqlnd-7.4.26-1.el8.remi.x86_64
  php74-php-opcache-7.4.26-1.el8.remi.x86_64                  php74-php-pdo-7.4.26-1.el8.remi.x86_64
  php74-php-pecl-zip-1.20.0-1.el8.remi.x86_64                 php74-php-process-7.4.26-1.el8.remi.x86_64
  php74-php-sodium-7.4.26-1.el8.remi.x86_64                   php74-php-xml-7.4.26-1.el8.remi.x86_64
  php74-runtime-1.0-3.el8.remi.x86_64                         scl-utils-1:2.0.2-14.el8.x86_64
  tcl-1:8.6.8-2.el8.x86_64

Complete!

```
```bash=
[eulamawaifu@db ~]$ cd /etc/httpd/conf
[eulamawaifu@db conf]$ cat httpd.conf | grep IncludeOptional
IncludeOptional conf.d/*.conf
[eulamawaifu@db conf.d]$ sudo nano modif.conf
[sudo] password for eulamawaifu:
[eulamawaifu@db conf.d]$ [eulamawaifu@db conf.d]$ cat modif.conf
<VirtualHost *:80>
  DocumentRoot /var/www/nextcloud/html/  # on précise ici le dossier qui contiendra le site : la racine Web
  ServerName  web.tp5.linux  # ici le nom qui sera utilisé pour accéder à l'application

  <Directory /var/www/nextcloud/html/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews

    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
[eulamawaifu@db nextcloud]$ chown apache:apache html/
chown: changing ownership of 'html/': Operation not permitted
[eulamawaifu@db nextcloud]$ sudo !!
sudo chown apache:apache html/
[sudo] password for eulamawaifu:
[eulamawaifu@db nextcloud]$ ls -l
total 0
drwxr-xr-x. 2 apache apache 6 Nov 25 12:49 html
[eulamawaifu@db nextcloud]$ cd ..
[eulamawaifu@db www]$ sudo chown apache:apache nextcloud/
[eulamawaifu@db www]$ timedatectl
               Local time: Thu 2021-11-25 12:57:47 CET
           Universal time: Thu 2021-11-25 11:57:47 UTC
                 RTC time: Thu 2021-11-25 11:57:46
                Time zone: Europe/Paris (CET, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
[eulamawaifu@db www]$ sudo nano /etc/opt/remi/php74/php.ini
[eulamawaifu@db www]$ cd
[eulamawaifu@db ~]$ curl -SLO https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  148M  100  148M    0     0  10.4M      0  0:00:14  0:00:14 --:--:-- 13.5M
[eulamawaifu@db ~]$ ls
nextcloud-21.0.1.zip
[eulamawaifu@db ~]$ sudo unzip -q nextcloud-21.0.1.zip
[eulamawaifu@db ~]$ ls
nextcloud  nextcloud-21.0.1.zip
[eulamawaifu@db ~]$ mv nextcloud /var/www/nextcloud/html/
mv: cannot move 'nextcloud' to '/var/www/nextcloud/html/nextcloud': Permission denied
[eulamawaifu@db ~]$ sudo !!
sudo mv nextcloud /var/www/nextcloud/html/
[eulamawaifu@db ~]$ rm nextcloud-21.0.1.zip
[eulamawaifu@db html]$ chown apache:apache nextcloud/
chown: changing ownership of 'nextcloud/': Operation not permitted
[eulamawaifu@db html]$ sudo !!
sudo chown apache:apache nextcloud/

```