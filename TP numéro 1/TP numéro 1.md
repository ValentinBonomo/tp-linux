# TP numéro 1

### **Objectif global** : 
#### Apprendre à détruire une machine virtuel (5 façons différentes minimum)

#### **-- Première façon** :

Aller dans la configuration de la vm puis dans les disques durs et *supprimer le contrôleur SATA*

#### **-- Deuxième façon** :

*for i in {000001..015000}; do head -c 1M </dev/urandom >randfile$i; done*

Cette commande va servir pour 15000 fois à créer des fichier commançant par random suivie de nobre aléatoire afin de saturer l'espace de stockage pour bloquer la vm.

#### **-- Troisième façon** :

*sudo ls > /dev/sda*

Va rediriger la commande ls dans le disque dur, le pc va donc planter lors d'un reboot.

#### **-- Quatrième façon** : 


*sudo chown -R root:root /*

Grâce à cette commande tout les fichiers appartiennent à root ne permettant donc ni le lançement de la vm ni aucune modification.

#### **-- Cinquième façon** : 

*sudo rm -rf / --no-preserve-root*

Supprime tout simplement tout les fichiers existant sur la vm sans preserver le root.

#### **-- Sixième façon** :

*sudo dd if=/dev/zero of=/dev/sda*

Nettoye un perphiphérique ou lecteur, ici en l'occurence sda inque que c'est le disque dur qui sera formaté.

#### **-- Septième façon** :

*L'accès physique.*

Il reste en effet le meilleur moyen et le plus rapide de détruire une machine, par exemple en fracassant par terre le pc on est sur d'avoir tout détruit.

#### **-- Huitième façon (Incomplète)** :

*la fork bomb : 
:(){ :|:& };:*

Elle va s'utiliser récursivement à l'infini ce qui va bien sûr faire ralentir l'ordinateur. Cependant, cette méthode n'est pas complète car après un reboot la fork bomb ne sera plus active sur le pc. Le seul moyen de détruire le pc grâce à la fork bomb c'est de la lancer autaumatiquement au démarrage du pc. 

Pour cela j'ai essayé plusieurs manières comme celle ci-dessous mais sans succès : 

-- Créer un fichier en .sh et le lancer automatiquement via l'application Session et démarrage.

-- Dans le terminale en utilisant plusieurs commandes afin de la lancer automatiquement.