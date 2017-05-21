#!/bin/bash
#Check for root
if [ $(whoami) != "root" ]
then
    echo "Please run as root."
fi
#If $1 is blank, then get browser
if [ -z $1 ]
then
    echo "Which browser would you like(ex: chrome, opera)?"
    read -p "Browser: " browser
else
    browser=$1
fi
