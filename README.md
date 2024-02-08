
# [WIP] FastBackup

FastBackup ist ein leistungsfähiges, flexibles und einfach zu bedienendes Backup-Tool, entwickelt, um die Sicherung und Synchronisation von Dateien und Verzeichnissen zu vereinfachen. Mit Unterstützung für mehrere Quellen und Ziele, Checksummen-Überprüfung und anpassbare Logging-Optionen bietet FastBackup eine robuste Lösung für Ihre Backup-Anforderungen.

## Features

- Unterstützung für mehrere Quellen und Ziele innerhalb eines Backup-Jobs.
- Dry-Run-Modus zur Überprüfung der geplanten Aktionen ohne tatsächliche Änderungen.
- Checksummen-Überprüfung zur Sicherstellung der Integrität der kopierten Daten.
- Anpassbare Logging-Optionen mit Unterstützung für verschiedene Log-Level und Log-Dateien.
- Globale und job-spezifische Konfigurationen durch YAML-Konfigurationsdateien.
- Automatische Erkennung und Installation fehlender Abhängigkeiten.

## Voraussetzungen

FastBackup setzt voraus, dass `rsync`, `Python 3` und optional `pv` (für Fortschrittsanzeigen) auf Ihrem System installiert sind. Ein Installationsskript (`install.sh`) ist enthalten, um die erforderlichen Abhängigkeiten zu überprüfen und zu installieren.

## Installation

1. Klonen Sie das Repository oder laden Sie die Skriptdateien herunter.
2. Führen Sie das Installationsskript aus:
   ```bash
   sudo ./install.sh
   ```
3. Überprüfen Sie, ob das `fastbackup.sh`-Skript ausführbar ist. Falls nicht, setzen Sie die entsprechenden Berechtigungen:
   ```bash
   chmod +x fastbackup.sh
   ```

## Konfiguration

FastBackup verwendet YAML-Dateien für die Konfiguration der Backup-Jobs (`example-backup.yml`) und globale Einstellungen (`settings.yml`).

- **Backup-Konfiguration (`example-backup.yml`)**: Definiert einzelne Backup-Jobs, einschließlich Quellen, Ziele, und job-spezifische Einstellungen.
- **Globale Einstellungen (`settings.yml`)**: Enthält globale Konfigurationsoptionen und Standardwerte für das Verhalten von FastBackup.

Beispiele und Vorlagen für diese Konfigurationsdateien finden Sie im Repository.

## Verwendung

Um ein Backup zu starten, führen Sie das `fastbackup.sh`-Skript mit den gewünschten Optionen aus:

```bash
./fastbackup.sh -f /pfad/zu/backup-config.yml
```

Optionale Parameter:
- `-f, --file`: Pfad zur Backup-Konfigurationsdatei.
- `-c, --check`: Führt nur eine Checksummen-Überprüfung durch.
- `-d, --dry`: Führt einen Dry-Run durch.
- `--full`: Führt einen vollständigen Backup-Prozess durch (Dry-Run, Kopieren, Checksummen-Überprüfung).

Für weitere Informationen und optionale Parameter, führen Sie das Skript mit der Hilfe-Option aus:

```bash
./fastbackup.sh --help
```

## Beitrag

Wir begrüßen Beiträge und Vorschläge zur Verbesserung von FastBackup. Bitte erstellen Sie Issues oder Pull Requests im Repository.

## Lizenz

FastBackup ist unter der MIT-Lizenz veröffentlicht. Details finden Sie in der LICENCE-Datei.
