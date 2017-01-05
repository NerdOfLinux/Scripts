#This script installs the rest of the repository
#If the directory already exists
if [ -d "Scripts" ]
then
  echo "There is already a folder names Scripts, please remove or rename it."
fi
#If curl is installed
if [ $(which curl) ]
then
  curl https://codeload.github.com/NerdOfLinux/Scripts/zip/master -o master.zip
else
  wget https://codeload.github.com/NerdOfLinux/Scripts/zip/master -o master.zip
fi
unzip master.zip
#Delete .zip file
rm master.zip
#Go into Scripts-master folder
cd Scripts-master
#Move files
mv * ../Scripts
#Run the setup file
sh setup.sh
