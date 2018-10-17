#!/bin/bash
#Update script for Ubuntu
#Check that user is root
if [ $(whoami) != "root" ]
then
    echo "Please run as root."
    #Exit
    exit 0
fi
#If apt is present
if [ $(which apt) ]
then
	APT="apt"
#Else if apt-get is present
elif [ $(which apt-get) ]
then
	APT="apt-get"
fi
#If $1 is empty
if [ -z $1 ]
then
    echo "Updating package indexes..."
    $APT update
    echo "Upgrading..."
    $APT upgrade -y
#Else if $1 is fix
elif [ $1 = "fix" ]
then
    # Remove lock files
    rm /var/lib/apt/lists/lock &
    rm /var/cache/apt/archives/lock &
    rm /var/lib/dpkg/lock &
    # In case dpkg was interrupted
    dpkg --configure -a
    # Update
    $APT update
    echo "Press 'y' to fix broken packages(if there are no warnings about removing essential packeges, etc.)"
    # Fix broken installs
    $APT -f install
#Else if $1 is clean
elif [ $1 = "clean" ]
then
    echo "Cleaning apt cache..."	
    $APT clean
    echo "Press 'y' to remove old/unused packages..."
    $APT autoremove
fi
