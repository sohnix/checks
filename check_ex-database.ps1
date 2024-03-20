foreach ($db in get-mailboxdatabase)
    {
         $size=get-item(get-mailboxdatabase $db.name | select -expand edbfilepath).pathname | select-object -expand length
         $size=[math]::Round((($size)/1GB),2)
         Write-Output "$db.name : $size"  
    }
exit 0
