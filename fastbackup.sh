#!/bin/bash

# Überprüfen, ob die benötigten Tools vorhanden sind
if ! command -v rsync &> /dev/null || ! command -v python3 &> /dev/null; then
  echo "Bitte führe zuerst install.sh aus, um alle erforderlichen Tools zu installieren."
  exit 1
fi

# Starte das Python-Skript mit allen übergebenen Argumenten
python3 fastbackup.py "$@"