#!/bin/bash
if [ -z $2 ]
then
        echo="echo"
elif [[ $2 = "quiet"  ||  $2 = "silent" || $2 = "-s" ]]
then
        echo="true"
fi
#Set cache folder
ipcache="/tmp/.ipcache"
#If the cache folder is not present, create
if [ ! -d $ipcache ]
then
	$echo "Cache folder does not exist, creating..."
	mkdir $ipcache
fi

if [ -z $1 ]
then
	read -p "IP: " ip
else
	ip="$1"
fi
#If file is in cache
if [ -f "$ipcache/$ip" ]
then
	#Use the file
	$echo "Using cache."
	jsonFile="$ipcache/$ip"
	json=$(cat $jsonFile)
else
	#Download
	$echo "Downloading."
	json=$(curl -s https://ipapi.co/$ip/json | tee "$ipcache/$ip")
fi
country=$(echo $json | jq -r .country_name)
region=$(echo $json | jq -r .region)
ISP=$(echo $json | jq -r .org)
city=$(echo $json | jq -r .city)
printf "Country: $country\nRegion/State: $region\nCity: $city\nISP: $ISP\n"
