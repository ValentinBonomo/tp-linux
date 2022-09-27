# **TP6**

## **Partie 1 :**
### **I. Ajout de disque**
🌞 **Ajouter un disque dur de 5Go à la VM**
```bash=
[eulamawaifu@backup ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0    8G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0    7G  0 part
  ├─rl-root 253:0    0  6.2G  0 lvm  /
  └─rl-swap 253:1    0  820M  0 lvm  [SWAP]
sdb           8:16   0    5G  0 disk
sr0          11:0    1 1024M  0 rom
[eulamawaifu@backup ~]$ lsblk | grep 5G
sdb           8:16   0    5G  0 disk
```
### **II. Partitioning**
🌞 **Partitionner le disque à l'aide de LVM**
```bash=
[eulamawaifu@backup ~]$ sudo pvcreate /dev/sdb
  Physical volume "/dev/sdb" successfully created.
[eulamawaifu@backup ~]$ sudo pvs
  PV         VG Fmt  Attr PSize  PFree
  /dev/sda2  rl lvm2 a--  <7.00g    0
  /dev/sdb      lvm2 ---   5.00g 5.00g
[eulamawaifu@backup ~]$ sudo pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               rl
  PV Size               <7.00 GiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              1791
  Free PE               0
  Allocated PE          1791
  PV UUID               XqSA7e-uTrx-Kb7C-SBde-JdSN-DSgs-GXd2P1

  "/dev/sdb" is a new physical volume of "5.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb
  VG Name
  PV Size               5.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               ZEsMZR-jO1d-K2Hs-F3DN-euTm-SOP8-meBIxD
[eulamawaifu@backup ~]$ sudo vgcreate backup /dev/sdb
  Volume group "backup" successfully created
[eulamawaifu@backup ~]$ sudo lvcreate -L 1279 backup -n data
  Rounding up size to full physical extent 1.25 GiB
  Logical volume "data" created.
[eulamawaifu@backup ~]$ sudo lvs
  LV   VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  data backup -wi-a-----   1.25g
  root rl     -wi-ao----  <6.20g
  swap rl     -wi-ao---- 820.00m
[eulamawaifu@backup ~]$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/backup/data
  LV Name                data
  VG Name                backup
  LV UUID                aSLQ8W-NI2a-ZMHx-req1-51sT-wzfb-ydd1Xl
  LV Write Access        read/write
  LV Creation host, time backup.tp6.linux, 2021-11-30 11:59:29 +0100
  LV Status              available
  # open                 0
  LV Size                1.25 GiB
  Current LE             320
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:2

  --- Logical volume ---
  LV Path                /dev/rl/swap
  LV Name                swap
  VG Name                rl
  LV UUID                2IqGGP-L8HQ-K1ts-Ihmy-C7Zl-62Zr-lvAGqm
  LV Write Access        read/write
  LV Creation host, time localhost, 2021-11-23 10:29:24 +0100
  LV Status              available
  # open                 2
  LV Size                820.00 MiB
  Current LE             205
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/rl/root
  LV Name                root
  VG Name                rl
  LV UUID                kRAyxs-8SdA-rhUO-I4Fa-woVC-CVBv-E6hCwp
  LV Write Access        read/write
  LV Creation host, time localhost, 2021-11-23 10:29:25 +0100
  LV Status              available
  # open                 1
  LV Size                <6.20 GiB
  Current LE             1586
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0
```
🌞 **Formater la partition**
```bash=
[eulamawaifu@backup ~]$ sudo mkfs -t ext4 /dev/backup/data
[sudo] password for eulamawaifu:
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 327680 4k blocks and 81920 inodes
Filesystem UUID: f4ab57fb-c6bf-4660-a03c-58b89ff4f842
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done
```
🌞 **Monter la partition**
```bash=
[eulamawaifu@backup ~]$ sudo mkdir /backup
[eulamawaifu@backup ~]$ sudo mount /dev/backup/data /backup/
[eulamawaifu@backup ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 387M     0  387M   0% /dev
tmpfs                    405M     0  405M   0% /dev/shm
tmpfs                    405M  5.6M  400M   2% /run
tmpfs                    405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root      6.2G  2.2G  4.1G  35% /
/dev/sda1               1014M  266M  749M  27% /boot
tmpfs                     81M     0   81M   0% /run/user/1000
/dev/mapper/backup-data  1.2G  3.8M  1.2G   1% /backup
[eulamawaifu@backup ~]$ sudo ls -l /dev/backup/
total 0
lrwxrwxrwx. 1 root root 7 Dec  3 10:53 data -> ../dm-2
[eulamawaifu@backup ~]$ sudo nano /etc/fstab
[eulamawaifu@backup ~]$ sudo umount /backup
[eulamawaifu@backup ~]$ sudo mount -av
/                        : ignored
/boot                    : already mounted
none                     : ignored
mount: /backup does not contain SELinux labels.
       You just mounted an file system that supports labels which does not
       contain labels, onto an SELinux box. It is likely that confined
       applications will generate AVC messages and not be allowed access to
       this file system.  For more details see restorecon(8) and mount(8).
/backup                  : successfully mounted
[eulamawaifu@backup ~]$ sudo reboot
[eulamawaifu@backup ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 387M     0  387M   0% /dev
tmpfs                    405M     0  405M   0% /dev/shm
tmpfs                    405M  5.6M  400M   2% /run
tmpfs                    405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root      6.2G  2.2G  4.1G  35% /
/dev/sda1               1014M  266M  749M  27% /boot
/dev/mapper/backup-data  4.8G   20M  4.5G   1% /backup
tmpfs                     81M     0   81M   0% /run/user/1000
```
## III Bonus

```bash=
[eulamawaifu@backup ~]$ lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda             8:0    0    8G  0 disk
├─sda1          8:1    0    1G  0 part /boot
└─sda2          8:2    0    7G  0 part
  ├─rl-root   253:0    0  6.2G  0 lvm  /
  └─rl-swap   253:1    0  820M  0 lvm  [SWAP]
sdb             8:16   0    5G  0 disk
└─backup-data 253:2    0  4.9G  0 lvm  /backup
sdc             8:32   0    5G  0 disk
sr0            11:0    1 1024M  0 rom
[eulamawaifu@backup ~]$ sudo pvcreate /dev/sdc
[sudo] password for eulamawaifu:
  Physical volume "/dev/sdc" successfully created.
[eulamawaifu@backup ~]$ sudo pvs
  PV         VG     Fmt  Attr PSize  PFree
  /dev/sda2  rl     lvm2 a--  <7.00g     0
  /dev/sdb   backup lvm2 a--  <5.00g 96.00m
  /dev/sdc          lvm2 ---   5.00g  5.00g
[eulamawaifu@backup ~]$ sudo vgextend backup /dev/sdc
  Volume group "backup" successfully extended
[eulamawaifu@backup ~]$ sudo vgs
  VG     #PV #LV #SN Attr   VSize  VFree
  backup   2   1   0 wz--n-  9.99g <5.09g
  rl       1   2   0 wz--n- <7.00g     0
[eulamawaifu@backup ~]$ sudo lvextend -L 9.8G /dev/backup/data
  Rounding size to boundary between physical extents: 9.80 GiB.
  Size of logical volume backup/data changed from 4.90 GiB (1255 extents) to 9.80 GiB (2509 extents).
  Logical volume backup/data successfully resized.
[eulamawaifu@backup ~]$ sudo umount /backup
[eulamawaifu@backup ~]$ sudo mkfs -t ext4 /dev/backup/data
mke2fs 1.45.6 (20-Mar-2020)
/dev/backup/data contains a ext4 file system
        last mounted on Fri Dec  3 11:12:33 2021
Proceed anyway? (y,N) y
Creating filesystem with 2569216 4k blocks and 643376 inodes
Filesystem UUID: 3ce2755a-3b29-4be6-9c5b-adcf8f17d6d1
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
[eulamawaifu@backup ~]$ sudo mount -av
/                        : ignored
/boot                    : already mounted
none                     : ignored
mount: /backup does not contain SELinux labels.
       You just mounted an file system that supports labels which does not
       contain labels, onto an SELinux box. It is likely that confined
       applications will generate AVC messages and not be allowed access to
       this file system.  For more details see restorecon(8) and mount(8).
/backup                  : successfully mounted
[eulamawaifu@backup ~]$ sudo reboot
[eulamawaifu@backup ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 387M     0  387M   0% /dev
tmpfs                    405M     0  405M   0% /dev/shm
tmpfs                    405M  5.6M  400M   2% /run
tmpfs                    405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root      6.2G  2.2G  4.1G  35% /
/dev/sda1               1014M  266M  749M  27% /boot
/dev/mapper/backup-data  9.6G   37M  9.1G   1% /backup
tmpfs                     81M     0   81M   0% /run/user/1000
```
## **Partie 2**
🌞 **Préparer les dossiers à partager**
```bash=
[eulamawaifu@backup ~]$ sudo mkdir /backup/web.tp6.linux
[eulamawaifu@backup ~]$ sudo mkdir /backup/db.tp6.linux
[eulamawaifu@backup ~]$ sudo ls /backup/
db.tp6.linux  lost+found  web.tp6.linux
```
🌞 **Install du serveur NFS**
```bash=
[eulamawaifu@backup ~]$ sudo dnf install -q nfs-utils
Is this ok [y/N]: y

Installed:
  gssproxy-0.8.0-19.el8.x86_64           keyutils-1.5.10-9.el8.x86_64        libverto-libevent-0.3.0-5.el8.x86_64
  nfs-utils-1:2.3.3-46.el8.x86_64        rpcbind-1.2.5-8.el8.x86_64
```
🌞 **Conf du serveur NFS**
```bash=
[eulamawaifu@backup ~]$ sudo nano /etc/idmapd.conf
[eulamawaifu@backup ~]$ sudo cat /etc/idmapd.conf | grep Domain
Domain = tp6.linux
# the old method (comparing the domain in the string to the Domain value,
[eulamawaifu@backup ~]$ sudo nano /etc/exports
[eulamawaifu@backup ~]$ sudo cat /etc/exports
[sudo] password for eulamawaifu:
/backup/web.tp6.linux 10.5.1.11(rw,no_root_squash)
/backup/db.tp6.linux 10.5.1.12(rw,no_root_squash)
```
L'option rw permet d'exporter avec les droits de lecture et d'écriture.
L'option no_root_squash spécifie que le root de la machine sur laquelle le répertoire est monté a les droits de root sur le répertoire

🌞 **Démarrez le service**
```bash=
[eulamawaifu@backup ~]$ sudo systemctl start nfs-server.service
[eulamawaifu@backup ~]$ sudo systemctl status nfs-server.service
● nfs-server.service - NFS server and services
   Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; disabled; vendor preset: disabled)
  Drop-In: /run/systemd/generator/nfs-server.service.d
           └─order-with-mounts.conf
   Active: active (exited) since Fri 2021-12-03 11:49:41 CET; 12s ago
  Process: 1665 ExecStart=/bin/sh -c if systemctl -q is-active gssproxy; then systemctl reload gssproxy ; fi (code=exit>
  Process: 1653 ExecStart=/usr/sbin/rpc.nfsd (code=exited, status=0/SUCCESS)
  Process: 1652 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)
 Main PID: 1665 (code=exited, status=0/SUCCESS)

Dec 03 11:49:41 backup.tp6.linux systemd[1]: Starting NFS server and services...
Dec 03 11:49:41 backup.tp6.linux systemd[1]: Started NFS server and services.
[eulamawaifu@backup ~]$ sudo systemctl enable nfs-server.service
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-server.service → /usr/lib/systemd/system/nfs-server.service.
```
🌞 **Firewall**
```bash=
[eulamawaifu@backup ~]$ sudo firewall-cmd --add-port=2049/tcp --permanent
success
[eulamawaifu@backup ~]$ sudo firewall-cmd --reload
success
[eulamawaifu@backup ~]$ sudo ss -lntap | grep 2049
LISTEN 0      64           0.0.0.0:2049       0.0.0.0:*
LISTEN 0      64              [::]:2049          [::]:*
```

## **Partie 3**

SUR LA WEB.TP6.LINUX
🌞 **Install'**
```bash=
[eulamawaifu@web ~]$ sudo dnf install -q nfs-utils
[sudo] password for eulamawaifu:
Is this ok [y/N]: y

Installed:
  gssproxy-0.8.0-19.el8.x86_64           keyutils-1.5.10-9.el8.x86_64        libverto-libevent-0.3.0-5.el8.x86_64
  nfs-utils-1:2.3.3-46.el8.x86_64        rpcbind-1.2.5-8.el8.x86_64
[eulamawaifu@web ~]$ sudo mkdir /srv/backup
```
🌞 **Conf'**
```bash=
[eulamawaifu@web ~]$ sudo  nano /etc/idmapd.conf
[sudo] password for eulamawaifu:
[eulamawaifu@web ~]$ [eulamawaifu@web ~]$ sudo cat /etc/idmapd.conf | grep Domain
Domain = tp6.linux
# the old method (comparing the domain in the string to the Domain value,
[eulamawaifu@web ~]$ sudo reboot
[eulamawaifu@web ~]$ sudo mount -t nfs 10.5.1.13:/backup/web.tp6.linux/ /srv/backup
[sudo] password for eulamawaifu:
[eulamawaifu@web ~]$ df -h
Filesystem                       Size  Used Avail Use% Mounted on
devtmpfs                         387M     0  387M   0% /dev
tmpfs                            405M     0  405M   0% /dev/shm
tmpfs                            405M  5.6M  400M   2% /run
tmpfs                            405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root              6.2G  3.5G  2.7G  57% /
/dev/sda1                       1014M  266M  749M  27% /boot
tmpfs                             81M     0   81M   0% /run/user/1000
10.5.1.13:/backup/web.tp6.linux  9.6G   36M  9.1G   1% /srv/backup
[eulamawaifu@web ~]$ sudo ls -l /srv/ | grep backup
drwxr-xr-x. 2 root root 4096 Dec  3 11:30 backup
[eulamawaifu@web ~]$ sudo nano /etc/fstab
[eulamawaifu@web ~]$ sudo tail -n 1 /etc/fstab
[sudo] password for eulamawaifu:
10.5.1.13:/backup/web.tp6.linux/ /srv/backup nfs defaults 0 0
[eulamawaifu@web ~]$ sudo reboot
[eulamawaifu@web ~]$ df -h
Filesystem                       Size  Used Avail Use% Mounted on
devtmpfs                         387M     0  387M   0% /dev
tmpfs                            405M     0  405M   0% /dev/shm
tmpfs                            405M  5.6M  400M   2% /run
tmpfs                            405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root              6.2G  3.5G  2.7G  57% /
/dev/sda1                       1014M  266M  749M  27% /boot
10.5.1.13:/backup/web.tp6.linux  9.6G   36M  9.1G   1% /srv/backup
tmpfs                             81M     0   81M   0% /run/user/1000
```

🌞 **Répétez les opérations sur db.tp6.linux**

```bash=
[eulamawaifu@db ~]$ sudo ls -l /srv/ | grep backup
drwxr-xr-x. 2 root root 4096 Dec  3 11:30 backup
[eulamawaifu@db ~]$ df -h
Filesystem                      Size  Used Avail Use% Mounted on
devtmpfs                        387M     0  387M   0% /dev
tmpfs                           405M     0  405M   0% /dev/shm
tmpfs                           405M  5.6M  400M   2% /run
tmpfs                           405M     0  405M   0% /sys/fs/cgroup
/dev/mapper/rl-root             6.2G  2.6G  3.7G  41% /
/dev/sda1                      1014M  266M  749M  27% /boot
10.5.1.13:/backup/db.tp6.linux  9.6G   36M  9.1G   1% /srv/backup
tmpfs                            81M     0   81M   0% /run/user/1000
[eulamawaifu@db ~]$ sudo tail -n 1 /etc/fstab
[sudo] password for eulamawaifu:
10.5.1.13:/backup/db.tp6.linux/ /srv/backup nfs defaults 0 0
```

## **Partie 4**

### **I. Sauvegarde Web**


🌞 **Ecrire un script qui sauvegarde les données de NextCloud**

Script : 

```bash=
[eulamawaifu@web /]$ cd /
[eulamawaifu@web /]$  mkdir /var/log/backup
[eulamawaifu@web /]$ sudo nano /var/log/backup/backup.log
[eulamawaifu@web /]$ sudo nano /srv/save.sh
[eulamawaifu@web /]$ sudo cat /srv/save.sh
#!/bin/bash

name=("/srv/backup/nexcloud_$(date +"%y%m%d_%H%m%S").tar.gz")
cd /var/www/
/usr/bin/tar -czvf "$name" nextcloud/ &> /dev/null

echo "Backup "$name" created successfully."

log_prefix=$(date +"[%y/%m/%d %H:%m:%S]")
log_line="${log_prefix} Backup "$name" created successfully."
echo "${log_line}" >> /var/log/backup/backup.log
```

🌞 **Créer un service et Créer un timer**
J'ai eu la flemme de séparer dans le markdown sachant que je l'avais fait en une fois sur ma vm.
```bash=
[eulamawaifu@web /]$ sudo nano /etc/systemd/system/backup.service
[eulamawaifu@web /]$ sudo cat /etc/systemd/seystem/backup.service
[Unit]
Description=Sauvergarde de données

[Service]
ExecStart=/usr/bin/bash /srv/save.sh
Type=oneshot

[Install]
WantedBy=multi-user.target
[eulamawaifu@web /]$ sudo nano /etc/systemd/system/backup.timer
[eulamawaifu@web /]$ sudo cat /etc/systemd/system/backup.timer
[Unit]
Description=Time Time (une pepene)
Requires=backup.service

[Timer]
Unit=backup.service
OnCalendar=hourly

[Install]
WantedBy=timers.target
[eulamawaifu@web /]$ sudo systemctl daemon-reload
[eulamawaifu@web /]$ sudo systemctl start backup.timer
[eulamawaifu@web /]$ sudo systemctl enable backup.timer
Created symlink /etc/systemd/system/timers.target.wants/backup.timer → /etc/systemd/system/backup.timer.
[eulamawaifu@web /]$ sudo systemctl list-timers | grep backup
Mon 2021-12-06 12:30:31 CET  35min left   n/a                          n/a          backup.timer              backup.service
```
🌞 **Vérifier que vous êtes capables de restaurer les données**
```bash=
[eulamawaifu@web /]$ ls /srv/backup
nexcloud_211206_123135.tar.gz
[eulamawaifu@web /]$ cat /var/log/backup/backup.log
[21/12/06 12:31:35] Backup /srv/backup/nexcloud_211206_123135.tar.gz created successfully.
```
### **II. Sauvegarde base de données**

🌞 **Ecrire un script qui sauvegarde les données de la base de données MariaDB**

```bash=
[eulamawaifu@db ~]$ sudo nano /var/log/backup/backupdb.log
[eulamawaifu@db ~]$ sudo nano /srv/savedb.sh
[eulamawaifu@db ~]$ sudo cat /srv/savedb.sh
#!/bin/bash

name=("/srv/backup/nextcloud_db_$(date +"%y%m%d_%H%m%S").tar.gz")

/usr/bin/mysqldump -u root -pdbc nextcloud > /tmp/nextcloud.sql

/usr/bin/cd /tmp/
/usr/bin/tar -czvf $name nextcloud.sql &> /dev/null
/usr/bin/rm /tmp/nextcloud.sql

/usr/bin/echo "Backup "$name" created successfully."

log_prefix=$(date +"[%y/%m/%d %H:%m:%S]")
log_line="${log_prefix} Backup "$name" created successfully."
/usr/bin/echo "${log_line}" >> /var/log/backup/backupdb.log
```

🌞 **Créer un service et Créer un timer**

```bash=
[eulamawaifu@db ~]$ sudo nano /etc/systemd/system/backupdb.service
[eulamawaifu@db ~]$ sudo cat /etc/systemd/system/backupdb.service
[Unit]
Description="Save nextcloud's database"

[Service]
ExecStart=/usr/bin/bash /srv/savedb.sh
Type=oneshot

[Install]
WantedBy=multi-user.target
[eulamawaifu@db ~]$ sudo nano /etc/systemd/system/backupdb.timer
[eulamawaifu@db ~]$ sudo cat /etc/systemd/system/backupdb.timer
[Unit]
Description=Automatisation du script (non je vais pas refaire la vanne)
Requires=backupdb.service

[Timer]
Unit=backupdb.service
OnCalendar=hourly

[Install]
WantedBy=timers.target
[eulamawaifu@db ~]$ sudo systemctl daemon-reload
[eulamawaifu@db ~]$ sudo systemctl start backupdb.timer
[eulamawaifu@db ~]$ sudo systemctl enable backupdb.timer
Created symlink /etc/systemd/system/timers.target.wants/backupdb.timer → /etc/systemd/system/backupdb.timer.
[eulamawaifu@db ~]$ sudo systemctl list-timers | grep backup
Fri 2021-12-06 14:00:00 CET  32min left   n/a                          n/a          backupdb.timer              backupdb.service
```
Le dernier tp était quand même stylé mais bon c'est le dernier quoi ;-;