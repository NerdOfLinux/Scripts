#!/bin/bash
if [ $(whoami) != "root" ]
then
  echo "Please run this script as root."
  exit 1
fi
#Install dependencies, nothing gets installed if already present
echo "Press 'Y' if prompted."
apt install build-essential
#Move to /tmp
cd /tmp
#Clone the repository if the folder does not exist
if [ ! -d /tmp/rtlwifi_new ]
then
  git clone https://github.com/lwfinger/rtlwifi_new.git
else
  echo "Folder already found, running make clean, then trying again"
  cd rtlwifi_new
  make clean
  cd ..
fi
cd rtlwifi_new
#Build everything
make
make install
#Enable the module
if modprobe rtl8821ae
then
  echo "Drivers installed."
else
  echo "Oops, something went wrong, please try again"
fi
