# TP2 : Ethernet, IP, et ARP

# I. Setup IP

🌞 **Mettez en place une configuration réseau fonctionnelle entre les deux machines**

192.168.56.116/24 pour mon pc et 192.168.56.115/24 pour la VM
adresse réseau : 192.168.56.0
adresse de broadcast : 192.168.56.255

Pour change l'ip de ma VM j'ai utilisé

```bash
sudo ifconfig eth0 192.168.56.115 netmask 255.255.255.0 up
```

🌞 **Prouvez que la connexion est fonctionnelle entre les deux machines**

Depuis mon pc : 

```bash
C:\Users\Utilisateur>ping 192.168.56.115

Envoi d’une requête 'Ping'  192.168.56.115 avec 32 octets de données :
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 192.168.56.115:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```

🌞 **Wireshark it**

[`paquets`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%202/file/pingvm.pcapng)

# II. ARP my bro

🌞 **Check the ARP table**

```bash
PS C:\Windows\system32> arp -a

Interface : 192.168.1.34 --- 0x7
  Adresse Internet      Adresse physique      Type
  192.168.1.1           60-35-c0-ca-3c-58     dynamique
  192.168.1.255         ff-ff-ff-ff-ff-ff     statique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique
  239.255.255.250       01-00-5e-7f-ff-fa     statique

Interface : 192.168.56.116 --- 0xf
  Adresse Internet      Adresse physique      Type
  192.168.56.115        08-00-27-08-c7-e4     dynamique
  192.168.56.255        ff-ff-ff-ff-ff-ff     statique
  224.0.0.22            01-00-5e-00-00-16     statique
  224.0.2.60            01-00-5e-00-02-3c     statique
  239.255.255.250       01-00-5e-7f-ff-fa     statique
```
mac wifi : 60-35-c0-ca-3c-58 et mac vm : 08-00-27-08-c7-e4

🌞 **Manipuler la table ARP**

```bash
PS C:\Windows\system32> arp  -d
PS C:\Windows\system32> arp -a

Interface : 192.168.1.34 --- 0x7
  Adresse Internet      Adresse physique      Type
  192.168.1.1           60-35-c0-ca-3c-58     dynamique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique
  239.255.255.250       01-00-5e-7f-ff-fa     statique

Interface : 192.168.56.116 --- 0xf
  Adresse Internet      Adresse physique      Type
  224.0.0.22            01-00-5e-00-00-16     statique
  224.0.2.60            01-00-5e-00-02-3c     statique

PS C:\Windows\system32> ping 192.168.56.115

Envoi d’une requête 'Ping'  192.168.56.115 avec 32 octets de données :
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 192.168.56.115:
    Paquets : envoyés = 2, reçus = 2, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
Ctrl+C
PS C:\Windows\system32> arp -a

Interface : 192.168.1.34 --- 0x7
  Adresse Internet      Adresse physique      Type
  192.168.1.1           60-35-c0-ca-3c-58     dynamique
  192.168.1.255         ff-ff-ff-ff-ff-ff     statique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique
  239.255.255.250       01-00-5e-7f-ff-fa     statique

Interface : 192.168.56.116 --- 0xf
  Adresse Internet      Adresse physique      Type
  192.168.56.115        08-00-27-08-c7-e4     dynamique
  192.168.56.255        ff-ff-ff-ff-ff-ff     statique
  224.0.0.22            01-00-5e-00-00-16     statique
  224.0.2.60            01-00-5e-00-02-3c     statique
```

🌞 **Wireshark it**

```bash
PS C:\Windows\system32> ping 192.168.56.115

Envoi d’une requête 'Ping'  192.168.56.115 avec 32 octets de données :
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64
Réponse de 192.168.56.115 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 192.168.56.115:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```

[`Wireshark`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%202/file/arp.pcapng)

On peut observer que 192.168.56.116 soit la vm demande qui est .115, cette dernière va répondre en donnant son ip et sa mac. Puis .115 va faire l'inverse afin que .116 envoi sa mac et son ip.

# III. DHCP you too my brooo

🌞 **Wireshark it**

Franchement je sais pas si je suis bête (même si je pense qu'on a déjà la réponse) mais j'arrivais à récupérer sur Wireshark uniquement quand je changeais l'ip moi-même par contre quand je repassais en automatique (même avec la technique de se déco du réseau et de se reco après être revenu en auto) j'avais plus rien.

Mais bon à force d'essayer j'ai finalement réussi cependant je serai incapable de dire pourquoi cela ne fonctionnait pas.

[`DORA`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%202/file/DORA.pcapng)

# IV. Avant-goût TCP et UDP

🌞 **Wireshark it**

[`Youtube`](https://github.com/ValentinBonomo/tp-linux/blob/main/TP%20B2/TP%20numéro%202/file/youtube.pcapng)

La ligne qui se démarque et qui nous permet de récupérer l'ip c'est : 

```bash
3	0.161142	2a02:8428:7d0e:fd01:bc09:67fe:85ab:bf9a	2600:1900:4110:86f::	HTTP	429	GET /edgedl/release2/chrome_component/jidqkq3chldj4rszrmjnge4u5m_373/efniojlnjndmcbiieegkicadnoecjjef_373_all_mjjfnxpyh6h7gc4kx3jinlte3q.crx3 HTTP/1.1 
```
Destination Address: 2600:1900:4110:86f:: 

De plus grâce à Wireshark on sait que le port sur lequel mon pc se connecte quand il regarde youtube est le port 80.
(Bon je suis pas sûr de cette info car j'ai pas le temps de vérif si j'ai trouvé un truc faux ou pas au vu de l'heure)
