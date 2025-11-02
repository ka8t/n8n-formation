# 🧩 Documentation n8n – Formation & Professionnelle

Bienvenue dans le dépôt **n8n Formation**.  
Ce projet inclut deux documentations complémentaires selon vos besoins :

---

## 📘 [Documentation Formation – N8N_FORMATION.md](./N8N_FORMATION.md)
Une version **pédagogique et détaillée**, parfaite pour apprendre à installer, configurer et comprendre n8n, Docker, Git et Pandoc pas à pas.  
Idéale pour les formations ou ateliers pratiques.

---

## ⚙️ [Documentation Professionnelle – N8N_PRO.md](./N8N_PRO.md)
Une version **condensée, claire et orientée production**, idéale pour les utilisateurs expérimentés ou les déploiements techniques.  
Inclut les meilleures pratiques `.env`, sécurité et automatisation via le script `n8n_manage.sh`.

---

## 🧱 Structure du projet

```
n8n-formation/
├── N8N_FORMATION.md   # Version longue / pédagogique
├── N8N_PRO.md          # Version courte / pro
├── n8n_manage.sh       # Script de gestion Docker / Git / Pandoc
├── docker-compose.yml  # Déploiement de n8n
├── n8n_data/           # Données persistantes n8n
└── README.md           # Présentation générale et liens
```

---

## ✨ Pour commencer rapidement

```bash
chmod +x n8n_manage.sh
./n8n_manage.sh
```

Choisissez ensuite selon vos besoins :
- **Formation →** consultez `N8N_FORMATION.md`
- **Production →** suivez `N8N_PRO.md`

---

**Auteur :** Projet n8n Formation  
**Licence :** MIT  
**Dernière mise à jour :** Générée automatiquement par ChatGPT
