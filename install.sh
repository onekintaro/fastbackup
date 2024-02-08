#!/bin/bash

REQUIRED_TOOLS=("rsync" "python3" "pv")

install_tools() {
  for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v $tool &> /dev/null; then
      echo "$tool konnte nicht gefunden werden und wird installiert."
      sudo apt-get install $tool -y || sudo apk add $tool
    fi
  done
}

if [[ $EUID -ne 0 ]]; then
   echo "Bitte führe dieses Skript mit sudo oder als root aus."
   exit 1
else
   install_tools
fi
