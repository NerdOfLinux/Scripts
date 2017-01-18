#This script install earlyoom
#If the directory already exists
if [ -d "earlyoom" ]
then
  echo "There is already a folder names earlyoom, please remove or rename it."
  #Exit
  exit 0
fi
#Check for git
if [ $(which git) ]
then
  git clone https://github.com/rfjakob/earlyoom.git
#Else if curl is installed
elif [ $(which curl) ]
then
  #Get and unzip repository
  curl https://codeload.github.com/rfjakob/earlyoom/zip/master -o master.zip
  unzip master.zip -d earlyoom
#
