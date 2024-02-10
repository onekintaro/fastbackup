# Prüfen, ob Chocolatey installiert ist
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey nicht gefunden. Installiere Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Installieren von rsync mit Chocolatey
choco install rsync

# Prüfen, ob Python installiert ist und Anweisungen zur Installation geben
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python nicht gefunden. Bitte manuell von https://python.org herunterladen und installieren."
}
