#This script uses clamav
if [ $(which clamscan) ]
then
  if [ $(whoami) = "root" ]
  then
    freshclam
  fi
  mkdir ~/.found_viruses 2> /dev/null
  if [ -z $1 ]
  then
    echo "Please enter a folder to scan."
    read $folder
  else
    folder=$1
  fi
  clamscan -r --move=~/.found_viruses $folder
else
  echo "Please install clamav."
  exit 0
fi
