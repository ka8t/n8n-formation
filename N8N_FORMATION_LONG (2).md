# N8N_FORMATION_LONG
_Formation professionnelle n8n — version longue, prête pour export PowerPoint_

> Ce document sert de base à la création d'une présentation PowerPoint pour un public professionnel.  
> Les images sont référencées en local (`./img/...`) et chaque image inclut **immédiatement sous l’illustration** une source complète (URL directe contenant le nom de fichier) et un rappel de copyright.

---

## 1) Pourquoi n8n ? (Contexte & positionnement)
- **Plateforme d’automatisation open‑source** combinant **processus métier** et **capacités IA**.
- **Liberté d’hébergement** : Cloud n8n, on‑premises, containers, Kubernetes.
- **Évolutivité** : mode *queue* (workers) pour la montée en charge, forte résilience.
- **Écosystème** : >800 intégrations, HTTP générique, Code node (JS), exécution partielle, “Error Workflow”.
- **Cas d’usage pros** : intégration CRM/ERP, enrichissement incidents SecOps, MDM, synchronisation multi‑SaaS, assistants IA “human‑in‑the‑loop”.

![Diagramme (canvas vide)](./img/diagramme_workflow_n8n.png)
> Source : [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png) © Droits appartenant à leurs ayants droit

---

## 2) Vue d’ensemble de l’éditeur n8n
- **Canvas** (grille), **panneau latéral**, **barre supérieure**, **panneau des nœuds**, outil de **zoom/arrangement**.
- **Workflows** : déclenchés par triggers (webhook, cron, IMAP, etc.) puis enchaînement de nœuds (transformations, appels API, stockage, notifications).
- **Debug** : exécution partielle, données épinglées, historique, reprises/retry, journalisation.

![Interface de l’éditeur](./img/interface_workflow_n8n.png)
> Source : [https://blog.n8n.io/content/images/2022/05/workflow2-1.png](https://blog.n8n.io/content/images/2022/05/workflow2-1.png) © Droits appartenant à leurs ayants droit

**Logo & branding (pour slides d’intro/conclusion)**

![Logo n8n](./img/logo_n8n.png)
> Source : [https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg](https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg) © Marques et droits réservés à leurs titulaires

**Panneau latéral / intégrations**

![Écosystème & panneau latéral](./img/ecosysteme_integrations.png)
> Source : [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png) © Droits appartenant à leurs ayants droit

---

## 3) Bonnes pratiques de conception
- **Découplage** : isoler la logique (transformations) des I/O (APIs, DB, files).  
- **Idempotence** : clés de déduplication, *Merge by fields*, *Remove Duplicates*.
- **Observabilité** : *Error Workflow*, métriques, notifications ciblées (Slack/Discord/Email).
- **Sécurité** : *Credentials* chiffrés, variables d’environnement, secrets externes, RBAC/Projets.
- **Qualité** : tests de nœuds, données épinglées, *manual & partial executions*, reprise après incident.

> Astuce : centraliser les appels HTTP dans des sous‑workflows exportables et versionnés (Git).

---

## 4) Déploiement & Scalabilité (architectures)
### 4.1 Mode *queue* (scalable)
- **Main** (triggers, webhooks, UI) + **Redis** (queue) + **Workers** (exécution).  
- Concurrency réglable par worker, montée en charge horizontale.

![Architecture — Queue mode](./img/architecture_queue_mode.png)
> Source : [https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png](https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png) © Droits appartenant à leurs ayants droit

### 4.2 Multi‑main / HA (entreprise)
- Répartition des *mains* (leader/followers), sticky sessions côté LB, Postgres partagé, Redis partagé.  
- Séparer *webhook processors* si trafic élevé, éviter d’exposer le *main* au pool webhooks.

![Architecture — Cluster (exemple illustratif)](./img/architecture_n8n_cluster.png)
> Source : [https://blog.n8n.io/content/images/2022/05/workflow2-1.png](https://blog.n8n.io/content/images/2022/05/workflow2-1.png) © Droits appartenant à leurs ayants droit

---

## 5) Gouvernance, sécurité & conformité
- **RBAC/Projets** : séparation des responsabilités, revue, pair programming sur workflows sensibles.
- **Secrets** : Vault/externes, rotation, *least privilege* sur API keys.
- **Traçabilité** : logs d’exécution, stockage des résultats (bases/objets), horodatage, conservation.
- **Revue de changement** : PR Git si *source control* activé, branches, environnements (dev/preprod/prod).
- **Résilience** : stratégies retry/exponential backoff, DLQ (via nœuds personnalisés), alerting proactif.

---

## 6) Patterns & cas d’usage IA
- **RAG & enrichissement** : ingestion (HTTP/Files), chunking, embeddings, base vecteurs, génération ciblée.
- **Agents orchestrés** : outils *n8n* (Search, HTTP, Code), *human‑in‑the‑loop*, garde‑fous métiers.
- **Assurance qualité** : *Evaluations* (light/metric‑based), benchmarks, *guardrails*.  

![Exemple d’écran (éditeur, vue globale)](./img/workflow_ia_n8n.png)
> Source : [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-editor-ui.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-editor-ui.png) © Droits appartenant à leurs ayants droit

---

## 7) Intégrations & data
- **Connecteurs** : SaaS (Salesforce, HubSpot, Slack…), DB (Postgres, MySQL, Snowflake…), files, email.
- **Connecteurs génériques** : HTTP Request, GraphQL, Webhook, Code (JS).
- **Schéma de données n8n** : items JSON, *paired items*, mapping UI/expressions, *Item linking*.

---

## 8) Opérations (Runbook résumé)
- **Avant prod** : valider quotas APIs, idempotence, *error workflow*, budgets cloud, chiffrement.
- **Mise en prod** : config *EXECUTIONS_MODE=queue*, Redis/PG monitorés, LB sticky sessions, sauvegardes.
- **Post‑prod** : SLO/SLI, alerting, *insights*, capacity planning (concurrency × workers), upgrades contrôlés.

---

## 9) Modèle économique (repères haut niveau)
Tableau indicatif (variables selon édition/hébergement) :

| Plan | Hébergement | Utilisateurs | Environnements / Git | Workers / Queue | Support | Notes |
|---|---|---:|:---:|:---:|:---:|---|
| Community | Self‑host | 1 | — | — | Communauté | Libre & extensible |
| Starter/Pro (Cloud) | Cloud n8n | Équipe | Oui* | Oui* | Inclus | Voir la page *Pricing* |
| Enterprise | Cloud/On‑prem | Organisation | Avancé | Avancé | Contrat | SSO/SAML, HA, etc. |

\* selon palier/édition. Pour un comparatif contractuel détaillé, se référer à la page officielle de tarification et au contrat d’abonnement.

---

# ANNEXES

## A. Glossaire technique
- **Node** : étape de traitement (chargement, transformation, émission).
- **Workflow** : enchaînement de nœuds exécutés séquentiellement/par branches.
- **Trigger** : nœud déclencheur (ex. *Webhook*, *Cron*, *IMAP*…).  
- **Credential** : secret/API key chiffré et réutilisable.  
- **Webhook** : endpoint HTTP qui déclenche un workflow.  
- **Queue mode** : exécution distribuée via Redis + workers.  
- **Partial execution** : exécution d’un sous‑ensemble de nœuds à des fins de debug.  
- **Error Workflow** : workflow dédié à la capture et la notification d’erreurs.  

## B. Checklist de migration depuis Zapier/Make
1. **Cartographier** les workflows (triggers, actions, dépendances, volumes, SLA).  
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
### JavaScript (Code node)
```js
// Utilitaire: normaliser email et calculer un hash (idempotence)
const crypto = require('crypto');
const email = $json.email?.trim().toLowerCase() || '';
const id = crypto.createHash('sha256').update(email).digest('hex');

return [{ id, email }];
```

```js
// Retry contrôlé d’un appel HTTP avec backoff
async function callWithRetry(url, opts = {}, max = 3) {
  let attempt = 0;
  while (attempt < max) {
    try {
      const res = await this.helpers.request({ url, ...opts });
      return res;
    } catch (e) {
      await new Promise(r => setTimeout(r, Math.pow(2, attempt) * 500));
      attempt++;
      if (attempt === max) throw e;
    }
  }
}
return items;
```

### Python (via service externe, ex. micro‑service)
```python
# Exemple Flask pour transformer des données depuis n8n (HTTP Request)
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.post('/normalize')
def normalize():
    data = request.get_json(force=True) or {}
    name = (data.get('name') or '').strip().title()
    return jsonify({'name': name, 'length': len(name)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

## D. Tableau comparatif complet — plans (modèle de grille)
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

## Récapitulatif des images (local → source directe)

| Fichier local | Description | Lien local (dans `./img`) | Lien direct (source complète) |
|---|---|---|---|
| diagramme_workflow_n8n.png | Canvas vide (vue de base) | `![Diagramme (canvas vide)](./img/diagramme_workflow_n8n.png)` | [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-canvas.png) |
| interface_workflow_n8n.png | Capture d’un workflow (ex. cours L2) | `![Interface de l’éditeur](./img/interface_workflow_n8n.png)` | [https://blog.n8n.io/content/images/2022/05/workflow2-1.png](https://blog.n8n.io/content/images/2022/05/workflow2-1.png) |
| logo_n8n.png | Logo n8n | `![Logo n8n](./img/logo_n8n.png)` | [https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg](https://commons.wikimedia.org/wiki/File:N8n-logo-new.svg) |
| ecosysteme_integrations.png | Panneau latéral / intégrations | `![Écosystème & panneau latéral](./img/ecosysteme_integrations.png)` | [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-side-panel.png) |
| workflow_ia_n8n.png | Éditeur (vue globale) | `![Exemple d’écran (éditeur, vue globale)](./img/workflow_ia_n8n.png)` | [https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-editor-ui.png](https://docs.n8n.io/_images/courses/level-one/chapter-one/l1-c1-editor-ui.png) |
| architecture_queue_mode.png | Schéma mode Queue | `![Architecture — Queue mode](./img/architecture_queue_mode.png)` | [https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png](https://docs.n8n.io/_images/hosting/scaling/queue-mode-flow.png) |
| architecture_n8n_cluster.png | Illustration cluster/HA (exemple) | `![Architecture — Cluster (exemple illustratif)](./img/architecture_n8n_cluster.png)` | [https://blog.n8n.io/content/images/2022/05/workflow2-1.png](https://blog.n8n.io/content/images/2022/05/workflow2-1.png) |

> Remarque : les droits et marques restent la propriété de leurs détenteurs. L’usage dans vos slides doit respecter les licences et *brand guidelines* associées.
