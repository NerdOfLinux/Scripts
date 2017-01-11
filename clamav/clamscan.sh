#This script uses clamav
#Chck if clamscan in installed
if [ $(which clamscan) ]
then
  #Check for root user
  if [ $(whoami) = "root" ]
  then
    freshclam
  fi
  #Make a folder
  mkdir found_viruses 2> /dev/null
  #If $1 is empty
  if [ -z $1 ]
  then
    echo "Please enter a folder to scan."
    read $folder
  else
    folder=$1
  fi
  #Scan
  clamscan -r --move=found_viruses --max-filesize=1024M  --max-scansize=1024M $folder
else
  echo "Please install clamav."
  exit 0
fi
