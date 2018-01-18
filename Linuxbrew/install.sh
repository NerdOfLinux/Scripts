#!/bin/bash
#Check for $1
if [ -z $1 ]
then
  #Do nothing
  echo ""
elif [ $1 = "setup" ]
then
  if [ $(whoami) != "root" ]
  then
    echo "Please run as root."
    exit 0
  fi
  #Check for apt
  if [ $(which apt) ]
  then
    #Install required packages
    apt install -y build-essential curl git python-setuptools ruby
  #Check for apt-get
  elif [ $(which apt-get) ]
  then
    #Install required packages
    apt-get install -y build-essential curl git python-setuptools ruby
  else
    echo "Sorry, this script can't install build-essential, curl, git, python-setuptools, and ruby."
    echo "Please install them, then run this script again."
    exit 0
  fi
fi
#This script is to set up linuxbrew
echo "Would you like to install linuxbrew?"
read -p "y)es or n)o?: " answer
#If the answer is not equal to y
if [ $answer != "y" ]
then
  echo "Ok, exiting..."
  #Exit
  exit 0
fi
#Check for ruby
if [ $(which ruby) ]
then
  #Do nothing
  echo ""
else
  #Tell user to install ruby
  echo "Please run ./install.sh setup"
  exit 0
fi
      
echo "Downloading and running setup..."
#Download and run the setup
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
echo "Finishing required steps..."
#Finish configuring
PATH="$HOME/.linuxbrew/bin:$PATH"
#If already in .bashrc
if [ $(cat ~/.bashrc | grep 'PATH="$HOME/.linuxbrew/bin:$PATH"') ]
then
  echo ""
else
  echo 'PATH="$HOME/.linuxbrew/bin:$PATH"' >>~/.bashrc
fi
#If the install worked
if [ $(which brew) ]
then
  echo "Linuxbrew is now installed."
  echo "Fixing any issues..."
  #Check for errors
  brew doctor
  echo "Would you like to test linuxbrew?"
  read -p " y)es or n)o?: " test
  #If test is not equal to y
  if [ $test != "y" ]
  then
    echo "Ok. Install finished"
  else
    brew install hello
    if [ $(which hello) ]
    then
      echo "Linuxbrew is functioning properly."
    else
      echo "An error has occured."
    fi
  fi
  echo "Would you like to disable linuxbrew analytics?"
  read -p " y)es or n)o?: " analytics
  if [ $analytics = "y" ]
  then
    brew analytics off
  fi
else
  echo "There was a problem, try running this script again."
  #Exit
  exit 0
fi
