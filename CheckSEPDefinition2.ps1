# Signatur von Symantec Endpoint Protection (ab Version 12.x) ueberpruefen
# Made by Pixelschubser - 2012-01-24
# s.geiselbrecht(at)naip.de

# Pfad zu Definitionsdatei
# Pfad bei deutschem Betriebssystem
# $path = "C:\Users\All Users\Symantec\Symantec Endpoint Protection\CurrentVersion\Data\Definitions\VirusDefs\definfo.dat"

# Pfad bei englischsprachigen Betriebssystem
$path = "C:\Users\All Users\Symantec\Symantec Endpoint Protection\CurrentVersion\Data\Definitions\SDSDefs\definfo.dat"

# Pruefe ob die Datei existiert
if((test-path $path) -eq $true) 
{

	# Auslesen der letzten Zeile 
	$defdate = (get-content $path)[-1] 

	# Auslesen des Datums
	$year = $defdate.substring(8, 4)
	$month = $defdate.substring(12, 2)
	$day = $defdate.substring(14, 2)

	# Aktuelles Datum
	$date = get-date 

	# Formatieren des Datums
	$olddate = get-date -Year $year -Month $month -Day $day -Hour 0 -Minute 0

	

	# Berechnen der Differenz der beiden Datumsangaben
	$datediff = $date - $olddate

	$Days = $datediff.days

	$status = "OK"
	$exitcode = 0
	
	if($Days -gt 3) 
	{
    		$status = "WARNING"
		$exitcode = 1
	} 
	elseif($Days -gt 6) 
	{
		$status = "CRITICAL"
		$exitcode = 2
	}	

}
else 
{
	$status = "UNKNOWN"
	$exitcode = 3
}


if($exitcode -ne 3)
{
	Write-Host "$status Virusdefinitions are $Days day(s) old ["$olddate.ToLongDateString()"]";
}
else
{
	Write-Host "$status Virusdefinition file not found";
}

exit ($exitcode)
