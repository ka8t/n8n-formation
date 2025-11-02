#!/bin/bash
# ============================================================
# 🧩 SCRIPT : n8n_manage.sh
# ============================================================
# 🔧 OBJECTIF :
#   Interface CLI (menu interactif) pour :
#     - Gérer Docker & Docker Compose (installation, images, conteneurs)
#     - Administrer n8n (start, stop, update, logs, stats)
#     - Configurer et manipuler Git (identité, remote, commit, push/pull)
#     - Vérifier/installer Pandoc + dépendances et exporter la doc (HTML, slides, PPTX, PDF)
#     - Installer LaTeX séparément pour l'export PDF (option dédiée)
#
# 🧠 MODE D’EMPLOI :
#   1) chmod +x n8n_manage.sh
#   2) ./n8n_manage.sh
#   3) Suivre le menu (vérifications → installations → usages)
#
# ⚙️ COMPATIBILITÉ :
#   Linux (Debian/Ubuntu/CentOS/Fedora), macOS, Windows (Git Bash ou WSL2).
# ============================================================

COMPOSE_FILE="docker-compose-pro.yml"

function _has() { command -v "$1" >/dev/null 2>&1; }
function _section() { echo -e "\n============================================================\n $1\n============================================================"; }

# ===================== DOCKER ===============================
function docker_check() {
  _section "🔍 Vérification de Docker"
  if ! _has docker; then
    echo "❌ Docker n'est pas installé."
    read -p "Installer Docker maintenant ? (o/n) : " rep
    [[ "$rep" =~ ^[oO]$ ]] && docker_install || echo "ℹ️ Installation annulée."
    return
  fi
  docker --version
  docker info >/dev/null 2>&1 && echo "✅ Docker est en cours d'exécution." || echo "⚠️ Docker semble arrêté."
}

function docker_install() {
  _section "🧰 Installation de Docker"
  case "$OSTYPE" in
    linux*)
      if [[ -f "/etc/debian_version" ]]; then
        sudo apt update
        sudo apt install -y ca-certificates curl gnupg lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo systemctl enable docker || true
        sudo systemctl start docker || true
      elif _has dnf; then
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo systemctl enable docker || true
        sudo systemctl start docker || true
      elif _has yum; then
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum install -y docker-ce docker-ce-cli containerd.io
        sudo systemctl enable docker || true
        sudo systemctl start docker || true
      else
        echo "⚠️ Distribution non reconnue. Voir : https://docs.docker.com/get-docker/"
      fi;;
    darwin*) echo "🍎 Installez Docker Desktop depuis https://docs.docker.com/desktop/install/mac-install/";;
    msys*|cygwin*|win*) echo "🪟 Installez Docker Desktop depuis https://docs.docker.com/desktop/install/windows-install/";;
    *) echo "⚠️ OS non reconnu. Installation manuelle requise.";;
  esac
  _has docker && docker --version || echo "❌ Docker non détecté après installation."
}

function docker_list_images() { _section "📦 Images Docker"; docker images; }
function docker_list_containers() { _section "🚢 Conteneurs Docker"; echo "Actifs :" && docker ps && echo ""; echo "Tous :" && docker ps -a; }
function docker_pull_example() { _section "⬇️ Télécharger image n8n"; docker pull n8nio/n8n; }
function docker_create_empty_image() { _section "🧱 Image vide (test:latest)"; echo "FROM scratch" > Dockerfile && docker build -t test:latest . && rm Dockerfile; }
function docker_remove_image() { docker images; read -p "Nom/ID de l'image à supprimer : " img; [ -z "$img" ] && return; docker rmi "$img"; }
function docker_remove_container() { docker ps -a; read -p "Nom/ID du conteneur à supprimer : " c; [ -z "$c" ] && return; docker rm -f "$c"; }

# ====================== n8n =================================
function start_n8n() { [ ! -f "$COMPOSE_FILE" ] && echo "❌ $COMPOSE_FILE introuvable." && return; _section "🚀 Démarrage n8n"; docker compose -f $COMPOSE_FILE up -d; }
function stop_n8n() { [ ! -f "$COMPOSE_FILE" ] && echo "❌ $COMPOSE_FILE introuvable." && return; _section "🛑 Arrêt n8n"; docker compose -f $COMPOSE_FILE down; }
function update_n8n() { _section "⬆️ Mise à jour n8n"; docker pull n8nio/n8n; stop_n8n; start_n8n; }
function logs_n8n() { [ ! -f "$COMPOSE_FILE" ] && echo "❌ $COMPOSE_FILE introuvable." && return; _section "📜 Logs n8n"; docker compose -f $COMPOSE_FILE logs -f; }
function stats_n8n() { _section "📊 Stats Docker"; docker stats; }

# ====================== GIT =================================
function git_set_identity() {
  _section "👤 Identité Git"
  current_name=$(git config --get user.name); current_email=$(git config --get user.email); current_github=$(git config --get user.github)
  echo "Actuel → Nom: ${current_name:-nd} | Email: ${current_email:-nd} | GitHub: ${current_github:-nd}"
  read -p "Modifier ces valeurs ? (o/n) : " modif; [[ ! "$modif" =~ ^[oO]$ ]] && return
  read -p "Nom complet : " new_name
  read -p "Adresse e-mail : " new_email
  read -p "URL GitHub (ex: https://github.com/utilisateur) : " new_github
  echo "1) 🌍 Global  2) 📁 Local"; read -p "Scope (1/2) : " scope
  if [[ "$scope" == "1" ]]; then
    git config --global user.name "$new_name"; git config --global user.email "$new_email"; git config --global user.github "$new_github"
  else
    git config user.name "$new_name"; git config user.email "$new_email"; git config user.github "$new_github"
  fi
  echo "✅ Identité mise à jour."
}

function git_set_remote() {
  _section "🌐 Dépôt distant (origin)"
  current_remote=$(git remote get-url origin 2>/dev/null); echo "Actuel : ${current_remote:-Aucun}"
  read -p "Ajouter/modifier le remote ? (o/n) : " mod; [[ ! "$mod" =~ ^[oO]$ ]] && return
  read -p "URL du dépôt GitHub (ex: https://github.com/utilisateur/projet.git) : " url; [ -z "$url" ] && echo "❌ Aucune URL." && return
  if git remote | grep -q origin; then git remote set-url origin "$url"; else git remote add origin "$url"; fi
  echo "✅ Nouveau remote : $(git remote get-url origin)"
}

function git_init_repo() { _section "🆕 Init dépôt Git"; [ -d ".git" ] && echo "⚠️ Dépôt déjà existant." && return; git init && echo "✅ Dépôt initialisé."; read -p "Configurer un remote ? (o/n) : " r; [[ "$r" =~ ^[oO]$ ]] && git_set_remote; }
function git_commit() { _section "📝 Commit + Push"; git add .; if git diff --cached --quiet; then echo "ℹ️ Rien à committer."; return; fi; read -p "Message de commit : " msg; [ -z "$msg" ] && echo "❌ Msg vide." && return; git commit -m "$msg"; br=$(git rev-parse --abbrev-ref HEAD); read -p "Pousser sur '$br' ? (o/n) : " p; [[ "$p" =~ ^[oO]$ ]] && git push origin "$br" || echo "Commit local uniquement."; }
function git_pull() { _section "🔄 Pull"; git pull; }
function git_list_branches() { _section "🌿 Branches"; git branch -a; }
function git_checkout_branch() { git branch -a; read -p "Branche à rejoindre : " b; [ -z "$b" ] && return; git checkout "$b"; }
function git_create_branch() { read -p "Nom nouvelle branche : " b; [ -z "$b" ] && return; git checkout -b "$b"; }
function git_delete_branch() { git branch; read -p "Branche à supprimer : " b; [ -z "$b" ] && return; read -p "Confirmer suppression de '$b' ? (o/n) : " y; [[ "$y" =~ ^[oO]$ ]] && (git branch -d "$b" 2>/dev/null || git branch -D "$b"); }

# =================== PANDOC & LATEX =========================
function pandoc_check_dependencies() {
  _section "🧩 Vérification des dépendances Pandoc"
  missing=()
  for bin in curl wget git unzip; do
    if _has "$bin"; then echo "✅ $bin présent"; else echo "❌ $bin manquant"; missing+=("$bin"); fi
  done
  if _has xelatex || _has pdflatex; then echo "✅ LaTeX détecté (xelatex/pdflatex)"; else echo "ℹ️ LaTeX non détecté (requis uniquement pour PDF)."; fi
  if [ ${#missing[@]} -gt 0 ]; then
    echo "⚠️ Manquants: ${missing[*]}"
    read -p "Installer les dépendances manquantes ? (o/n) : " inst
    if [[ "$inst" =~ ^[oO]$ ]]; then
      case "$OSTYPE" in
        linux*)
          if _has apt; then sudo apt update && sudo apt install -y ${missing[*]}
          elif _has dnf; then sudo dnf install -y ${missing[*]}
          elif _has yum; then sudo yum install -y ${missing[*]}
          else echo "⚠️ Installez manuellement : ${missing[*]}"; fi;;
        darwin*)
          if _has brew; then brew install ${missing[*]}; else echo "⚠️ Installez Homebrew : https://brew.sh"; fi;;
        msys*|cygwin*|win*)
          if _has winget; then for p in ${missing[*]}; do winget install -e --id $p || true; done
          elif _has choco; then choco install -y ${missing[*]}
          else echo "⚠️ Installez via winget/choco."; fi;;
        *) echo "⚠️ OS non reconnu. Installation manuelle requise.";;
      esac
    fi
  else
    echo "✅ Toutes les dépendances de base sont présentes."
  fi
}

function pandoc_install() {
  _section "📦 Installation de Pandoc"
  if _has pandoc; then echo "✅ Pandoc déjà installé : $(pandoc -v | head -n 1)"; return; fi
  echo "➡️ Vérification des dépendances..."; pandoc_check_dependencies
  case "$OSTYPE" in
    darwin*) if _has brew; then brew install pandoc; else echo "⚠️ Installez Homebrew : https://brew.sh puis 'brew install pandoc'"; fi;;
    linux*) if _has apt; then sudo apt update && sudo apt install -y pandoc; elif _has dnf; then sudo dnf install -y pandoc; elif _has yum; then sudo yum install -y pandoc; else echo "⚠️ Voir : https://github.com/jgm/pandoc/releases"; fi;;
    msys*|cygwin*|win*) if _has winget; then winget install -e --id JohnMacFarlane.Pandoc; elif _has choco; then choco install pandoc -y; else echo "⚠️ Utilisez l'installeur : https://github.com/jgm/pandoc/releases"; fi;;
    *) echo "⚠️ OS non reconnu. Téléchargez depuis : https://github.com/jgm/pandoc/releases";;
  esac
  _has pandoc && echo "✅ Pandoc installé : $(pandoc -v | head -n 1)" || echo "❌ Pandoc non détecté après installation."
}

function latex_install() {
  _section "🧪 Installation LaTeX (pour export PDF)"
  echo "ℹ️ LaTeX est volumineux. Nécessaire uniquement pour exporter en PDF via Pandoc."
  read -p "Installer LaTeX maintenant ? (o/n) : " ok; [[ ! "$ok" =~ ^[oO]$ ]] && { echo "⏭️ Installation LaTeX annulée."; return; }
  case "$OSTYPE" in
    darwin*) if _has brew; then brew install --cask mactex; else echo "⚠️ Installez Homebrew puis : brew install --cask mactex"; fi;;
    linux*) if _has apt; then sudo apt update && sudo apt install -y texlive-full; elif _has dnf; then sudo dnf install -y texlive-scheme-full; elif _has yum; then sudo yum install -y texlive; else echo "⚠️ Installez TeX Live manuellement."; fi;;
    msys*|cygwin*|win*) if _has winget; then winget install -e --id MiKTeX.MiKTeX; elif _has choco; then choco install miktex -y; else echo "⚠️ Installez MiKTeX : https://miktex.org/download"; fi;;
    *) echo "⚠️ OS non reconnu. Installez un moteur LaTeX (MiKTeX/TeX Live/MacTeX).";;
  esac
  (_has xelatex || _has pdflatex) && echo "✅ LaTeX détecté." || echo "❌ LaTeX non détecté. Vérifiez votre PATH."
}

function pandoc_convert_html() { _section "📝 Export HTML"; read -p "Source MD (défaut: README.md) : " s; s=${s:-README.md}; read -p "Sortie HTML (défaut: docs.html) : " o; o=${o:-docs.html}; [ ! -f "$s" ] && echo "❌ Introuvable: $s" && return; pandoc -s "$s" -o "$o" --toc --metadata title="Documentation n8n" && echo "✅ Généré: $o"; }
function pandoc_convert_reveal() { _section "📝 Export Slides (reveal.js)"; read -p "Source MD (défaut: README.md) : " s; s=${s:-README.md}; read -p "Sortie HTML (défaut: slides.html) : " o; o=${o:-slides.html}; [ ! -f "$s" ] && echo "❌ Introuvable: $s" && return; pandoc "$s" -t revealjs -s -o "$o" --toc -V revealjs-url=https://unpkg.com/reveal.js@5 && echo "✅ Généré: $o"; }
function pandoc_convert_pptx() { _section "📝 Export PPTX"; read -p "Source MD (défaut: README.md) : " s; s=${s:-README.md}; read -p "Sortie PPTX (défaut: presentation.pptx) : " o; o=${o:-presentation.pptx}; [ ! -f "$s" ] && echo "❌ Introuvable: $s" && return; pandoc "$s" -o "$o" --toc && echo "✅ Généré: $o"; }
function pandoc_convert_pdf() { _section "📝 Export PDF (LaTeX requis)"; read -p "Source MD (défaut: README.md) : " s; s=${s:-README.md}; read -p "Sortie PDF (défaut: documentation.pdf) : " o; o=${o:-documentation.pdf}; [ ! -f "$s" ] && echo "❌ Introuvable: $s" && return; if ! (_has xelatex || _has pdflatex); then echo "❌ LaTeX manquant. Utilisez l'option 29."; return; fi; pandoc "$s" -o "$o" --pdf-engine=xelatex --toc && echo "✅ Généré: $o"; }

# ====================== MENU ================================
while true; do
  echo ""
  echo "============================================================"
  echo "🛠️  GESTION DOCKER / n8n / GIT / PANDOC"
  echo "============================================================"
  echo "🐳 1) Vérifier Docker"
  echo "🐳 2) Installer Docker"
  echo "🐳 3) Lister les images"
  echo "🐳 4) Lister les conteneurs"
  echo "🐳 5) Télécharger image n8n"
  echo "🐳 6) Créer image vide (test)"
  echo "🐳 7) Supprimer image"
  echo "🐳 8) Supprimer conteneur"
  echo "----------------------------------------------"
  echo "⚙️  9) Démarrer n8n"
  echo "⚙️ 10) Arrêter n8n"
  echo "⚙️ 11) Mettre à jour n8n"
  echo "⚙️ 12) Logs n8n"
  echo "⚙️ 13) Stats n8n (Docker)"
  echo "----------------------------------------------"
  echo "🌿 14) Configurer identité Git"
  echo "🌿 15) Configurer dépôt distant Git (origin)"
  echo "🌿 16) Initialiser dépôt Git"
  echo "🌿 17) Commit + Push"
  echo "🌿 18) Pull Git"
  echo "🌿 19) Lister branches"
  echo "🌿 20) Changer de branche"
  echo "🌿 21) Créer une branche"
  echo "🌿 22) Supprimer une branche"
  echo "----------------------------------------------"
  echo "📝 23) Vérifier dépendances Pandoc"
  echo "📝 24) Installer Pandoc"
  echo "📝 25) Exporter README → HTML"
  echo "📝 26) Exporter README → Slides (reveal.js)"
  echo "📝 27) Exporter README → PPTX"
  echo "📝 28) Vérifier dépendances Pandoc (raccourci)"
  echo "📝 29) Installer LaTeX (optionnel, pour PDF)"
  echo "📝 30) Exporter README → PDF (LaTeX requis)"
  echo "----------------------------------------------"
  echo "0) Quitter"
  echo "============================================================"
  read -p "👉 Choisissez une option : " choix
  echo ""

  case $choix in
    1) docker_check ;;
    2) docker_install ;;
    3) docker_list_images ;;
    4) docker_list_containers ;;
    5) docker_pull_example ;;
    6) docker_create_empty_image ;;
    7) docker_remove_image ;;
    8) docker_remove_container ;;
    9) start_n8n ;;
    10) stop_n8n ;;
    11) update_n8n ;;
    12) logs_n8n ;;
    13) stats_n8n ;;
    14) git_set_identity ;;
    15) git_set_remote ;;
    16) git_init_repo ;;
    17) git_commit ;;
    18) git_pull ;;
    19) git_list_branches ;;
    20) git_checkout_branch ;;
    21) git_create_branch ;;
    22) git_delete_branch ;;
    23) pandoc_check_dependencies ;;
    24) pandoc_install ;;
    25) pandoc_convert_html ;;
    26) pandoc_convert_reveal ;;
    27) pandoc_convert_pptx ;;
    28) pandoc_check_dependencies ;;
    29) latex_install ;;
    30) pandoc_convert_pdf ;;
    0) echo "👋 Au revoir !" && exit 0 ;;
    *) echo "❌ Option invalide." ;;
  esac
done
