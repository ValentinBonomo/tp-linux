# TP 3 : A little script

## I. Script carte d'identité

[`/srv/idcard/idcard.sh`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20numéro%203/Partie%201/srv/idcard/idcard.sh)

### Exemple d'exécuition du programme : 

```bash=
root@node1:/srv/idcard# ./idcard.sh
Machine name :node1.tp2.linux
OSUbuntuand kernel version is5.13.0-21-generic
IP :192.168.56.103/24
RAM :1,5Go RAM restante sur1,9Go RAM totale
Disque :1,4Go space left
Top 5 processes by RAM usage :
-xfwm4 --replace
-/usr/lib/xorg/Xorg -core :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
-/usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2
-/usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2
-/usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2
Listening ports :
-53:systemd-resolve
-22:sshd
-631:cupsd
Here's your random cat :https://cdn2.thecatapi.com/images/UzFZizW9K.jpg
```

## II. Script youtube-dl

[`/srv/yt/yt.sh`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20numéro%203/Partie%202/srv/yt/yt.sh)
```bash=
root@node1:/srv/yt# ./yt.sh https://www.youtube.com/watch?v=j5a0jTc9S10
Video https://www.youtube.com/watch?v=j5a0jTc9S10 was downloaded.
File path : /srv/yt/downloads/Cute Little Puppy Doing Cute things/Cute Little Puppy Doing Cute things.mp4
```

## III. MAKE IT A SERVICE

[`/srv/yt/yt-v2.sh`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20numéro%203/Partie%203/srv/yt/yt-v2.sh)

[`/etc/systemd/system/yt.service`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20numéro%203/Partie%203/etc/systemd/system/yt.service)

```bash=
root@node1:/srv/yt# systemctl start yt
root@node1:/srv/yt# systemctl status yt
● yt.service - YoutubeDL
     Loaded: loaded (/etc/systemd/system/yt.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-11-23 00:04:20 CET; 2s ago
   Main PID: 2374 (sudo)
      Tasks: 4 (limit: 2314)
     Memory: 32.7M
        CPU: 949ms
     CGroup: /system.slice/yt.service
             ├─2374 sudo bash /srv/yt/yt-v2.sh
             ├─2375 bash /srv/yt/yt-v2.sh
             ├─2380 sudo youtube-dl -f mp4 -o Vidéo Courte et Drôle :) | #27.mp4 https://www.youtube.com/watch?v=9LzQimPV1t8
             └─2381 /usr/bin/python3 /usr/local/bin/youtube-dl -f mp4 -o Vidéo Courte et Drôle :) | #27.mp4 https://www.youtube.com/w>

nov. 23 00:04:20 node1.tp2.linux systemd[1]: Started YoutubeDL.
nov. 23 00:04:20 node1.tp2.linux sudo[2374]:     root : PWD=/ ; USER=root ; COMMAND=/usr/bin/bash /srv/yt/yt-v2.sh
nov. 23 00:04:20 node1.tp2.linux sudo[2374]: pam_unix(sudo:session): session opened for user root by (uid=0)
nov. 23 00:04:21 node1.tp2.linux sudo[2380]:     root : PWD=/srv/yt/downloads/Vidéo Courte et Drôle :) | #27 ; USER=root ; COMMAND=/u>
nov. 23 00:04:21 node1.tp2.linux sudo[2380]: pam_unix(sudo:session): session opened for user root by (uid=0)
```

```bash=
root@node1:/srv/yt# journalctl -xe -u yt
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ L'unité (unit) yt.service a terminé son démarrage, avec le résultat done.
nov. 23 00:03:16 node1.tp2.linux sudo[2358]:     root : PWD=/ ; USER=root ; COMMAND=/usr/bin/bash /srv/yt/yt-v2.sh
nov. 23 00:03:16 node1.tp2.linux sudo[2358]: pam_unix(sudo:session): session opened for user root by (uid=0)
nov. 23 00:03:16 node1.tp2.linux sudo[2359]: Please enter some url line by line in the file url.txt (path : /srv/yt/downloads/url.txt)
nov. 23 00:03:16 node1.tp2.linux sudo[2358]: pam_unix(sudo:session): session closed for user root
nov. 23 00:03:16 node1.tp2.linux systemd[1]: yt.service: Deactivated successfully.
░░ Subject: Unit succeeded
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ The unit yt.service has successfully entered the 'dead' state.
nov. 23 00:04:20 node1.tp2.linux systemd[1]: Started YoutubeDL.
░░ Subject: L'unité (unit) yt.service a terminé son démarrage
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ L'unité (unit) yt.service a terminé son démarrage, avec le résultat done.
nov. 23 00:04:20 node1.tp2.linux sudo[2374]:     root : PWD=/ ; USER=root ; COMMAND=/usr/bin/bash /srv/yt/yt-v2.sh
nov. 23 00:04:20 node1.tp2.linux sudo[2374]: pam_unix(sudo:session): session opened for user root by (uid=0)
nov. 23 00:04:21 node1.tp2.linux sudo[2380]:     root : PWD=/srv/yt/downloads/Vidéo Courte et Drôle :) | #27 ; USER=root ; COMMAND=/u>
nov. 23 00:04:21 node1.tp2.linux sudo[2380]: pam_unix(sudo:session): session opened for user root by (uid=0)
nov. 23 00:04:48 node1.tp2.linux sudo[2380]: pam_unix(sudo:session): session closed for user root
nov. 23 00:04:49 node1.tp2.linux sudo[2375]: Video https://www.youtube.com/watch?v=9LzQimPV1t8 was downloaded.
nov. 23 00:04:49 node1.tp2.linux sudo[2375]: File path : /srv/yt/downloads/Vidéo Courte et Drôle :) | #27/Vidéo Courte et Drôle :) | >
nov. 23 00:04:50 node1.tp2.linux sudo[2391]:     root : PWD=/srv/yt/downloads/Vidéo Courte et Drôle :) | #13 ; USER=root ; COMMAND=/u>
nov. 23 00:04:50 node1.tp2.linux sudo[2391]: pam_unix(sudo:session): session opened for user root by (uid=0)
```

```bash=
root@node1:/srv/yt# systemctl enable yt
```

## IV. Bonus

Pas eu le temps malhereusment ;-; :cry: 