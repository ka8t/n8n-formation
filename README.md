
# 🚀 Installation et utilisation de n8n avec Docker Compose sur macOS 12

Ce guide explique comment installer et exécuter **n8n** via **Docker Compose** sur macOS 12,  
avec un **stockage local** dans un dossier de projet spécifique.

---

## 🧩 Étape 1 — Préparer le dossier de projet

Nous allons stocker toutes les données n8n dans un dossier local à votre projet.  
Voici le chemin de travail choisi :

```
/n8n-formation
```

Créez un sous-dossier dédié aux données persistantes :

```bash
mkdir -p "./n8n-formation/n8n_data"
```

Ce dossier contiendra les fichiers internes de n8n (workflows, credentials, etc.).

---

## 📝 Étape 2 — Créer le fichier `docker-compose.yml`

Créez un fichier `docker-compose.yml` à la racine de votre dossier de projet :

**Chemin complet :**
```
./n8n-formation/docker-compose.yml
```

**Contenu :**

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

> 💡 **Astuce :**  
> - Remplacez `motdepassefort` par un mot de passe sécurisé.  
> - Vous pouvez ajuster le fuseau horaire (`GENERIC_TIMEZONE`) selon votre localisation.

---

## ▶️ Étape 3 — Démarrer n8n avec Docker Compose

Depuis le dossier de votre projet, exécutez :

```bash
cd "./n8n-formation"
docker compose up -d
```

L’option `-d` permet de lancer le service en **arrière-plan**.

---

## 🌐 Étape 4 — Accéder à l’interface n8n

Une fois le conteneur lancé, ouvrez votre navigateur à l’adresse suivante :  
👉 [http://localhost:5678](http://localhost:5678)

Vous verrez l’interface web de n8n, protégée par le mot de passe défini précédemment.

---

## 🧹 Étape 5 — Gérer les conteneurs

**Arrêter n8n :**
```bash
docker compose down
```

**Redémarrer n8n :**
```bash
docker compose up -d
```

**Afficher les logs en direct :**
```bash
docker compose logs -f
```

---

## 💾 Données et sauvegardes

Toutes les données persistantes sont stockées dans le dossier local :

```
./n8n-formation/n8n_data
```

Vous pouvez sauvegarder ce dossier manuellement ou via un script (ex : cron)  
pour conserver vos workflows, credentials et historiques.

---

## 🔧 Conseils supplémentaires

- ⚙️ **Sécurisation :** utilisez un reverse proxy (Nginx, Traefik) pour exposer n8n via HTTPS.  
- 🧠 **Base externe :** pour une utilisation avancée ou multi-utilisateurs, configurez une base de données PostgreSQL externe.  
- 📚 **Documentation officielle :** [https://docs.n8n.io](https://docs.n8n.io)

---

## ✅ Résumé rapide

| Étape | Action | Commande principale |
|-------|---------|---------------------|
| 1 | Créer le dossier de données locales | `mkdir -p ./n8n_data` |
| 2 | Créer `docker-compose.yml` | *(voir modèle ci-dessus)* |
| 3 | Lancer le conteneur | `docker compose up -d` |
| 4 | Accéder à n8n | [http://localhost:5678](http://localhost:5678) |
| 5 | Gérer le conteneur | `docker compose down` / `docker compose logs` |

---

> ✨ **n8n est maintenant prêt à automatiser vos tâches !**  
> Vous pouvez créer vos premiers workflows et connecter vos outils favoris, directement depuis votre projet local.

