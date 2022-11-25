# TP3 : Amélioration de la solution NextCloud

Je ne vais pas les faire dans l'ordre donc je vais plûtot afin celui que j'ai suivi.

## Module 5 : Monitoring

Sur web.tp2.linux et db.tp2.linux

### Installation de Netdata :
```bash
[ersjyhag@web ~]$ curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --disable-telemetry
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 81470    0 81470    0     0   418k      0 --:--:-- --:--:-- --:--:--  418k
[...]
Complete!
 OK
[ersjyhag@web ~]$ sudo systemctl start netdata
[ersjyhag@web ~]$ sudo systemctl enable netdata
[ersjyhag@web ~]$ sudo firewall-cmd --permanent --add-port=19999/tcp
success
[ersjyhag@web ~]$ sudo firewall-cmd --reload
success
[ersjyhag@web ~]$ sudo ss -lntap | grep netdata
LISTEN    0      4096              127.0.0.1:8125              0.0.0.0:*     users:(("netdata",pid=1528,fd=39))

LISTEN    0      4096                0.0.0.0:19999             0.0.0.0:*     users:(("netdata",pid=1528,fd=6))

ESTAB     0      0               10.102.1.11:19999          10.102.1.1:55845 users:(("netdata",pid=1528,fd=79))

LISTEN    0      4096                  [::1]:8125                 [::]:*     users:(("netdata",pid=1528,fd=38))

LISTEN    0      4096                   [::]:19999                [::]:*     users:(("netdata",pid=1528,fd=7))
```

### Mise en place d'un webhook discord et le configurer pour recevoir les alertes Netdata :

Puis j'ai crée un fichier health_alarm_notify.conf dans le dossier /etc/netdata/ et je l'ai configuré ansi que des alarmes personnalisées.

```bash
[ersjyhag@web netdata]$ sudo touch health_alarm_notify.conf
[ersjyhag@web netdata]$ sudo ./edit-config health_alarm_notify.conf
Editing '/etc/netdata/health_alarm_notify.conf' ...
[ersjyhag@web netdata]$ sudo netdatacli reload-health
[ersjyhag@web netdata]$ cat health_alarm_notify.conf
# enable/disable sending discord notifications
SEND_DISCORD="YES"

# Create a webhook by following the official documentation -
# https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks
DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/1042859032446251158/9lKtPTjwpFZR1T5Omk92uLMv1t0ZQOJXklyQEbhCaMi_ZIh-j8anlxgdAmStnAjNSZAz"

# if a role's recipients are not configured, a notification will be send to
# this discord channel (empty = do not send a notification for unconfigured
# roles):
DEFAULT_RECIPIENT_DISCORD="alertes"

role_recipients_discord[ALARME]="alertes"
[ersjyhag@web netdata]$ sudo touch health.d/cpu.conf
[ersjyhag@web netdata]$ sudo ./edit-config health.d/cpu.conf
Editing '/etc/netdata/health.d/cpu.conf' ...
[ersjyhag@web netdata]$ cat health.d/cpu.conf
template: 10min_cpu_usage
      on: system.cpu
      os: linux
   hosts: *
  lookup: average -10m unaligned of user,system,softirq,irq,guest
   units: %
   every: 1m
    warn: $this > (($status >= $WARNING)  ? (75) : (85))
    crit: $this > (($status == $CRITICAL) ? (85) : (95))
   delay: down 15m multiplier 1.5 max 1h
    info: average cpu utilization for the last 10 minutes (excluding iowait, nice and steal)
      to: sysadmin
[ersjyhag@web netdata]$ sudo touch health.d/ram-usage.conf
[ersjyhag@web netdata]$ sudo ./edit-config health.d/ram-usage.conf
Editing '/etc/netdata/health.d/ram-usage.conf' ...
[ersjyhag@web netdata]$ cat health.d/ram-usage.conf
 alarm: ram_usage
    on: system.ram
lookup: average -1m percentage of used
 units: %
 every: 1m
  warn: $this > 80
  crit: $this > 90
  info: The percentage of RAM being used by the system.
[ersjyhag@web netdata]$ sudo netdatacli reload-health
```

### Test :

Et enfin j'ai utilisé les test de base et j'ai également test avec un commande stress pour savoir si mes alartes marchait d'abord si elles étaients fictives mais aussi réelles.

```bash
[ersjyhag@web netdata]$ sudo su -s /bin/bash netdata
bash-5.1$ /usr/libexec/netdata/plugins.d/alarm-notify.sh test

# SENDING TEST WARNING ALARM TO ROLE: sysadmin
2022-11-18 09:20:02: alarm-notify.sh: INFO: sent discord notification for: web.tp2.b2 test.chart.test_alarm is WARNING to 'alertes'
# OK

# SENDING TEST CRITICAL ALARM TO ROLE: sysadmin
2022-11-18 09:20:03: alarm-notify.sh: INFO: sent discord notification for: web.tp2.b2 test.chart.test_alarm is CRITICAL to 'alertes'
# OK

# SENDING TEST CLEAR ALARM TO ROLE: sysadmin
2022-11-18 09:20:03: alarm-notify.sh: INFO: sent discord notification for: web.tp2.b2 test.chart.test_alarm is CLEAR to 'alertes'
# OK
bash-5.1$ exit
exit
[ersjyhag@web netdata]$ sudo stress -m 1 --vm-bytes 1G --vm-keep
stress: info: [9457] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
```
![](https://i.imgur.com/ynRtczE.png)
![](https://i.imgur.com/d0okzIl.png)

## Module 7 : Fail2Ban

```bash
[ersjyhag@db ~]$ dnf config-manager --set-enabled crb
Error: This command has to be run with superuser privileges (under the root user on most systems).
[ersjyhag@db ~]$ sudo !!
sudo dnf config-manager --set-enabled crb
[ersjyhag@db ~]$ sudo dnf install epel-release epel-next-release
Rocky Linux 9 - BaseOS                                                                  9.4 kB/s | 3.6 kB     00:00
Rocky Linux 9 - AppStream                                                                16 kB/s | 3.6 kB     00:00
Rocky Linux 9 - CRB                                                                     4.0 MB/s | 1.9 MB     00:00
No match for argument: epel-next-release
Error: Unable to find a match: epel-next-release
[ersjyhag@db ~]$ sudo dnf install epel-release
Last metadata expiration check: 0:00:24 ago on Mon 21 Nov 2022 11:17:13 AM CET.
Dependencies resolved.
========================================================================================================================
 Package                         Architecture              Version                      Repository                 Size
========================================================================================================================
Installing:
 epel-release                    noarch                    9-4.el9                      extras                     19 k

Transaction Summary
========================================================================================================================
Install  1 Package

Total download size: 19 k
Installed size: 25 k
Is this ok [y/N]: y
Downloading Packages:
epel-release-9-4.el9.noarch.rpm                                                         314 kB/s |  19 kB     00:00
------------------------------------------------------------------------------------------------------------------------
Total                                                                                    69 kB/s |  19 kB     00:00
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : epel-release-9-4.el9.noarch                                                                    1/1
  Running scriptlet: epel-release-9-4.el9.noarch                                                                    1/1
Many EPEL packages require the CodeReady Builder (CRB) repository.
It is recommended that you run /usr/bin/crb enable to enable the CRB repository.

  Verifying        : epel-release-9-4.el9.noarch                                                                    1/1

Installed:
  epel-release-9-4.el9.noarch

Complete!


[ersjyhag@web ~]$ sudo dnf install fail2ban -y
[sudo] password for ersjyhag:
Last metadata expiration check: 1:21:21 ago on Mon 21 Nov 2022 10:19:03 AM CET.
Dependencies resolved.
========================================================================================================================
 Package                            Architecture           Version                      Repository                 Size
========================================================================================================================
Installing:
 fail2ban                           noarch                 1.0.1-2.el9                  epel                      8.5 k
Installing dependencies:
 esmtp                              x86_64                 1.2-19.el9                   epel                       52 k
 fail2ban-firewalld                 noarch                 1.0.1-2.el9                  epel                      8.7 k
 fail2ban-sendmail                  noarch                 1.0.1-2.el9                  epel                       11 k
 fail2ban-server                    noarch                 1.0.1-2.el9                  epel                      442 k
 libesmtp                           x86_64                 1.0.6-24.el9                 epel                       66 k
 liblockfile                        x86_64                 1.14-9.el9                   appstream                  28 k
 python3-systemd                    x86_64                 234-18.el9                   baseos                     83 k

Transaction Summary
========================================================================================================================
Install  8 Packages

Total download size: 699 k
Installed size: 2.0 M
Downloading Packages:
(1/8): fail2ban-1.0.1-2.el9.noarch.rpm                                                  196 kB/s | 8.5 kB     00:00
(2/8): fail2ban-firewalld-1.0.1-2.el9.noarch.rpm                                        180 kB/s | 8.7 kB     00:00
(3/8): fail2ban-sendmail-1.0.1-2.el9.noarch.rpm                                         515 kB/s |  11 kB     00:00
(4/8): esmtp-1.2-19.el9.x86_64.rpm                                                      688 kB/s |  52 kB     00:00
(5/8): libesmtp-1.0.6-24.el9.x86_64.rpm                                                 1.2 MB/s |  66 kB     00:00
(6/8): fail2ban-server-1.0.1-2.el9.noarch.rpm                                           3.5 MB/s | 442 kB     00:00
(7/8): liblockfile-1.14-9.el9.x86_64.rpm                                                469 kB/s |  28 kB     00:00
(8/8): python3-systemd-234-18.el9.x86_64.rpm                                            738 kB/s |  83 kB     00:00
------------------------------------------------------------------------------------------------------------------------
Total                                                                                   591 kB/s | 699 kB     00:01
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                1/1
  Installing       : liblockfile-1.14-9.el9.x86_64                                                                  1/8
  Installing       : python3-systemd-234-18.el9.x86_64                                                              2/8
  Installing       : fail2ban-server-1.0.1-2.el9.noarch                                                             3/8
  Running scriptlet: fail2ban-server-1.0.1-2.el9.noarch                                                             3/8
  Installing       : fail2ban-firewalld-1.0.1-2.el9.noarch                                                          4/8
  Installing       : libesmtp-1.0.6-24.el9.x86_64                                                                   5/8
  Installing       : esmtp-1.2-19.el9.x86_64                                                                        6/8
  Running scriptlet: esmtp-1.2-19.el9.x86_64                                                                        6/8
  Installing       : fail2ban-sendmail-1.0.1-2.el9.noarch                                                           7/8
  Installing       : fail2ban-1.0.1-2.el9.noarch                                                                    8/8
  Running scriptlet: fail2ban-1.0.1-2.el9.noarch                                                                    8/8
  Verifying        : esmtp-1.2-19.el9.x86_64                                                                        1/8
  Verifying        : fail2ban-1.0.1-2.el9.noarch                                                                    2/8
  Verifying        : fail2ban-firewalld-1.0.1-2.el9.noarch                                                          3/8
  Verifying        : fail2ban-sendmail-1.0.1-2.el9.noarch                                                           4/8
  Verifying        : fail2ban-server-1.0.1-2.el9.noarch                                                             5/8
  Verifying        : libesmtp-1.0.6-24.el9.x86_64                                                                   6/8
  Verifying        : python3-systemd-234-18.el9.x86_64                                                              7/8
  Verifying        : liblockfile-1.14-9.el9.x86_64                                                                  8/8

Installed:
  esmtp-1.2-19.el9.x86_64                 fail2ban-1.0.1-2.el9.noarch           fail2ban-firewalld-1.0.1-2.el9.noarch
  fail2ban-sendmail-1.0.1-2.el9.noarch    fail2ban-server-1.0.1-2.el9.noarch    libesmtp-1.0.6-24.el9.x86_64
  liblockfile-1.14-9.el9.x86_64           python3-systemd-234-18.el9.x86_64

Complete!

[ersjyhag@web /]$ sudo find -name "nextcloud.log"
./var/www/tp2_nextcloud/data/nextcloud.log
[ersjyhag@web /]$ cd /etc/fail2ban/filter.d/
[ersjyhag@web filter.d]$ sudo nano nextcloud.conf
[ersjyhag@web filter.d]$ cat nextcloud.conf
[Definition]
_groupsre = (?:(?:,?\s*"\w+":(?:"[^"]+"|\w+))*)
failregex = ^\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Login failed:
            ^\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Trusted domain error.
datepattern = ,?\s*"time"\s*:\s*"%%Y-%%m-%%d[T ]%%H:%%M:%%S(%%z)?"
[ersjyhag@web filter.d]$ cd ..
[ersjyhag@web fail2ban]$ cd jail.d/
[ersjyhag@web jail.d]$ sudo nano nextcloud.local
[ersjyhag@web jail.d]$ cat nextcloud.local
[nextcloud]
backend = auto
enabled = true
port = 80,443
protocol = tcp
filter = nextcloud
maxretry = 3
bantime = 86400
findtime = 43200
logpath = ./var/www/tp2_nextcloud/data/nextcloud.log
[ersjyhag@web /]$ sudo systemctl restart fail2ban
```

```bash
[ersjyhag@db etc]$ systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
     Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-11-21 09:01:17 CET; 3h 19min ago
       Docs: man:firewalld(1)
   Main PID: 643 (firewalld)
      Tasks: 2 (limit: 5907)
     Memory: 39.5M
        CPU: 350ms
     CGroup: /system.slice/firewalld.service
             └─643 /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid

Nov 21 09:01:17 db.tp2.b2 systemd[1]: Starting firewalld - dynamic firewall daemon...
Nov 21 09:01:17 db.tp2.b2 systemd[1]: Started firewalld - dynamic firewall daemon.
[ersjyhag@db etc]$ sudo dnf install epel-release -y
[sudo] password for ersjyhag:
Last metadata expiration check: 0:56:07 ago on Mon 21 Nov 2022 11:24:50 AM CET.
Package epel-release-9-4.el9.noarch is already installed.
Dependencies resolved.
Nothing to do.
Complete!
[ersjyhag@db etc]$ sudo dnf install fail2ban fail2ban-firewalld -y
Last metadata expiration check: 0:56:32 ago on Mon 21 Nov 2022 11:24:50 AM CET.
Package fail2ban-1.0.1-2.el9.noarch is already installed.
Package fail2ban-firewalld-1.0.1-2.el9.noarch is already installed.
Dependencies resolved.
Nothing to do.
Complete!
[ersjyhag@db etc]$ sudo systemctl start fail2ban
[ersjyhag@db etc]$ sudo systemctl enable fail2ban
Created symlink /etc/systemd/system/multi-user.target.wants/fail2ban.service → /usr/lib/systemd/system/fail2ban.service.
[ersjyhag@db etc]$ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
[ersjyhag@db etc]$ sudo nano /etc/fail2ban/jail.local
# le fichier est beaucoup trop long pour être cat
[ersjyhag@db etc]$ sudo mv /etc/fail2ban/jail.d/00-firewalld.conf  /etc/fail2ban/jail.d/00-firewalld.local
[ersjyhag@db etc]$ sudo systemctl restart fail2ban
[ersjyhag@db etc]$ sudo nano /etc/fail2ban/jail.d/sshd.local
[ersjyhag@db etc]$ cat /etc/fail2ban/jail.d/sshd.local
[sshd]

enable = true

bantime = 1d
maxretry = 3
[ersjyhag@db etc]$ sudo systemctl restart fail2ban
```
```bash
[ersjyhag@web /]$ ssh ersjyhag@10.102.1.12
The authenticity of host '10.102.1.12 (10.102.1.12)' can't be established.
ED25519 key fingerprint is SHA256:p0bjVU3K5uTUThvAIPnQ0pIB1fse+dtFVrO3cycTpm4.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.102.1.12' (ED25519) to the list of known hosts.
ersjyhag@10.102.1.12's password:
Permission denied, please try again.
ersjyhag@10.102.1.12's password:
Permission denied, please try again.
ersjyhag@10.102.1.12's password:
ersjyhag@10.102.1.12: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).
```

EN COURS D'AVANCEMENT