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
[ersjyhag@web netdata]$ cat health.d/ram-usage.conf
 alarm: ram_usage
    on: system.ram
lookup: average -1m percentage of used
 units: %
 every: 1m
  warn: $this > 80
  crit: $this > 90
  info: The percentage of RAM being used by the system.
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
