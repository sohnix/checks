# Variablen
$daystowatch = 6
$backuphost = $env:computername | Select-Object
$failed = & "C:\Program Files (x86)\CA\ARCserve Backup\ca_dbmgr.exe" -cahost $backuphost -show jobs -failed -last $daystowatch days
$cancelled = & "C:\Program Files (x86)\CA\ARCserve Backup\ca_dbmgr.exe" -cahost $backuphost -show jobs -cancelled -last $daystowatch days
$completed = & "C:\Program Files (x86)\CA\ARCserve Backup\ca_dbmgr.exe" -cahost $backuphost -show jobs -completed -last $daystowatch days
$incomplete = & "C:\Program Files (x86)\CA\ARCserve Backup\ca_dbmgr.exe" -cahost $backuphost -show jobs -incomplete -last $daystowatch days



# Vergleich und Statusausgabe
if ($failed -ne "No failed Jobs!") {
    Write-Host "CRITICAL: Sicherung fehlgeschlagen! "
    exit 2
}
elseif ($cancelled -ne "No cancelled Jobs!") {
    Write-Host "CRITICAL: Sicherung abgebrochen!"
    exit 2
}
elseif ($incomplete -ne "No incomplete Jobs!") {
    Write-Host "CRITICAL: Sicherung unvollständig!"
    exit 2
}
elseif ($completed -ne "No completed Jobs!") {
    Write-Host "OK: Sicherung war erfolgreich!"
    exit 0
}
else {
    Write-Host "CRITICAL: keine Sicherung!"
    exit 2
}
