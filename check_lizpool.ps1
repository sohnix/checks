#Skript zum Auswerten der Konsistnz des Datev Lizenzpools
#LimaStatus.exe liefert status des lizenzpools
#Autor Hanns-Gerhard Bergen Sohnix AG 2023
$path = "C:\Program Files (x86)\DATEV\PROGRAMM\SWS"
$erg = $NULL
cd $path
$text = .\LiMaStatus.exe | select-string -Pattern 'LizPool_konsistent'
$text = $text.toString()
$text = $text.substring($text.IndexOf(":")+2)
if($text -eq "Ja"){
	Write-Output "OK:Lizenzpool ist Konsistent."
	exit 0
}
else{
	Write-Output "CRITICAL: Linzenzpool Inkonsistent."
	exit 2
}
