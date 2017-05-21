#!/bin/bash
#This script installs the rest of the repository
#If the directory already exists
if [ -d "Scripts" ]
then
  echo "There is already a folder names Scripts, please remove or rename it."
  #Exit
  exit 0
fi
#If curl is installed
if [ $(which curl) ]
then
  curl https://codeload.github.com/NerdOfLinux/Scripts/zip/master -o master.zip
#Else if wget is installed
elif [ $(which wget) ]
then
  wget https://codeload.github.com/NerdOfLinux/Scripts/zip/master -O master.zip
fi
unzip master.zip
#Delete .zip file
rm master.zip
#Make foleder
mkdir Scripts
#Move files
mv Scripts-master/* Scripts
#Remove extra folder
rmdir Scripts-master
#Change directory
cd Scripts
#Run the setup file
sh setup.sh
