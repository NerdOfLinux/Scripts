#!/bin/bash
#Create function
check_install()
{
    browser=$1
    if [ $(which $browser) ]
    then
        install_status="True"
        echo "Already installed."
        exit
    else
        install_status="False"
    fi
    #if [ $install_status = "True" ]
    #then
    #    echo "Already installed."
    #    exit
    #fi
}
#Check for root
if [ $(whoami) != "root" ]
then
    echo "Please run as root."
    exit
fi
#If $1 is blank, then get browser
if [ -z $1 ]
then
    echo "Which browser would you like(ex: chrome, opera)?"
    read -p "Browser: " browser
else
    browser=$1
fi
#For opera
if [ $browser == "opera" ]
then
   #Check install status  
    check_install $browser
    if [ $install_status = "False" ]
    then
        #Install
        wget http://download2.operacdn.com/pub/opera/desktop/45.0.2552.812/linux/opera-stable_45.0.2552.812_amd64.deb
        dpkg -i opera-stable_45.0.2552.812_amd64.deb
    else
        echo "Error, please try again"
        exit
    fi
#Else if browser is chrome
elif [ $browser == "crhome" ]
then
    #Check install status  
    check_install $browser
    if [ $install_status == "False" ]
    then
        #Install
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        dpkg -i google-chrome-stable_current_amd64.deb
        echo "Run google-chrome-stable to launch!"
    else
        echo "Error, please try again"
        exit
    fi
fi
