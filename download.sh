#This script installs the rest of the repository
#If the directory already exists
if [ -d "Scripts" ]
then
  echo "There is already a folder names Scripts, please remove it or rename i
#If curl is installed
if [ $(which curl) ]
then
  curl -O https://github.com/NerdOfLinux/Scripts/archive/master.zip
else
  wget https://github.com/NerdOfLinux/Scripts/archive/master.zip
fi
unzip master.zip -d Scripts
#Delete .zip file
rm master.zip
#Go into Scripts folder
cd Scripts
#Run the setup file
sh setup.sh
