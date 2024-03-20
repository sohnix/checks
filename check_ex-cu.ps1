Get-Command Exsetup.exe | ForEach {$_.FileversionInfo} | select -ExpandProperty ProductVersion
