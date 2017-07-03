#!/bin/bash
#This script uses clamav
#Chck if clamscan in installed
if [ $(which clamscan) ]
then
  #Check for root user
  if [ $(whoami) = "root" ]
  then
    #Update clamav definitions
    freshclam --quiet --no-warnings
    #If ran correctly
    if [ $? -eq 0 ]
    then
      #Do nothing
      echo ""
    else
      #Apply fix
      rm /var/log/clamav/freshclam.log
      freshclam
    fi
  fi
  #Make a folder named found_viruses(nothing will happen if it already exists)
  mkdir found_viruses 2> /dev/null
  #If $1 is empty
  if [ -z $1 ]
  then
    echo "Please enter a folder to scan."
    read folder
  else
    folder=$1
  fi
  #Scan with max file size of 1GB
  clamscan -r --move=found_viruses --max-filesize=1024M  --max-scansize=1024M $folder
#If freshclam is not found
else
  echo "Please install clamav."
  exit 0
fi
