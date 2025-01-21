# Objectif

Construire une image de base avec un système linux et un <ins>service ssh</ins> pour une prise de controle à distance.
L'installation d'outils basique pour la gestion et sur l'utilisation du reseaux seront installés.

# Dockerfile
Le fichier est édité avec VScode et le module docker.
* Utilisation de la debian latest
* Mise a jour de la distribution
* Installation des outils : sudo htop mc bash sed tzdata
* Installation des outils reseaux : iputils-ping iproute2 traceroute dnsutils iperf
* Installation des services : openssh-server
* Nettoyage des fichiers inutiles pour "asseptiser" l'image
* Modification des options du service ssh
* Ajout d'un utilisateur
* Utilisation d'un script pour modifcation de la zone ( peut etre simplifié avec un RUN)
* Declaration du port
* Execution du service en mode daemon
* Déclaration de la clé publique pour ssh

# Build



# Docker-desktop
L'interface permet entre autre :
* de voir les logs
* de prendre la main sur le système
* d'inspecer les fichiers modifiés
* etc ...
  
![Docker-desktop](https://github.com/teon85/dockerise/blob/main/docker-desktop.png)
