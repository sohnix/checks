# Prüfung nach gesperrten Usern
# Überprüfen, ob das Active Directory-Modul geladen ist. Wenn nicht, lade es.
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Abfrage aller gesperrten Benutzer im Active Directory
$gesperrteBenutzer = Get-ADUser -Filter {LockedOut -eq $false} -Properties "SamAccountName"

if ($gesperrteBenutzer.Count -gt 0) {
    Write-Host "CRITICAL: Es gibt $($_.Count) gesperrte Benutzer:"
    foreach ($benutzer in $gesperrteBenutzer) {
        Write-Host "Gesperrter Benutzer: $($benutzer.SamAccountName)"
    }
    exit 2
} else {
    Write-Host "OK: Es gibt keine gesperrten Benutzer."
    exit 0
}

