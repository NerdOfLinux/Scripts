#!/bin/bash
#This script install earlyoom
#Check for root
if [ $(whoami) != "root" ]
then
  echo "Please run as root."
  #Exit
  exit 0
fi
#If the directory already exists
if [ -d "earlyoom" ]
then
  echo "There is already a folder names earlyoom, please remove or rename it."
  #Exit
  exit 0
fi
#If $1 is empty
if [ -z $1 ]
then
  if [ $(which curl) ]
  then
   #Get and unzip repository
   curl https://codeload.github.com/rfjakob/earlyoom/zip/master -o earlyoom.zip
   unzip earlyoom.zip
  #Else if wget is installed
  elif [ $(which wget) ]
  then
    #Get and unzip repository
    wget https://codeload.github.com/rfjakob/earlyoom/zip/master -O earlyoom.zip
    unzip earlyoom.zip
  fi
  cd earlyoom-master
  echo "Please enter the minimum percent of free ram(leave blank if unsure):"
  read -p "RAM%: " ram
  echo "Please enter the minimum percent of free swap(leave blank if unsure):"
  read -p "Swap%: " swap
  #If blank, then use defualt
  ram="${ram:-10}"
  swap="${swap:-10}"
  replace="int mem_min_percent = $ram, swap_min_percent = $swap;"
  #Replace line with set variable
  sed -i "s/int mem_min_percent = 0, swap_min_percent = 0;/$replace/g" main.c
  #Install
  make
  make install
  #Start at boot
  systemctl enable earlyoom
  #Start now
  systemctl start earlyoom
  cd ..
  #Delete folder and zip file
  rm -r earlyoom-master
  rm earlyoom.zip
elif [ $1 = "uninstall" ]
then
#Uninstall earlyoom
  curl https://codeload.github.com/rfjakob/earlyoom/zip/master -o earlyoom.zip
  unzip earlyoom.zip
  cd earlyoom-master
  make uninstall
  make uninstall-initscript
  #Clean up
  cd ..
  rm -r earlyoom-master
  rm earlyoom.zip
fi
