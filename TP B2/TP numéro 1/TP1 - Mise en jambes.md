# TP1 - Mise en jambes

# I. Exploration locale en solo

## 1. Affichage d'informations sur la pile TCP/IP locale

**🌞 Affichez les infos des cartes réseau de votre PC**
```bash
PS C:\Users\Utilisateur> ipconfig /all
Carte Ethernet Ethernet :

   Statut du média. . . . . . . . . . . . : Média déconnecté
   Description. . . . . . . . . . . . . . : Realtek PCIe 2.5GbE Family Controller
   Adresse physique . . . . . . . . . . . : 2C-F0-5D-73-84-38
   
Carte réseau sans fil Wi-Fi :

    Adresse physique . . . . . . . . . . . : 3C-58-C2-FB-BF-2B
    Description. . . . . . . . . . . . . . : Intel(R) Wi-Fi 6 AX201 160MHz
    Adresse IPv4. . . . . . . . . . . . . .: 192.168.1.33(préféré)
``` 
Comme je n'ai rien branché sur mon port ethernet il n'y a pas d'adresse ip.

**🌞 Affichez votre gateway**

```bash
PS C:\Users\Utilisateur> ipconfig /all
Carte réseau sans fil Wi-Fi :

   Passerelle par défaut. . . . . . . . . : fe80::6235:c0ff:feca:3c58%7
```

**🌞 Trouvez comment afficher les informations sur une carte IP (change selon l'OS)**

![](https://i.imgur.com/zRhqbvQ.png)

**🌞 à quoi sert la gateway dans le réseau d'YNOV**

La gateway va nous servir a faire le lien avec internet....

## 2. Modifications des informations

### A. Modification d'adresse IP (part 1) 

🌞 Utilisez l'interface graphique de votre OS pour **changer d'adresse IP** : 

![](https://i.imgur.com/yjNWL0r.png)
![](https://i.imgur.com/g4h41zI.png)
![](https://i.imgur.com/SeutE1X.png)

🌞 **Il est possible que vous perdiez l'accès internet.** Que ce soit le cas ou non, expliquez pourquoi c'est possible de perdre son accès internet en faisant cette opération.

J'ai perdu mon accès à internet puisqu'au même moment un autre utilisateur était déjà connecté sur l'ip 192.168.1.34 donc mon routeur ayant détecté deux personnes sur la même ip il a envoyé toutes les requêtes que j'envoyais à la première personne qui avait l'ip.

# II. Exploration locale en duo!

Ben voilà la partie la plus intéréssante car comme je suis une grosse merde et que je suis pas quelqu'un ayant une apparence gentil, personne ne s'était mis avec moi de plus en plus de problème énorme de sociabilisation avec en plus une abscence le mercredi 28/09 ben j'ai pas pu faire cette partie et je suis totalement incapable d'aller vers les autres pour même juste leurs demander de m'expliquer le cours ou bien la partie 2 de ce tp.

# III. Manipulations d'autres outils/protocoles côté client

## 1. DHCP

🌞Exploration du DHCP, depuis votre PC

Alors ben là aussi c'est compliqué parce que je suis pas à Ynov donc pour obtenir l'ip du DHCP d'Ynov un peu compliqué cette histoire. Néanmoins je pense savoir ou la trouver :

![](https://i.imgur.com/2BE56VE.png)

On peut y voir l'adresse du DHCP mais aussi sa date d'expiration.

## 2. DNS

- 🌞 trouver l'adresse IP du serveur DNS que connaît votre ordinateur

![](https://i.imgur.com/3kuA13z.png)

- 🌞 utiliser, en ligne de commande l'outil `nslookup` (Windows, MacOS) ou `dig` (GNU/Linux, MacOS) pour faire des requêtes DNS à la main

![](https://i.imgur.com/Isex9NS.png)

Pour google et ynov la première address est l'ip du dns par contre les autres dsl mais jsp ;-;

![](https://i.imgur.com/BMf0yZv.png)

Dans le cas où un site fonctionnel (serveur allumé) la commande va nous renvoyer comme dans le cas 1 un url par contre dans le cas 2 92.146.54.88 aucun site correspondant à cette ip à été trouvé.

# IV. Wireshark