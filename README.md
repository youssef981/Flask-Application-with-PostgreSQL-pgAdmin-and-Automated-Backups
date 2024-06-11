## Flask Application with PostgreSQL, pgAdmin, and Automated Backups

Ce projet présente une application web Flask simple, sécurisée et robuste, conçue pour être déployée dans un environnement Docker. Il met en œuvre les meilleures pratiques pour la gestion de base de données (PostgreSQL) et inclut des sauvegardes automatisées pour assurer la fiabilité des données.

### Structure du Projet

```
├── app
│   ├── templates
│   │   └── show_all.html
│   ├── app.py
│   └── dbcreate.py
├── base-image
│   ├── Dockerfile
│   ├── README.md
│   └── requirements.txt
├── scripts
│   └── backup.sh
├── .env
├── Dockerfile
├── Dockerfile.backup
├── Jenkinsfile
└── README.md
```

* **app:** Contient le code source de l'application Flask.
    * **templates:** Stocke les fichiers HTML pour le rendu des pages web.
    * **app.py:** Le script principal de l'application Flask.
    * **dbcreate.py:** Script d'initialisation de la base de données PostgreSQL.
* **base-image:** Dossier contenant les éléments pour construire une image de base.
    * **Dockerfile:** Définit l'image de base pour le conteneur Docker.
    * **requirements.txt:** Liste les dépendances Python nécessaires.
* **scripts:** Contient les scripts auxiliaires.
    * **backup.sh:** Script pour effectuer une sauvegarde de la base de données.
* **.env:** Fichier pour stocker les variables d'environnement (par exemple, les informations d'identification de la base de données).
* **Dockerfile:** Définit comment construire l'image Docker pour l'application.
* **Dockerfile.backup:** Dockerfile pour l'image du conteneur responsable de la sauvegarde.
* **Jenkinsfile:** Script Groovy utilisé par Jenkins pour automatiser le déploiement.
* **README.md:** Ce fichier, expliquant le projet (vous êtes ici !).

### Fonctionnement

1. **Conteneur de l'application (Flask):**
   - Exécute l'application Flask.
   - Se connecte à la base de données PostgreSQL.
   - Sert des pages web dynamiques basées sur les données de la base de données.

2. **Conteneur de base de données (PostgreSQL):**
   - Stocke les données de l'application.
   - Gère les requêtes SQL de l'application Flask.

3. **Conteneur de sauvegarde:**
   - Se connecte périodiquement à la base de données.
   - Crée des sauvegardes de la base de données selon un calendrier défini.

4. **Jenkins (Automatisation):**
   - Automatise l'ensemble du processus de construction et de déploiement.
   - Garantit que le code le plus récent est toujours déployé et que les données sont sauvegardées régulièrement.

### Déploiement avec Jenkins

Le fichier `Jenkinsfile` inclus dans le projet est un script Groovy qui décrit le pipeline de déploiement Jenkins.

Voici les étapes clés du pipeline :

1. **Cloner le référentiel Git.**
2. **Arrêter les conteneurs existants et supprimer les volumes pour éviter les conflits.**
3. **Construire et démarrer les conteneurs Docker.**
4. **Attendre que l'application Flask soit prête à répondre aux requêtes.**
5. **Sauvegarder la base de données PostgreSQL.**

### Exécution du projet

1. **Prérequis:**
   - Docker et Docker Compose installés sur le serveur Ubuntu.
   - Jenkins installé et configuré sur le serveur Ubuntu.
2. **Configuration:**
   - Définissez les variables d'environnement nécessaires dans Jenkins (par exemple, les informations d'identification de la base de données) et sur votre machine locale si besoin.
3. **Exécution du Pipeline Jenkins:**
   - Déclenchez le pipeline Jenkins pour automatiser le déploiement de l'application.
