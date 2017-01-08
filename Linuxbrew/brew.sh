#This script is to make sure you aren't installing two of the same thing.
if [ $1 = "uninstall" ]
then
 #If $2 is empty
if [ -z $2 ]
then
  echo "Please enter an application name:"
  read app
else
  app=$2
fi

#Check if linuxbrew is in the application install location
if [ $(which $app | grep "linuxbrew") ]
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
elif [ $(which $app | grep "bin") ]
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
fi
#If $1 is empty
if [ -z $1 ]
then
  echo "Which application would you like to install?"
  #Save user input to variable app
  read app
else
  app=$1
fi

#Check if application is installed
if [ $(which $app) ]
then
  echo "That application is already installed on this computer."
  echo "Would you still like to install it y)es or n)o?"
  #Save user input into variable response
  read response
  #If variable response is equal to y
  if [ $response = "y" ]
  then
    echo "This may create some issues, if it does,uninstall one of the versions."
    #Install the application
    brew install $app
  else
    echo "Ok. Exiting..."
    #Exit
    exit 0
  fi
else
  #Install the application
  brew install $app
fi

