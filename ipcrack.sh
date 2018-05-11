#!/bin/bash
# This is a simple bash script to try and find the real IP of websites behind Cloudflare
# Please DO NOT use this ilegally :-)
echo "Welcome to ipcrack.sh"
echo "This script will (try to) reveal ip addresses of websites using Cloudflare"
echo ""
if [ -z "$1" ]
then
	read -p "website: " website
echo "____________________"
echo ""
else
	website="$1"
fi
if ! curl -ksI $website | grep -i cloudflare >/dev/null
then
	echo "This site is not behind Cloudflare."
	echo "____________________"
	echo ""
fi
echo "Probing MX records..."
#Get MX record
mx=$(dig +short mx $website | head -n 1 | cut -d " " -f 2)
if [ -z "$mx" ]
then
	echo "____________________"
	echo ""
	echo "MX record not found..."
	echo "Trying mail.$website"
	mx="mail.$website.com"
fi
#Get the IP of the MX record
ip=$(dig +short $mx | head -n 1)
echo "____________________"
echo ""
echo "Trying: $ip"
echo "____________________"
echo ""
#Check for Content-Type of HTML
if curl -ks http://$ip --header "Host: $website" | grep "$website" >/dev/null || curl -ks https://$ip --header "Host: $website" | grep "$website" >/dev/null
then
	echo "$ip seems to host $website"
elif curl -ksI http://$ip --header "Host: $website" | grep "Content-Type: text/html" >/dev/null || curl -ksI https://$ip | grep "Content-Type: text/html" >/dev/null
then
	echo "$ip seems to host a website, but we're not sure if it's $website"
else
	echo "$ip does not appear to host a website"
fi
echo ""
