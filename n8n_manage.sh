#!/bin/bash

COMPOSE_FILE="docker-compose.yml"

function start_n8n() {
  echo "Démarrage de n8n..."
  docker compose -f $COMPOSE_FILE up -d
}

function stop_n8n() {
  echo "Arrêt de n8n..."
  docker compose -f $COMPOSE_FILE down
}

function update_n8n() {
  echo "Mise à jour de l'image n8n..."
  docker pull n8nio/n8n
  echo "Redémarrage de n8n..."
  stop_n8n
  start_n8n
}

function logs_n8n() {
  echo "Afficher les logs de n8n (Ctrl+C pour quitter)..."
  docker compose -f $COMPOSE_FILE logs -f
}

function stats_n8n() {
  echo "Stats docker en temps réel (Ctrl+C pour quitter)..."
  docker stats
}

while true; do
  echo ""
  echo "Gestion de n8n avec Docker Compose :"
  echo "1) Démarrer n8n"
  echo "2) Arrêter n8n"
  echo "3) Mettre à jour n8n"
  echo "4) Afficher les logs"
  echo "5) Afficher les stats"
  echo "6) Quitter"
  read -p "Choisissez une option: " choix
  case $choix in
    1) start_n8n ;;
    2) stop_n8n ;;
    3) update_n8n ;;
    4) logs_n8n ;;
    5) stats_n8n ;;
    6) echo "Au revoir!"; exit 0 ;;
    *) echo "Option invalide, veuillez réessayer." ;;
  esac
done
