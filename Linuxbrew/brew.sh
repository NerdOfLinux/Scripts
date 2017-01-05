#This script is to make sure you aren't installing two of the same thing.
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
    echo "This may create some issues, if it does, run the uninstall.sh script."
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
  
