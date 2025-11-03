# N8N_FORMATION_LONG
_Formation professionnelle n8n — version longue, prête pour export PowerPoint_

> Ce document sert de base à la création d'une présentation PowerPoint pour un public professionnel.
> Les images sont référencées en local (`./img/...`) et chaque image inclut **immédiatement sous l’illustration** une source complète (URL directe contenant le nom de fichier) et un rappel de copyright.

---

## 💡 1) Pourquoi n8n ? (Contexte & positionnement)
- **Plateforme d’automatisation open‑source** combinant **processus métier** et **capacités [IA](#ia)**.
- **Liberté d’hébergement** : Cloud n8n, on‑premises, containers, Kubernetes.
- **Évolutivité** : mode [Queue](#queue-mode) (workers) pour la montée en charge, forte résilience.
- **Écosystème** : >800 intégrations, [HTTP](#http) générique, Code [node](#node) ([JS](#js)), [exécution partielle](#partial-execution), [Error Workflow](#error-workflow).
- **Cas d’usage pros** : intégration [CRM](#crm)/[ERP](#erp), enrichissement incidents [SecOps](#secops), [MDM](#mdm), synchronisation multi‑[SaaS](#saas), assistants IA “human‑in‑the‑loop”.

![Diagramme (canvas vide)](./img/l1-c1-canvas.png)
> Source : [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png) © Droits appartenant à leurs ayants droit

---

## 🖼️ 2) Vue d’ensemble de l’éditeur n8n
- **Canvas** (grille), **panneau latéral**, **barre supérieure**, **panneau des nœuds**, outil de **zoom/arrangement**.
- **[Workflows](#workflow)** : déclenchés par [triggers](#trigger) ([webhook](#webhook), cron, [IMAP](#imap), etc.) puis enchaînement de nœuds (transformations, appels [API](#api), stockage, notifications).
- **Debug** : exécution partielle, données épinglées, historique, reprises/retry, journalisation.

![Interface de l’éditeur](./img/editor-ui-v2-light-avP437s1.png)
> Source : [https://docs.n8n.io/assets/images/editor-ui-v2-light-avP437s1.png](https://docs.n8n.io/assets/images/editor-ui-v2-light-avP437s1.png) © Droits appartenant à leurs ayants droit

**Logo & branding (pour slides d’intro/conclusion)**

![Logo n8n](./img/N8n-logo-new.svg)
> Source : [https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg](https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg) © Marques et droits réservés à leurs titulaires

**Panneau latéral / intégrations**

![Écosystème & panneau latéral](./img/l1-c1-side-panel.png)
> Source : [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png) © Droits appartenant à leurs ayants droit

---

## ✅ 3) Bonnes pratiques de conception
- **Découplage** : isoler la logique (transformations) des [I/O](#io) (APIs, [DB](#db), files).
- **Idempotence** : clés de déduplication, *Merge by fields*, *Remove Duplicates*.
- **Observabilité** : *Error Workflow*, métriques, notifications ciblées (Slack/Discord/Email).
- **Sécurité** : [Credentials](#credential) chiffrés, variables d’environnement, secrets externes, [RBAC](#rbac)/Projets.
- **Qualité** : tests de nœuds, données épinglées, *manual & partial executions*, reprise après incident.

> Astuce : centraliser les appels HTTP dans des sous‑workflows exportables et versionnés (Git).

---

## 🚀 4) Déploiement & Scalabilité (architectures)
### 4.1 Mode *queue* (scalable)
- **Main** (triggers, webhooks, [UI](#ui)) + **Redis** (queue) + **Workers** (exécution).
- Concurrency réglable par worker, montée en charge horizontale.![Architecture — Queue mode](./img/queue-mode-flow.png)
> Source : [https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png](https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png) © Droits appartenant à leurs ayants droit

### 4.2 Multi‑main / [HA](#ha) (entreprise)
- Répartition des *mains* (leader/followers), sticky sessions côté [LB](#lb), Postgres ([PG](#pg)) partagé, Redis partagé.
- Séparer *webhook processors* si trafic élevé, éviter d’exposer le *main* au pool webhooks.

![Architecture — Cluster (exemple illustratif)](./img/scaling-v2-light-Ds8sT299.png)
> Source : [https://docs.n8n.io/assets/images/scaling-v2-light-Ds8sT299.png](https://docs.n8n.io/assets/images/scaling-v2-light-Ds8sT299.png) © Droits appartenant à leurs ayants droit

---

## 🛡️ 5) Gouvernance, sécurité & conformité
- **RBAC/Projets** : séparation des responsabilités, revue, pair programming sur workflows sensibles.
- **Secrets** : Vault/externes, rotation, *least privilege* sur API keys.
- **Traçabilité** : logs d’exécution, stockage des résultats (bases/objets), horodatage, conservation.
- **Revue de changement** : [PR](#pr) Git si *source control* activé, branches, environnements (dev/preprod/prod).
- **Résilience** : stratégies retry/exponential backoff, [DLQ](#dlq) (via nœuds personnalisés), alerting proactif.

---

## 🤖 6) Patterns & cas d’usage IA
- **[RAG](#rag) & enrichissement** : ingestion (HTTP/Files), chunking, embeddings, base vecteurs, génération ciblée.
- **Agents orchestrés** : outils *n8n* (Search, HTTP, Code), *human‑in‑the‑loop*, garde‑fous métiers.
- **Assurance qualité** : *Evaluations* (light/metric‑based), benchmarks, *guardrails*.

![Exemple d’écran (éditeur, vue globale)](./img/ai-beta-light-D_wzY-iC.png)
> Source : [https://docs.n8n.io/assets/images/ai-beta-light-D_wzY-iC.png](https://docs.n8n.io/assets/images/ai-beta-light-D_wzY-iC.png) © Droits appartenant à leurs ayants droit

---

## 🔗 7) Intégrations & data
- **Connecteurs** : SaaS (Salesforce, HubSpot, Slack…), DB (Postgres, MySQL, Snowflake…), files, email.
- **Connecteurs génériques** : HTTP Request, [GraphQL](#graphql), Webhook, Code (JS).
- **Schéma de données n8n** : items [JSON](#json), *paired items*, mapping UI/expressions, *Item linking*.

---

## ⚙️ 8) Opérations (Runbook résumé)
- **Avant prod** : valider quotas APIs, idempotence, *error workflow*, budgets cloud, chiffrement.
- **Mise en prod** : config *EXECUTIONS_MODE=queue*, Redis/PG monitorés, LB sticky sessions, sauvegardes.
- **Post‑prod** : [SLO](#slo)/[SLI](#sli), alerting, *insights*, capacity planning (concurrency × workers), upgrades contrôlés.

---

## 💰 9) Modèle économique (repères haut niveau)
Tableau indicatif (variables selon édition/hébergement) :

| Plan | Hébergement | Utilisateurs | Environnements / Git | Workers / Queue | Support | Notes |
|---|---|---:|:---:|:---:|:---:|---|
| Community | Self‑host | 1 | — | — | Communauté | Libre & extensible |
| Starter/Pro (Cloud) | Cloud n8n | Équipe | Oui* | Oui* | Inclus | Voir la page *Pricing* |
| Enterprise | Cloud/On‑prem | Organisation | Avancé | Avancé | Contrat | [SSO](#sso)/[SAML](#saml), HA, etc. |

* selon palier/édition. Pour un comparatif contractuel détaillé, se référer à la page officielle de tarification et au contrat d’abonnement.

---

## 📊 10) Concurrents & Positionnement
n8n se positionne sur un marché dynamique aux côtés d'acteurs majeurs comme Zapier et Make.

| Critère | n8n | Zapier | Make (Integromat) |
|---|---|---|---|
| **Modèle de prix** | Basé sur le **nombre de workflows exécutés**. Un workflow = 1 crédit, peu importe le nombre de tâches. | Basé sur le **nombre de tâches**. Chaque action dans un workflow est comptée. | Basé sur le **nombre d'opérations**. Similaire à Zapier, mais souvent plus généreux. |
| **Hébergement** | **Open-source (auto-hébergé)** ou Cloud. Grande flexibilité. | Cloud uniquement. | Cloud uniquement. |
| **Public Cible** | Développeurs, équipes techniques, et utilisateurs avancés. | Utilisateurs non techniques, marketing, petites entreprises. | Utilisateurs avec un certain bagage technique, PME. |
| **Complexité** | Plus flexible et puissant, mais avec une courbe d'apprentissage plus élevée. | Très simple d'utilisation, idéal pour des tâches linéaires. | Visuellement avancé, permet des scénarios complexes avec une interface visuelle. |
| **Personnalisation** | **Très élevée**. Accès au code (Node.js), création de connecteurs personnalisés. | Faible. Limité aux applications et actions prédéfinies. | Moyenne. Logique conditionnelle avancée, mais pas d'accès au code. |
| **Tarifs (indicatifs)** | **Gratuit** en auto-hébergé. Plans cloud à partir de ~20€/mois. | Plan gratuit limité. Plans payants à partir de ~20€/mois pour un volume de tâches modéré. | Plan gratuit généreux. Plans payants très compétitifs, à partir de ~9€/mois. |

**En résumé, n8n se distingue par :**
- **Sa flexibilité et sa puissance** grâce à l'approche "code-first" et l'open-source.
- **Son modèle économique prédictible** pour les workflows complexes.
- **Sa capacité à être auto-hébergé**, offrant un contrôle total sur les données et l'infrastructure.

---

## 🎓 11) Communauté & Ressources
- **Documentation officielle** : [https://docs.n8n.io/](https://docs.n8n.io/)
- **Forum communautaire** : [https://community.n8n.io/](https://community.n8n.io/)
- **Blog n8n** : [https://n8n.io/blog/](https://n8n.io/blog/)
- **Tutoriels et cours** : [https://n8n.io/courses/](https://n8n.io/courses/)

---

## 🏁 12) Conclusion
n8n est une plateforme d'automatisation puissante, flexible et évolutive. Sa nature open-source et son large éventail d'intégrations en font un outil de choix pour les professionnels cherchant à optimiser leurs processus métier. En maîtrisant les concepts clés présentés dans cette formation, vous serez en mesure de construire des workflows robustes, sécurisés et performants.

---

# 📚 ANNEXES

## B. Checklist de migration depuis Zapier/Make
1. **Cartographier** les workflows (triggers, actions, dépendances, volumes, [SLA](#sla)).
2. **Secrets** : inventaire des clés/credentials, stratégie de rotation et stockage.
3. **Idempotence** : règles de déduplication, *Merge by fields*, *retry* contrôlé.
4. **Limites API** : quotas, backoff, pagination, fenêtres de rafraîchissement.
5. **Plan de données** : schémas, conversions, champs obligatoires, tests d’intégrité.
6. **Observabilité** : *Error Workflow*, logs, métriques, alerting (Slack/Email).
7. **Déploiement** : choix Cloud vs self‑host, mode *queue*, sizing initial, *runbooks*.
8. **Sécurité & conformité** : RBAC/Projets, SSO/SAML (si entreprise), sauvegardes.
9. **Gouvernance** : Git/environnements, conventions de nommage, revues.
10. **Tests & bascule** : tests bout‑en‑bout, environnement de pré‑prod, *cut‑over* par lots, rollback.

## C. Exemples de *snippets*

Cette section montre comment étendre les capacités de n8n avec du code, ce qui est l'une de ses plus grandes forces. Un "snippet" est un petit bout de code réutilisable.

### JavaScript (dans un nœud "Code")

Ces exemples peuvent être copiés-collés directement dans un nœud "Code" de n8n. Ce nœud permet de manipuler des données ou d'exécuter une logique complexe directement dans un workflow.

#### Snippet 1 : Idempotence et normalisation de données

**But** : Garantir qu'un traitement ne sera effectué qu'une seule fois pour une donnée unique (idempotence), même si le workflow est déclenché plusieurs fois.

**Cas d'usage** : Éviter de créer des doublons. Par exemple, s'assurer qu'un client n'est ajouté qu'une seule fois dans votre CRM, même si la demande d'ajout arrive à plusieurs reprises avec le même email.

```js
// Le code dans un nœud "Code" n8n s'exécute pour chaque "item" reçu en entrée.
// `$json` est une variable spéciale qui contient les données de l'item en cours.

// 1. Normalisation de l'email :
//    - `?.` (Optional Chaining) : évite une erreur si `$json.email` n'existe pas.
//    - `.trim()` : supprime les espaces au début et à la fin.
//    - `.toLowerCase()` : convertit tout en minuscules.
//    - `|| ''` : si l'email est `null` ou `undefined`, on utilise une chaîne vide.
const email = $json.email?.trim().toLowerCase() || '';

// 2. Création d'un identifiant unique (hash) :
//    - On utilise le module 'crypto' natif de Node.js pour le hachage.
//    - `createHash('sha256')` : choisit l'algorithme de hachage (très courant et sécurisé).
//    - `.update(email)` : passe la donnée à hacher.
//    - `.digest('hex')` : calcule le hash et le retourne en format hexadécimal.
const crypto = require('crypto');
const id = crypto.createHash('sha256').update(email).digest('hex');

// 3. Retour des données :
//    - Le nœud "Code" doit retourner un tableau d'objets.
//    - Chaque objet représente un "item" qui sera passé au nœud suivant.
//    - Ici, on retourne l'ID unique et l'email normalisé.
return [{ id, email }];
```

#### Snippet 2 : Appel HTTP résilient avec "Retry"

**But** : Rendre un workflow plus robuste en cas d'échec temporaire d'un service externe.

**Cas d'usage** : Vous appelez une API pour récupérer des informations. Si l'API est momentanément indisponible, au lieu de faire échouer tout le workflow, ce code va automatiquement réessayer l'appel plusieurs fois, avec un délai d'attente qui augmente entre chaque tentative ("exponential backoff").

```js
// Fonction asynchrone pour gérer les appels et les nouvelles tentatives.
// `max` définit le nombre maximum de tentatives.
async function callWithRetry(url, opts = {}, max = 3) {
  let attempt = 0;
  while (attempt < max) {
    try {
      // `this.helpers.request` est une fonction intégrée à n8n pour faire des appels HTTP.
      const res = await this.helpers.request({ url, ...opts });
      // Si l'appel réussit, on retourne la réponse.
      return res;
    } catch (error) {
      attempt++;
      // Si c'est la dernière tentative, on propage l'erreur pour faire échouer le nœud.
      if (attempt === max) {
        throw error;
      }
      // Calcul du délai d'attente (augmente à chaque tentative : 500ms, 1000ms, 2000ms...).
      const delay = Math.pow(2, attempt - 1) * 500;
      // Pause avant la prochaine tentative.
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}

// Exemple d'utilisation (à adapter) :
// return callWithRetry('https://api.example.com/data');
// Note : ce snippet est un modèle, il doit être intégré dans une logique complète.
// Pour cet exemple, on retourne simplement les items d'entrée pour ne pas casser le flux.
return items;
```

### Python (via un service externe)

Cet exemple montre que n8n peut orchestrer des services écrits dans d'autres langages. n8n communique avec ce service via des requêtes HTTP.

**But** : Externaliser une logique complexe ou utiliser des librairies qui n'existent qu'en Python.

**Cas d'usage** : Vous avez un algorithme de machine learning en Python. Votre workflow n8n peut collecter les données, les envoyer au service Python pour analyse via un appel HTTP, puis récupérer le résultat pour continuer le traitement (ex: envoyer un email, mettre à jour une base de données).

```python
# Ce code n'est PAS à mettre dans n8n, mais à déployer comme un service indépendant
# (par exemple sur un serveur, un conteneur Docker, ou une fonction serverless).

# On utilise Flask, un micro-framework web populaire en Python.
from flask import Flask, request, jsonify

# Crée l'application web.
app = Flask(__name__)

# Définit une route HTTP qui n'accepte que les requêtes POST sur l'URL '/normalize'.
# Dans n8n, vous utiliseriez un nœud "HTTP Request" en mode POST vers cette URL.
@app.post('/normalize')
def normalize():
    # Récupère le corps de la requête au format JSON.
    # Le nœud "HTTP Request" de n8n enverrait les données ici.
    data = request.get_json(force=True) or {}
    
    # Extrait le champ 'name', le nettoie et le met en majuscules.
    name = (data.get('name') or '').strip().title()
    
    # Retourne une réponse JSON.
    # n8n recevra ce JSON et pourra utiliser les champs 'name' et 'length' dans les nœuds suivants.
    return jsonify({'name': name, 'length': len(name)})

# Point d'entrée pour lancer le serveur Flask.
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

## D. Grille comparative des offres n8n
> À adapter avec les informations contractuelles actuelles de votre offre (prix, quotas, SLA).

| Critère | Community (Self‑host) | Cloud Starter | Cloud Pro | Cloud Enterprise | Self‑host Enterprise |
|---|---:|---:|---:|---:|---:|
| Hébergement | On‑prem/VM/K8s | n8n Cloud | n8n Cloud | n8n Cloud | On‑prem/K8s |
| Utilisateurs inclus | 1 | Équipe | Équipe | Organisation | Organisation |
| RBAC/Projets | Limité | Oui | Oui | Avancé | Avancé |
| Environnements + Git | Optionnel | Oui | Oui | Avancé | Avancé |
| Workers / Queue | Oui (config) | Oui (palier) | Oui | Avancé | Avancé |
| Secrets externes | Oui | Oui | Oui | Oui | Oui |
| SSO/SAML | — | — | Option | Oui | Oui |
| SLA & Support | Communauté | Standard | Étendu | Entreprise | Contrat |
| Observabilité | Standard | Standard | Étendu | Avancé | Avancé |
| Notes | Libre | Simplicité | Équipe | HA/Compliance | HA/Compliance |

---

## 📖 Glossaire Technique

<a name="api"></a>**API** : Application Programming Interface (Interface de Programmation d'Application). Un ensemble de règles et de définitions qui permet à différentes applications de communiquer entre elles.

<a name="credential"></a>**Credential** : Secret/clé d'API chiffré et réutilisable pour s'authentifier auprès d'un service.

<a name="crm"></a>**CRM** : Customer Relationship Management (Gestion de la Relation Client). Logiciel qui aide les entreprises à gérer et analyser les interactions avec leurs clients.

<a name="db"></a>**DB** : Database (Base de Données). Un système de stockage organisé de données.

<a name="dlq"></a>**DLQ** : Dead Letter Queue (File de Lettres Mortes). Une file d'attente qui stocke les messages ou les tâches qui n'ont pas pu être traités avec succès, pour une analyse ou un traitement ultérieur.

<a name="erp"></a>**ERP** : Enterprise Resource Planning (Planification des Ressources d'Entreprise). Logiciel de gestion qui intègre les principaux processus d'une entreprise (comptabilité, ventes, RH, etc.).

<a name="error-workflow"></a>**Error Workflow** : Workflow dédié à la capture et à la notification d’erreurs provenant d'autres workflows.

<a name="graphql"></a>**GraphQL** : Graph Query Language. Un langage de requête pour les APIs, qui permet de demander précisément les données dont on a besoin.

<a name="ha"></a>**HA** : High Availability (Haute Disponibilité). Conception d'un système pour qu'il soit opérationnel et disponible sans interruption pendant une longue période.

<a name="http"></a>**HTTP** : HyperText Transfer Protocol. Le protocole de communication utilisé pour transférer des données sur le World Wide Web.

<a name="ia"></a>**IA** : Intelligence Artificielle. Un domaine de l'informatique qui vise à créer des machines capables de simuler l'intelligence humaine.

<a name="io"></a>**I/O** : Input/Output (Entrée/Sortie). Les opérations de communication entre un système informatique (comme n8n) et le monde extérieur (fichiers, bases de données, etc.).

<a name="imap"></a>**IMAP** : Internet Message Access Protocol. Un protocole standard utilisé par les clients de messagerie pour récupérer les e-mails d'un serveur de messagerie.

<a name="js"></a>**JS** : JavaScript. Un langage de programmation principalement utilisé pour créer des pages web interactives. C'est le langage utilisé dans le nœud "Code" de n8n.

<a name="json"></a>**JSON** : JavaScript Object Notation. Un format de données textuel et léger, facile à lire et à écrire pour les humains, et facile à analyser et à générer pour les machines. C'est le format de données principal utilisé par n8n.

<a name="lb"></a>**LB** : Load Balancer (Répartiteur de Charge). Un dispositif qui distribue le trafic réseau ou applicatif sur plusieurs serveurs pour améliorer la réactivité et la disponibilité.

<a name="mdm"></a>**MDM** : Master Data Management (Gestion des Données de Référence). Une discipline qui vise à garantir la qualité et la cohérence des données clés d'une entreprise.

<a name="node"></a>**Node** : Nœud. Une étape de traitement dans un workflow (chargement, transformation, émission).

<a name="partial-execution"></a>**Partial execution** : Exécution partielle. L'exécution d’un sous‑ensemble de nœuds à des fins de debug.

<a name="pg"></a>**PG** : PostgreSQL. Un système de gestion de base de données relationnelle open-source.

<a name="pr"></a>**PR** : Pull Request. Une demande de fusion de code sur une plateforme de gestion de code source comme Git. C'est un mécanisme central de la revue de code.

<a name="queue-mode"></a>**Queue mode** : Mode Queue. Un mode d'exécution distribuée via Redis et des workers pour la montée en charge.

<a name="rag"></a>**RAG** : Retrieval-Augmented Generation. Une technique d'IA qui combine la recherche d'informations dans une base de connaissances avec la génération de texte pour produire des réponses plus précises et factuelles.

<a name="rbac"></a>**RBAC** : Role-Based Access Control (Contrôle d'Accès Basé sur les Rôles). Un modèle de gestion de la sécurité où l'accès aux ressources est déterminé par les rôles attribués aux utilisateurs.

<a name="saas"></a>**SaaS** : Software as a Service (Logiciel en tant que Service). Un modèle de distribution de logiciels où une application est hébergée par un fournisseur et mise à la disposition des clients sur Internet.

<a name="saml"></a>**SAML** : Security Assertion Markup Language. Un standard ouvert pour l'échange de données d'authentification et d'autorisation entre différentes parties, souvent utilisé pour le SSO.

<a name="secops"></a>**SecOps** : Security Operations. Une collaboration entre les équipes de sécurité informatique et d'opérations pour intégrer la sécurité dans l'ensemble du cycle de vie d'une application.

<a name="sla"></a>**SLA** : Service Level Agreement (Accord de Niveau de Service). Un contrat entre un fournisseur de services et un client qui définit le niveau de service attendu.

<a name="sli"></a>**SLI** : Service Level Indicator (Indicateur de Niveau de Service). Une mesure quantitative d'un aspect du niveau de service fourni (ex: le temps de disponibilité).

<a name="slo"></a>**SLO** : Service Level Objective (Objectif de Niveau de Service). Un objectif cible pour un SLI.

<a name="sso"></a>**SSO** : Single Sign-On (Authentification Unique). Un service d'authentification qui permet aux utilisateurs d'accéder à plusieurs applications avec un seul ensemble d'identifiants.

<a name="trigger"></a>**Trigger** : Déclencheur. Un nœud spécial qui démarre l'exécution d'un workflow (ex. *Webhook*, *Cron*, *IMAP*…).

<a name="ui"></a>**UI** : User Interface (Interface Utilisateur). La partie d'un logiciel avec laquelle un utilisateur interagit.

<a name="webhook"></a>**Webhook** : Un endpoint HTTP qui déclenche un workflow lorsqu'il reçoit une requête.

<a name="workflow"></a>**Workflow** : Un enchaînement de nœuds exécutés séquentiellement ou par branches pour automatiser un processus.
