# Definiere den Zeitbereich für die Suche (letzten 24 Stunden)
$startTime = (Get-Date).AddDays(-1)
$endTime = Get-Date

# Ereignisquelle und IDs
$arcserveEventSource = "Arcserve UDP"
$errorEventId = 10114
$successEventIdVMWare = 30216
$successEventIdHV = 30144

# Suche nach Ereignissen im angegebenen Zeitbereich mit den definierten Kriterien
$errorEvent = Get-WinEvent -FilterHashtable @{
    LogName = "Application"
    StartTime = $startTime
    EndTime = $endTime
    id = $errorEventId
} -ErrorAction SilentlyContinue

$successEvent = Get-WinEvent -FilterHashtable @{
    LogName = "Application"
    StartTime = $startTime
    EndTime = $endTime
    id = $successEventId
} -ErrorAction SilentlyContinue

# Überprüfe die Ergebnisse und gib entsprechende Meldungen aus
if ($errorEvent) {
    Write-Host "CRITICAL - Sicherung in mindestens einem Server fehlgeschlagen"
    exit 2  # Icinga-Code für Critical
} elseif ($successEventHV -or $successEventIdVMWare) {
    Write-Host "OK - Erfolgreiche Sicherung: Event von $arcserveEventSource gefunden."
    exit 0  # Icinga-Code für OK
} else {
    Write-Host "CRITICAL - Keine Sicherung durchgeführt"
    exit 2  # Icinga-Code für Critical
}