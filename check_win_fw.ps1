#########################################
# Skript zum Checken des Firewallstatus	#
#########################################
Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('public' , 'domain' , 'private')]
    [string]
    $profile
)
$status = Get-NetFirewallProfile $profile -PolicyStore ActiveStore | select -ExpandProperty Enabled 
$status=$status.ToString()
if($status -eq "True")
    {
       Write-Output "OK : $profile ist enabled."
       exit 0 
    }
else
    {
        Write-Output " Critical : $profile  ist nicht enabled."
        exit 2
    }
