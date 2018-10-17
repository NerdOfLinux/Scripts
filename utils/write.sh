#!/bin/bash
#Everyone loves ASCII Art(thanks figlet)
cat <<EOF
__        __    _ _             _     
\ \      / / __(_) |_ ___   ___| |__  
 \ \ /\ / / '__| | __/ _ \ / __| '_ \ 
  \ V  V /| |  | | ||  __/_\__ \ | | |
   \_/\_/ |_|  |_|\__\___(_)___/_| |_|

EOF
echo "Please select a user: "
#Pipe all users into column to support large amounts of users
who | cut -d " " -f 1 | column
read -p "User: " userName
#Check if user exists and is logged on
for loggedIn in $(who | cut -d " " -f 1)
do
	if [ $loggedIn = $userName ]
	then
		userFound="yes"
		echo "User found..."
		break
	fi
done
if [ -z $userFound ]
then
	echo "User could NOT be found"
	exit 2
fi
echo "What is your message?"
read -p "Message: " message
#Verify you're not writing to yourself
if [ "$USER" = "$userName" ]
then
        echo "Warning! You are writing to yourself"
        read -p "Type 'y' to continue: " yesNo
        if [ "$yesNo" != "y" ]
        then
                echo "Bye."
                exit 1
        fi
fi
#Actually write the message
echo "$message" | write "$userName" >/dev/null 2>&1
echo "Wrote \"$message\" to $userName"
