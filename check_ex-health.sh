#!/bin/bash
#set -x
while getopts h: option
do
        case ${option} in
                h) hostname=${OPTARG};;
                \?)echo "please enter hostname! (expectet option -h) "
                        exit 3;;
        esac
done

if [ $OPTIND -eq 1 ]
then
        echo "please enter Hostname! (expected option -h)"
        exit 3
fi
tmp=$(mktemp)
#hostname=$1
services=(OWA ECP RPC EWS MAPI OAB Microsoft-Server-ActiveSync Autodiscover)
declare -a fails
for service in ${services[*]}
do
	curl https://$hostname/$service/healthcheck.htm -ksS > $tmp
	if [ `grep 200 $tmp | wc -l` -eq 1 ]
	then
		:	
	else	
		fails[${fails[*]}+1]=$service
	fi
done
rm $tmp
if [ ${#fails[*]} -eq 0 ]
then
	echo "OK: all services are healthy."
	exit 0 
else
	echo "Critical :	"
	for fail in ${fails[*]}
	do
		echo "		$fail not healthy."
	done
	exit 2
fi
rm $tmp
