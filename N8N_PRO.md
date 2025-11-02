# 🚀 n8n – Installation et gestion complète avec Docker, Git & Pandoc

Ce dépôt propose une **installation complète de n8n** avec **Docker Compose**,  
ainsi qu’un script unique (`n8n_manage.sh`) pour gérer **Docker**, **n8n**, **Git**,  
et **l’export de documentation** (HTML, PDF, slides, PPTX via Pandoc).

> 🧩 Compatible avec **Linux**, **macOS** et **Windows (via WSL2 ou Git Bash)**

---

# 📦 Table des matières

1. [🎯 Objectif du projet](#-objectif-du-projet)  
2. [⚙️ Prérequis système](#️-prérequis-système)  
3. [🧱 Structure du projet](#-structure-du-projet)  
4. [🪟🍎🐧 Installation selon le système](#-installation-selon-le-système)  
5. [🚀 Lancer et gérer n8n](#-lancer-et-gérer-n8n)  
6. [🔐 Configuration et sécurité (.env)](#-configuration-et-sécurité-env)  
7. [💾 Sauvegarde et restauration](#-sauvegarde-et-restauration)  
8. [🧰 Le script n8n_manage.sh](#-le-script-n8n_managesh)  
9. [🧪 Export de documentation (Pandoc)](#-export-de-documentation-pandoc)  
10. [⚠️ Dépannage courant](#️-dépannage-courant)  
11. [🌍 Déploiement avancé (optionnel)](#-déploiement-avancé-optionnel)  
12. [📚 Ressources utiles](#-ressources-utiles)  
13. [✅ Conclusion](#-conclusion)

---

# 🎯 Objectif du projet

Ce projet vise à fournir un **environnement portable, automatisé et versionné** pour n8n :
- Installation et gestion de **n8n via Docker Compose**
- Administration complète depuis un **menu CLI interactif**
- **Versionnement Git** intégré
- **Export documentaire automatisé** (Pandoc)

---

# ⚙️ Prérequis système

Avant de commencer, assurez-vous que votre système dispose de :

| Logiciel | Requis | Installation |
|-----------|---------|--------------|
| Docker | ✅ | [Get Docker](https://docs.docker.com/get-docker/) |
| Docker Compose | ✅ | Inclus avec Docker Desktop ou le plugin Compose |
| Git | ✅ | [Git Downloads](https://git-scm.com/downloads) |
| Bash | ✅ | Intégré sous Linux/macOS, via WSL2 ou Git Bash sur Windows |
| Pandoc *(optionnel)* | 🔄 | [Pandoc Releases](https://github.com/jgm/pandoc/releases) |

---

# 🧱 Structure du projet

```
n8n-formation/
├── docker-compose.yml
├── n8n_manage.sh
├── .env
├── n8n_data/
└── README.md
```

> 📁 Le dossier `n8n_data` contient les données persistantes (workflows, credentials, logs…)

---

# 🪟🍎🐧 Installation selon le système

## 🪟 Windows (avec WSL2)
1. Installez **Docker Desktop** et activez **WSL2**.  
2. Ouvrez **Git Bash** ou **Windows Terminal (WSL)**.  
3. Clonez le projet :
   ```bash
   git clone https://github.com/votre-utilisateur/n8n-formation.git
   cd n8n-formation
   ```
4. Rendez le script exécutable :
   ```bash
   chmod +x n8n_manage.sh
   ```
5. Lancez le menu interactif :
   ```bash
   ./n8n_manage.sh
   ```

## 🍎 macOS
```bash
brew install --cask docker
open /Applications/Docker.app
git clone https://github.com/votre-utilisateur/n8n-formation.git
cd n8n-formation
chmod +x n8n_manage.sh
./n8n_manage.sh
```

## 🐧 Linux (Ubuntu/Debian/Fedora…)
```bash
sudo apt update && sudo apt install -y docker.io docker-compose git
git clone https://github.com/votre-utilisateur/n8n-formation.git
cd n8n-formation
chmod +x n8n_manage.sh
./n8n_manage.sh
```

---

# 🚀 Lancer et gérer n8n

Démarrage rapide :
```bash
docker compose up -d
```

Interface :  
👉 [http://localhost:5678](http://localhost:5678)

### Commandes utiles
| Action | Commande |
|--------|-----------|
| Démarrer | `docker compose up -d` |
| Arrêter | `docker compose down` |
| Logs | `docker compose logs -f` |
| Mise à jour | `docker pull n8nio/n8n` |

---

# 🔐 Configuration et sécurité (.env)

Au lieu de modifier directement `docker-compose.yml`, créez un fichier `.env` à la racine :

```env
GENERIC_TIMEZONE=Europe/Paris
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=CHANGEMOI123!
N8N_HOST=localhost
WEBHOOK_URL=http://localhost:5678/
```

Puis modifiez votre `docker-compose.yml` :

```yaml
environment:
  - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
  - N8N_BASIC_AUTH_ACTIVE=${N8N_BASIC_AUTH_ACTIVE}
  - N8N_BASIC_AUTH_USER=${N8N_BASIC_AUTH_USER}
  - N8N_BASIC_AUTH_PASSWORD=${N8N_BASIC_AUTH_PASSWORD}
  - N8N_HOST=${N8N_HOST}
  - WEBHOOK_URL=${WEBHOOK_URL}
```

> ⚠️ **Ne versionnez jamais votre fichier `.env`** dans Git.  
> Ajoutez-le à `.gitignore` :
> ```
> .env
> n8n_data/
> ```

---

# 💾 Sauvegarde et restauration

### Sauvegarde des données n8n :
```bash
tar -czvf sauvegarde_n8n.tar.gz n8n_data/
```

### Sauvegarde complète du projet :
```bash
tar -czvf sauvegarde_complete.tar.gz n8n_data/ docker-compose.yml n8n_manage.sh .env
```

### Restauration :
```bash
tar -xzvf sauvegarde_complete.tar.gz
```

---

# 🧰 Le script `n8n_manage.sh`

Menu CLI pour tout gérer :  
- 🐳 Docker (install, images, conteneurs)  
- ⚙️ n8n (start, stop, update, logs)  
- 🌿 Git (init, commit, push/pull, branches)  
- 📝 Pandoc (export HTML, slides, PPTX, PDF)

Lancer :
```bash
./n8n_manage.sh
```

---

# 🧪 Export de documentation (Pandoc)

## Installation
### macOS
```bash
brew install pandoc
```
### Linux
```bash
sudo apt install -y pandoc
```
### Windows (PowerShell)
```powershell
winget install -e --id JohnMacFarlane.Pandoc
```

## Conversions disponibles
| Format | Commande |
|--------|-----------|
| HTML | `pandoc -s README.md -o docs.html --toc` |
| Slides (reveal.js) | `pandoc README.md -t revealjs -s -o slides.html --toc -V revealjs-url=https://unpkg.com/reveal.js@5` |
| PPTX | `pandoc README.md -o presentation.pptx --toc` |
| PDF *(LaTeX requis)* | `pandoc README.md -o documentation.pdf --pdf-engine=xelatex --toc` |

---

# ⚠️ Dépannage courant

| Problème | Cause probable | Solution |
|-----------|----------------|-----------|
| Port 5678 déjà utilisé | Autre service actif | `docker ps`, puis `docker stop <id>` |
| Docker non démarré | Service Docker Desktop arrêté | Lancer Docker Desktop ou `sudo systemctl start docker` |
| `permission denied` sur le script | Droits manquants | `chmod +x n8n_manage.sh` |
| Erreur d’accès dossier `n8n_data` | Droits utilisateurs | `sudo chown -R $USER:$USER n8n_data` |
| PDF Pandoc échoue | LaTeX non installé | Utiliser l’option `29` du menu ou `brew install --cask mactex` |

---

# 🌍 Déploiement avancé (optionnel)

### Utiliser une base PostgreSQL
Ajoutez un service au `docker-compose.yml` :
```yaml
services:
  postgres:
    image: postgres:16
    environment:
      - POSTGRES_USER=n8n
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=n8n
    volumes:
      - ./pg_data:/var/lib/postgresql/data
  n8n:
    image: n8nio/n8n
    depends_on:
      - postgres
    environment:
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=secret
      - DB_POSTGRESDB_DATABASE=n8n
```

### Hébergement distant
Modifier dans `.env` :
```env
N8N_HOST=automation.mondomaine.com
WEBHOOK_URL=https://automation.mondomaine.com/
```

---

# 📚 Ressources utiles

- **n8n Docs** → [https://docs.n8n.io](https://docs.n8n.io)  
- **Docker Docs** → [https://docs.docker.com](https://docs.docker.com)  
- **Git Docs** → [https://git-scm.com/doc](https://git-scm.com/doc)  
- **Pandoc Docs** → [https://pandoc.org](https://pandoc.org)  
- **Docker Hub (n8n)** → [https://hub.docker.com/r/n8nio/n8n](https://hub.docker.com/r/n8nio/n8n)

---

# ✅ Conclusion

Grâce à **Docker** et au **script `n8n_manage.sh`**, vous disposez d’un environnement :
- **Fiable** (conteneurs isolés)  
- **Portable** (multi-OS)  
- **Administrable en CLI** (menu interactif)  
- **Versionné** (Git intégré)  
- **Documenté** (export Pandoc multi-format)

> ✨ Prêt à automatiser vos workflows avec n8n, dans un environnement robuste et reproductible.
