#!/bin/bash
#Set cache folder
ipcache=".ipcache"
#If the cache folder is not present, create
if [ ! -d $ipcache ]
then
        echo "Cache folder does not exist, creating..."
        mkdir $ipcache
fi
echo="echo"
if [ -z $1 ]
then
        read -p "IP: " ip
else
        ip="$1"
fi
if [ -z $2 ]
then
        echo="echo"
elif [ $2 = "quiet" ] || [ $2 = "silent" ]
then
        echo="true"
fi
#If file is in cache
if [ -f "$ipcache/$ip" ]
then
        #Use the file
        $echo "Using cache."
        jsonFile="$ipcache/$ip"
else
        #Download
        $echo "Downloading."
        curl -s https://ipapi.co/$ip/json >> "$ipcache/$ip"
        jsonFile="$ipcache/$ip"
fi
json=$(cat $jsonFile)
country=$(echo $json | jq -r .country_name)
region=$(echo $json | jq -r .region)
ISP=$(echo $json | jq -r .org)
printf "Country: $country\nRegion/State: $region\nISP: $ISP\n"
