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

# Build & Run
## Construction de l'image
Construire l'image avec le Dockerfile.
`docker build . -t debian-openssh`
* . stipule le dockerfile dans le même dossier
* -t tag de l'image

## Creation du container avec create
Création du container depuis l'image
`docker container create -i -t --expose 22 -h debssh --name debian-ssh debian-openssh `
* --dns		impose le serveur dns
* --dns-option		options dns
* --dns-search		le domaine search
* --domainname		nom du domaine de la machine
* -i, --interactive		garde un STDIN ouvert
* --expose	22	plublie un ou des port
* -h, --hostname		nom du container
* --ip		IPv4 address (e.g., 172.30.100.104)
* --ip6		IPv6 address (e.g., 2001:db8::33)
* --network		Connect a container to a network
* --network-alias		Add network-scoped alias for the container
* -t, --tty		affecte un pseudo TTY

## Creation du container avec run
Creation et execute le container avec mappage des ports
`docker run -it -d --name debian-ssh -p 8022:22 debian-openssh`
* -it shell intéractif
* -d detache le container
* -name nome le container
* -p 8022:22  mappe le localhost:8022 vers le 22 du container
* nom de l'image
* --rm
* --dns		impose le serveur dns
* --dns-option		options dns
* --dns-search		le domaine search
* --domainname		nom du domaine de la machine
* -i, --interactive		garde un STDIN ouvert
* -h, --hostname		nom du container
* --ip		IPv4 address (e.g., 172.30.100.104)
* --ip6		IPv6 address (e.g., 2001:db8::33)
* --network		Connecter vers un reseau
* --network-alias		Add network-scoped alias for the container
* -t, --tty		Affecte un pseudo TTY
* -p, --publish	Plublie un port expose
* -P, --publish-all	plublie tous les port vers des port aléatoire.

# Docker-desktop
L'interface permet entre autre :
* de voir les logs
* de prendre la main sur le système
* d'inspecer les fichiers modifiés
* etc ...
  
![Docker-desktop](https://github.com/teon85/dockerise/blob/main/docker-desktop.png)
