#!/bin/bash
if [ $(whoami) != "root" ]
then
  echo "Please run as root."
  exit 1
fi

#Check for ubuntu
if [ $(lsb_release -d | cut -d " " -f 1) != "Ubuntu" ]
then 
  echo "This script only works on Ubuntu."
  exit 2
fi

if [ $(uname -p) != "x86_64" ]
then
  echo "This script only supports x86_64 CPUs"
  exit 3
fi
#Check if already installed
if [ -f /snap/bin/canonical-livepatch ]
then
  echo "Already installed. Would you like to continue?"
  read -p "y)es or n)o: " yesno
  if [ $yesno != "y" ]
    echo "Good choice. Bye."
    exit 4
  fi
fi
#Actually install
echo "Updating..."
apt update
echo "Installing snap"
apt install -y snap
echo "Installing core"
snap install core
echo "Installing livepatch"
snap install canonical-livepatch
echo "Please get your token from https://auth.livepatch.canonical.com/"
read -p "Token" $token
canonical-livepatch enable $token
if [ $? -eq 0 ]
then
  echo "Yay! Livepatching is now enabled."
else
  echo "Sorry, something went wrong"
fi
