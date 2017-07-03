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
	eval $APT update
	"Updating..."
	eval $APT upgrade -y
	eval $APT dist-upgrade -y
#Else if $1 is fix
elif [ $1 = "fix" ]
then
	rm /var/lib/apt/lists/lock &
	rm /var/cache/apt/archives/lock &
	rm /var/lib/dpkg/lock &
	dpkg --configure -a
	eval $APT update
	eval $APT -f -y install
#Else if $1 is clean
elif [ $1 = "clean" ]
then
	echo "Cleaning apt cache..."	
	eval $APT clean
	eval $APT autoclean
	echo "Press 'y' to remove old/unused packages..."
	eval $APT autoremove
fi
