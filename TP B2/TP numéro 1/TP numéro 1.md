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

![]()

**🌞 à quoi sert la gateway**