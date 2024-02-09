
# [WIP] _FastBackup_

> [!IMPORTANT]
> This Tool is still in development and not ready for use. :construction: :warning: :construction_worker_woman:

> [!IMPORTANT]
> Dieses Tool befindet sich noch in der Entwicklung und ist noch nicht einsatzbereit. :construction: :warning: :construction_worker_woman:

FastBackup ist ein leistungsfähiges, flexibles und einfach zu bedienendes Backup-Tool, entwickelt, um die Sicherung und Synchronisation von Dateien und Verzeichnissen zu vereinfachen. Mit Unterstützung für mehrere Quellen und Ziele, Checksummen-Überprüfung und anpassbare Logging-Optionen bietet FastBackup eine robuste Lösung für deine Backup-Anforderungen.

## Features
- Unterstützung für mehrere Quellen und Ziele innerhalb eines Backup-Jobs.
- Dry-Run-Modus zur Überprüfung der geplanten Aktionen ohne tatsächliche Änderungen.
- Checksummen-Überprüfung zur Sicherstellung der Integrität der kopierten Daten.
- Anpassbare Logging-Optionen mit Unterstützung für verschiedene Log-Level und Log-Dateien.
- Globale und job-spezifische Konfigurationen durch YAML-Konfigurationsdateien.
- Automatische Erkennung und Installation fehlender Abhängigkeiten.

## TODOs / Roadmap
- [x] Config-Dateien für globale Einstellungen und Backup-Jobs
- [ ] install.sh Skript für Abhängigkeiten
- [ ] fastbackup.sh Skript als Hauptskript
- [ ] fastbackup.py Skript für die eigentliche Backup-Logik
- [ ] Windows-Unterstützung (Powershell-Skript)

## Voraussetzungen

FastBackup setzt voraus, dass `rsync`, `Python 3` auf dem System installiert sind. Ein Installationsskript (`install.sh`) ist enthalten, um die erforderlichen Abhängigkeiten zu überprüfen und zu installieren.

FastBackup verwendet folgende Python-Bibliotheken:
- `pyyaml` für die Verarbeitung von YAML-Konfigurationsdateien.
- `argparse` für die Verarbeitung von Befehlszeilenargumenten.
- `logging` für das Logging von Ausgaben.
- `tqdm` für die Anzeige von Fortschrittsbalken.

## Installation

1. Klone das Repository oder lade die Skriptdateien herunter.
2. Führe das Installationsskript aus:
   ```bash
   sudo ./install.sh
   ```
3. Überprüfe, ob das `fastbackup.sh`-Skript ausführbar ist. Falls nicht, setze die entsprechenden Berechtigungen:
   ```bash
   chmod +x fastbackup.sh
   ```

## Konfiguration

FastBackup verwendet YAML-Dateien für die Konfiguration der Backup-Jobs (`example-backup.yml`) und globale Einstellungen (`settings.yml`).

- **Backup-Konfiguration (`example-backup.yml`)**: Definiert einzelne Backup-Jobs, einschließlich Quellen, Ziele, und job-spezifische Einstellungen.
- **Globale Einstellungen (`settings.yml`)**: Enthält globale Konfigurationsoptionen und Standardwerte für das Verhalten von FastBackup.


### Konfigurationsdetails
Die `settings.yml`-Datei steuert das Verhalten von FastBackup durch verschiedene globale Einstellungen. Hier ist eine detaillierte Erklärung der Konfigurationsbereiche:

`settings.yml`

Globale Einstellungen (`global`)
Die Konfiguration ist in drei Hauptbereiche unterteilt: `config`, `script` und `log`.
log.logNames enthält die Namen der verschiedenen Log-Dateien, die von FastBackup erstellt werden.

`global.config:`
  Schlüssel  | Values              | Default Value | Beschreibung
------------|---------------------|---------------|-------------------------------------------------------------------------------------
 `dry`      | `BOOL` `true/false` | `true`        | Aktiviert den Dry-Run-Modus global, wenn `true`.
 `check`    | `BOOL` `true/false` | `true`        | Aktiviert die Checksummen-Überprüfung global, wenn `true`.
 `headless` | `BOOL` `true/false` | `false`       | Aktiviert den Headless-Modus, um Ausgaben im Terminal zu unterdrücken, wenn `true`.

global.script:
 Schlüssel      | Values             | Default Value | Beschreibung
----------------|--------------------|---------------|-------------------------------------------------------------------------------------------------
 `onError`      | `null` or a `PATH` | `null`        | Pfad zum Skript, das im Fehlerfall ausgeführt wird.
 `onCheckError` | `null` or a `PATH` | `null`        | Pfad zum Skript, das ausgeführt wird, wenn bei der Checksummen-Überprüfung ein Fehler auftritt.
 `onSuccess`    | `null` or a `PATH` | `null`        | Pfad zum Skript, das nach einem erfolgreichen Backup ohne Fehler ausgeführt wird.

global.log:
 Schlüssel      | Values              | Default Value | Beschreibung
----------------|---------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------
 `logLevel`     | `INT` `0`-`3`       | `1`           | Legt das Log-Level fest (`0` = kein Logging, `1` = Basis-Logging, `2` = erweitertes Logging, `3` = Debugging).
 `logPath`      | `PATH`              | `./logs`      | Pfad zum Verzeichnis, in dem Log-Dateien gespeichert werden.
 `logPrefix`    | `null` or `STRING`  | `null`        | Prefix für Log-Dateien (`prefix_logfile.log`)
 `logSuffix`    | `null` or `STRING`  | `null`        | Suffix für Log-Dateien (`sufix_logfile.log`)
 `logDate`      | `BOOL` `true/false` | `false`       | Fügt das Datum zum Log-Dateinamen hinzu, wenn true. (`logfile_YYYY-MM-DD.log`)
 `logTime`      | `BOOL` `true/false` | `false`       | Fügt die Uhrzeit zum Log-Dateinamen hinzu, wenn true. (`logfile_HH-MM-SS.log`)
 `logOverwrite` | `BOOL` `true/false` | `true`       | Überschreibt vorhandene Log-Dateien, wenn true. Andernfalls wird ein neuer Name generiert. (`logfile.log` -> `logfile_1.log`)

global.log.logNames:
 Schlüssel   | Values   | Default Value | Beschreibung
-------------|----------|---------------|------------------------------------------------------------------
 `console`   | `STRING` | `run`         | Name für die Konsolenausgabe-Log-Datei. (`run.log`)
 `checkfile` | `STRING` | `check`       | Name für die Log-Datei der Checksummenprüfung. (`check.log`)
 `copyfiles` | `STRING` | `copy`        | Name für die detaillierte Kopiervorgangs-Log-Datei. (`copy.log`)
 `error`     | `STRING` | `error`       | Name für die Fehler-Log-Datei. (`error.log`)
 `debug`     | `STRING` | `debug`       | Name für die Debug-Log-Datei. (`debug.log`)

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
