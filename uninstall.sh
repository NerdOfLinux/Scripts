#This script is to test whether an application was installed with linuxbrew or apt
#If $1 is empty
if [ -z $1 ]
then
  echo "Please enter an application name:"
  read app
else
  app=$1
fi

#Check if linuxbrew is in the application install location
if [ $(which $app) | grep "linuxbrew") ]
then
  echo "The app is installed with brew."
  echo "Would you like to uninstall $app y)es or n)o?"
  read uninstall
  if [ $uninstall = "y" ]
  then
    #Remove the application using brew
    brew remove $app
  else
    echo "Ok. Exiting..."
    #Exit
    exit 0
  fi
  exit 0
#If the app location contains bin
#Although apps installed with linuxbrew are in a path named bin, the script exits if the app was installed with linuxbrew
elif [ $(which $app) | grep "bin") ]
then
  echo "The application was installed with apt."
  echo "Would you like to uninstall $app y)es or n)o?"
  read uninstall
  if [ $uninstall = "y" ]
  then
    #Check if the user is root
    if [ $(whoami) != "root" ]
    then
      echo "Please run as root to remove $app."
      #Exit
      exit 0
    fi
    apt purge $app -y
  else
    echo "Ok. Exiting..."
    #Exit
    exit 0
  fi
else
  echo "This application was not found."
fi
