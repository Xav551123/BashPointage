# BashPointage

Le script precedent utilisé une usine a gaz pour une action tres simple. celui si utilise la commande curl qui est un client web simple en ligne de commande.

`which curl` pour verifier si il est bien sur votre machine sinon `apt install curl`

Copiez le cript dans un fichier "pointage.sh" et ajoutez le mot de passe et utilisateur.

Pour lancer le script il suffit de faire

`bash pointage.sh`

Pour que le script se lance automatiquement il faut editer le fichier /etc/crontab et ajouter une ligne avec l'heure de demarrage et le chemin du script.
