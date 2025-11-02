# 🚀 n8n – Gestion complète avec Docker et Git

Ce guide explique **comment installer, configurer et gérer n8n** avec **Docker Compose**,  
tout en utilisant le script `n8n_manage.sh` pour automatiser la gestion de **Docker**, **n8n**, **Git**, et désormais **l’export de documentation (Pandoc)**.

Il est structuré pour pouvoir être converti facilement en **présentation (PPTX ou HTML)**.

---

# 🖥️ Partie 0 — Utilisation du projet depuis le terminal

## Pourquoi utiliser le terminal ?
Le **terminal** est l’outil le plus direct et puissant pour gérer des environnements techniques comme **Docker**, **Git**, ou **n8n**.  
Il permet de :
- Contrôler précisément les actions exécutées ;  
- Automatiser les tâches via des scripts (comme `n8n_manage.sh`) ;  
- Travailler sur tous les systèmes (Windows, macOS, Linux) avec les mêmes commandes.

> 💡 Utiliser le terminal, c’est comprendre ce que fait réellement le système — et cela permet de reproduire les mêmes étapes sur n’importe quelle machine.

---

## 📦 Étapes générales pour tous les systèmes

1. **Ouvrir le terminal**
   - Sous **macOS** : Applications → Utilitaires → Terminal  
   - Sous **Windows** : *PowerShell* ou *Windows Terminal* (avec Docker Desktop et WSL2 activés)  
   - Sous **Linux** : Ctrl+Alt+T ou via le menu Applications → Terminal

2. **Se placer dans le dossier du projet**
   ```bash
   cd n8n-formation
   ```

3. **Donner les droits d’exécution au script (une seule fois)**
   ```bash
   chmod +x n8n_manage.sh
   ```

4. **Lancer le script principal**
   ```bash
   ./n8n_manage.sh
   ```

5. **Naviguer dans le menu interactif**
   Utilisez les chiffres proposés pour :  
   - Gérer Docker (installation, images, conteneurs)  
   - Lancer ou arrêter n8n  
   - Initialiser un dépôt Git, faire des commits, pousser ou tirer des modifications.  
   - **Exporter votre README en HTML, slides interactives (reveal.js) ou PPTX** avec Pandoc.

---

## ⚙️ Détails spécifiques selon le système d’exploitation

### 🪟 Windows
- Assurez-vous que **Docker Desktop** est installé et que **WSL2** est activé.  
- Lancez le terminal **PowerShell** ou **Windows Terminal**.  
- Vous pouvez exécuter les commandes comme sous Linux grâce à WSL2.  
- Le script `n8n_manage.sh` s’exécute dans un environnement Bash (WSL ou Git Bash).

### 🍎 macOS
- Le terminal intégré suffit.  
- Docker Desktop doit être installé.  
- Aucune configuration supplémentaire n’est nécessaire.  

### 🐧 Linux (Ubuntu, Debian, Fedora…)
- La version la plus directe : Docker est installé via `apt`, `dnf` ou `yum`.  
- Vous pouvez utiliser toutes les commandes Bash natives.  
- Le script fonctionne immédiatement sans ajustement.

---

## ✅ Pourquoi centraliser tout dans un script ?
Le script `n8n_manage.sh` :
- Évite les erreurs manuelles (commande oubliée, fautes de syntaxe) ;  
- Automatise les tâches répétitives ;  
- Simplifie la maintenance et la mise à jour de votre environnement n8n ;  
- Rend le projet **portable** : le même script fonctionne sur tous les systèmes.

> En résumé : tout ce que vous faites manuellement avec Docker et Git peut être géré depuis un seul menu interactif, **y compris l’export de votre documentation**.

---

# 📖 Table des matières

1. [🖥️ Partie 0 — Utilisation du projet depuis le terminal](#-partie-0--utilisation-du-projet-depuis-le-terminal)
2. [🧠 Partie 1 — Comprendre les outils utilisés](#-partie-1--comprendre-les-outils-utilisés)
3. [🧱 Partie 2 — Structure du projet](#-partie-2--structure-du-projet)
4. [🐳 Partie 3 — Installation et préparation](#-partie-3--installation-et-préparation)
5. [⚙️ Partie 4 — Lancer et gérer n8n](#-partie-4--lancer-et-gérer-n8n)
6. [💾 Partie 5 — Sauvegarde et restauration](#-partie-5--sauvegarde-et-restauration)
7. [🧰 Partie 6 — Le script n8n_manage.sh](#-partie-6--le-script-n8n_managesh)
8. [🧩 Partie 7 — Outils intégrés dans le script](#-partie-7--outils-intégrés-dans-le-script)
9. [🧾 Partie 8 — Annexe : Tableau des options du script](#-partie-8--annexe--tableau-des-options-du-script)
10. [🧪 Partie 9 — Export/Conversion Markdown avec Pandoc](#-partie-9--exportconversion-markdown-avec-pandoc)
11. [📚 Partie 10 — Ressources complémentaires](#-partie-10--ressources-complémentaires)
12. [✅ Conclusion](#-conclusion)

---

# 🧠 Partie 1 — Comprendre les outils utilisés

## 🐳 Docker
**Docker** permet d’exécuter des applications dans des *conteneurs isolés*.  
Cela garantit un environnement stable et identique sur toutes les machines.

### Avantages :
- Reproductibilité et portabilité  
- Isolation du système hôte  
- Déploiement et mise à jour faciles

---

## ⚙️ Docker Compose
**Docker Compose** permet de gérer plusieurs conteneurs via un fichier `docker-compose.yml`.

> Dans ce projet, il simplifie la gestion de **n8n** avec la commande :  
> `docker compose up -d`

---

## 🤖 n8n
**n8n** est une plateforme open-source d’automatisation de workflows.  
Elle connecte différents outils, APIs et bases de données sans code.

### Pourquoi Docker pour n8n ?
- Installation rapide  
- Isolation des dépendances  
- Sauvegarde et restauration faciles

---

## 🌿 Git
**Git** est un système de versionnement de code.  
Il permet de sauvegarder, suivre et partager les modifications d’un projet.

> Le script `n8n_manage.sh` intègre toutes les actions Git nécessaires (init, commit, push, pull).

---

# 🧱 Partie 2 — Structure du projet

```
├── N8N_FORMATION.md
├── N8N_PRO.md
├── README.md
├── docker-compose-pro.yml
├── docker-compose.yml
├── n8n_data
│   ├── binaryData
│   ├── config
│   ├── database.sqlite
│   ├── git
│   ├── n8nEventLog-1.log
│   ├── n8nEventLog-2.log
│   ├── n8nEventLog.log
│   ├── nodes
│   │   └── package.json
│   └── ssh
├── n8n_manage.sh
```

### 📂 Pourquoi `n8n_data` est dans le dossier du projet ?
Ce dossier contient toutes les données persistantes de n8n : workflows, credentials, logs, etc.  
Il est monté dans le conteneur Docker via un volume (`./n8n_data:/home/node/.n8n`).

Cela permet :
- Une **sauvegarde simple** du projet complet  
- Une **portabilité totale** entre machines  
- Un **versionnement Git** possible des configurations

---

# 🐳 Partie 3 — Installation et préparation

## Vérifier Docker
```bash
docker --version
docker info
```

Installer Docker selon le système :  
- macOS → https://docs.docker.com/desktop/install/mac-install/  
- Windows → https://docs.docker.com/desktop/install/windows-install/  
- Linux → https://docs.docker.com/engine/install/

---

## Créer le projet

```bash
mkdir -p ./n8n-formation/n8n_data
cd ./n8n-formation
```

---

## Créer `docker-compose.yml`
```yaml
version: '3'

services:
  n8n:
    image: n8nio/n8n
    container_name: n8n
    ports:
      - "5678:5678"
    volumes:
      - ./n8n_data:/home/node/.n8n
    environment:
      - GENERIC_TIMEZONE=Europe/Paris
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=motdepassefort
      - N8N_HOST=localhost
      - WEBHOOK_URL=http://localhost:5678/
    restart: unless-stopped
```

> 💡 Remplacez `motdepassefort` par un mot de passe robuste.

---

# ⚙️ Partie 4 — Lancer et gérer n8n

Démarrage du service :
```bash
docker compose up -d
```

Accès à l’interface web :  
👉 http://localhost:5678

### Commandes utiles
| Action | Commande |
|--------|-----------|
| Démarrer | `docker compose up -d` |
| Arrêter | `docker compose down` |
| Logs | `docker compose logs -f` |
| Mise à jour | `docker pull n8nio/n8n` |

---

# 💾 Partie 5 — Sauvegarde et restauration

Les données sont stockées dans :
```
./n8n_data
```

Sauvegarde :
```bash
tar -czvf sauvegarde_n8n.tar.gz n8n_data/
```

Restauration :
```bash
tar -xzvf sauvegarde_n8n.tar.gz
```

---

# 🧰 Partie 6 — Le script `n8n_manage.sh`

Script CLI unique pour gérer :  
- Docker  
- n8n  
- Git  
- **Export de documentation (Pandoc)**

Exécution :
```bash
chmod +x n8n_manage.sh
./n8n_manage.sh
```

---

# 🧩 Partie 7 — Outils intégrés dans le script

### 🐳 Docker
- Vérification / installation Docker  
- Gestion des images et conteneurs  
- Création d’images tests  
- Téléchargement d’images (ex : n8nio/n8n)

### ⚙️ n8n
- Démarrage / arrêt  
- Logs  
- Statistiques en temps réel  
- Mise à jour automatisée

### 🌿 Git
- Configuration d’identité utilisateur  
- Initialisation dépôt  
- Commit + Push (avec choix de branche)  
- Pull, création et suppression de branches

### 📝 Pandoc (export)
- Vérifier / installer Pandoc  
- Exporter le README en **HTML**  
- Exporter le README en **slides interactives (reveal.js)**  
- Exporter le README en **PPTX**

---

# 🧾 Partie 8 — Annexe : Tableau des options du script

| N° | Catégorie | Option | Description |
|----|------------|---------|--------------|
| 1 | Docker | Vérifier Docker | Vérifie installation et état du service |
| 2 | Docker | Installer Docker | Installation automatisée selon OS |
| 3 | Docker | Lister images | Affiche les images locales |
| 4 | Docker | Lister conteneurs | Affiche les conteneurs actifs/arrêtés |
| 5 | Docker | Télécharger n8n | Récupère l’image `n8nio/n8n` |
| 6 | Docker | Créer image test | Crée une image vide `test:latest` |
| 7 | Docker | Supprimer image | Supprime une image |
| 8 | Docker | Supprimer conteneur | Supprime un conteneur |
| 9 | n8n | Démarrer n8n | Lance le service via Compose |
| 10 | n8n | Arrêter n8n | Stoppe le conteneur |
| 11 | n8n | Mettre à jour | Télécharge et relance la dernière image |
| 12 | n8n | Logs | Affiche les logs en continu |
| 13 | n8n | Stats | Affiche les stats Docker |
| 14 | Git | Configurer identité | Définit nom et email utilisateur |
| 15 | Git | Init dépôt | Initialise et lie un dépôt distant |
| 16 | Git | Commit + Push | Commit puis push sur la branche choisie |
| 17 | Git | Pull | Récupère les changements distants |
| 18 | Git | Lister branches | Liste toutes les branches |
| 19 | Git | Changer branche | Change de branche |
| 20 | Git | Créer branche | Crée une nouvelle branche |
| 21 | Git | Supprimer branche | Supprime une branche |
| 22 | Pandoc | Vérifier Pandoc | Vérifie si Pandoc est installé |
| 23 | Pandoc | Installer Pandoc | Installation en un clic selon OS |
| 24 | Pandoc | README → HTML | Génère un fichier HTML standalone |
| 25 | Pandoc | README → Slides (reveal.js) | Génère des slides interactives |
| 26 | Pandoc | README → PPTX | Génère une présentation PowerPoint |
| 0 | Global | Quitter | Ferme le script |

---

# 🧪 Partie 9 — Export/Conversion Markdown avec Pandoc

## Pourquoi convertir le Markdown ?
- **Partager** une documentation lisible par tous (HTML)  
- **Présenter** le projet en réunion (PPTX)  
- **Animer** une démonstration interactive (slides reveal.js)  
- **Industrialiser** votre doc : un seul `.md` pour tous les formats

## Installer Pandoc

### macOS
```bash
brew install pandoc
```

### Windows (PowerShell)
```powershell
winget install -e --id JohnMacFarlane.Pandoc
# ou
choco install pandoc -y
```

### Linux (Debian/Ubuntu)
```bash
sudo apt update && sudo apt install -y pandoc
```

> Autres cas : téléchargez l’installeur depuis https://github.com/jgm/pandoc/releases

## Convertir le README

### Markdown → HTML (page web autonome)
```bash
pandoc -s README.md -o docs.html --toc --metadata title="Documentation n8n"
```

### Markdown → Slides interactives (reveal.js hébergé)
```bash
pandoc README.md -t revealjs -s -o slides.html --toc -V revealjs-url=https://unpkg.com/reveal.js@5
```
> Ouvrez `slides.html` dans un navigateur pour naviguer avec les flèches.

### Markdown → PowerPoint (PPTX)
```bash
pandoc README.md -o presentation.pptx --toc
```
> Optionnel : utiliser un thème PPTX personnalisé avec `--reference-doc=modele.pptx`.

---

# 📚 Partie 10 — Ressources complémentaires

- **n8n Docs** → https://docs.n8n.io  
- **Docker Docs** → https://docs.docker.com  
- **Git Docs** → https://git-scm.com/doc  
- **Pandoc Docs** → https://pandoc.org  
- **Docker Hub (n8n)** → https://hub.docker.com/r/n8nio/n8n

---

# ✅ Conclusion

Grâce à Docker et au script `n8n_manage.sh`, vous disposez d’un environnement :
- **Fiable** (conteneurs isolés)
- **Portable** (fonctionne partout)
- **Facile à administrer** (un seul script interactif)
- **Versionné** (via Git)
- **Diffusable** (export HTML, slides, PPTX via Pandoc)

> ✨ **n8n est désormais prêt à automatiser vos processus et à évoluer avec votre projet.**
