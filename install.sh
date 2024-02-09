#!/bin/bash

# Definiere die erforderlichen Programme und Python-Module
REQUIRED_PROGRAMS=("rsync" "python3" "pip3")
PYTHON_MODULES=("pyyaml" "argparse" "logging" "tqdm")
MODULES_DIR="./modules"

# Farbcodes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Hilfsfunktionen
print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Prüfe, ob Programme bereits installiert sind
check_installed() {
    for program in "${REQUIRED_PROGRAMS[@]}"; do
        if command -v $program &> /dev/null; then
            print_success "$program gefunden"
        else
            echo "Zu installierende Abhängigkeit: $program"
            MISSING_DEPENDENCIES+=($program)
        fi
    done
}

# Installationsfunktionen für verschiedene Paketmanager
install_with_apt() {
    sudo apt-get update
    for program in "${MISSING_DEPENDENCIES[@]}"; do
        sudo apt-get install -y $program
    done
}

install_python_modules() {
    python3 -m pip install --target=$MODULES_DIR "${PYTHON_MODULES[@]}"
}

# Hauptlogik
MISSING_DEPENDENCIES=()
FORCE_PM=$2
SKIP_DEPS=$3

echo "Willkommen zu FastBackup Installer"
echo "Prüfe Abhängigkeiten... Bitte warten"

check_installed

if [ ${#MISSING_DEPENDENCIES[@]} -eq 0 ]; then
    print_success "Alle Abhängigkeiten sind bereits installiert."
else
    if [ "$SKIP_DEPS" != "--skip-deps" ]; then
        echo "Versuche Paketmanager zu erkennen... Bitte warten"
        if [ -n "$FORCE_PM" ]; then
            PM=$FORCE_PM
            print_warning "Force-Option verwendet: $FORCE_PM"
        else
            # Automatische Erkennung hier einfügen
            if command -v apt &> /dev/null; then
                PM="apt"
            elif command -v yum &> /dev/null; then
                PM="yum"
            # Weitere Erkennungen hier hinzufügen
            else
                PM="Unbekannt"
                echo "System: Unbekannt, Paketmanager: Unbekannt"
                echo "Bitte wähle einen Paketmanager aus (1=apt, 2=yum, ...): "
                read PM_CHOICE
                # Auswahllogik hier basierend auf PM_CHOICE
            fi
        fi

        echo "Versuche Installation mit $PM... Bitte warten"
        # Rufe Installationsfunktion basierend auf $PM auf
        "install_with_$PM"
    fi
fi

echo "Prüfe ob Abhängigkeiten installiert wurden... Bitte warten"
check_installed

if [ ${#MISSING_DEPENDENCIES[@]} -eq 0 ]; then
    print_success "Alle erforderlichen Abhängigkeiten sind installiert."
    echo "Installiere Pip Module im Verzeichnis $MODULES_DIR... Bitte warten"
    install_python_modules
    print_success "Installation erfolgreich!"
else
    print_warning "Einige Abhängigkeiten konnten nicht installiert werden."
fi
