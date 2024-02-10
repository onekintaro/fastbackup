# Parameters: -configPath
param (
    [string]$configPath
)

# Starte fastbackup.py mit übergebenen Parametern
python .\fastbackup.py -f $configPath
