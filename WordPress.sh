#!/bin/bash
#Make function to check for installed apps
check_installed(){
  installed = $1
  checkFor = $2
  if echo "$installed" | grep "$checkFor"
  then
    return 1
  else
    return 0
  fi
}
#Made from https://www.tecmint.com/install-wordpress-on-ubuntu-16-04-with-lamp/
#Check for root, and exit if not root
if [ $(whoami) != "root" ]
then
  echo "Please run as root."
  exit 0
fi
#Print welcome messages
echo "This script will help you install the WordPress CMS on your server."
echo "This script will only work on Ubuntu or Debian distros, are you on a Debian Based distro?"
read -p "y)es or n)o?: " yesno1
if [ $yesno1 != "y" ]
then
  echo "Sorry, more Operating System support will be coming soon."
  exit 0
fi
#Check for installed packages
echo "Checking installed packages..."
apps=$(dpkg --list)
if check_installed $apps "apache2"
then
  echo "Apache installed."
else
  echo "Apache will be installed."
fi
