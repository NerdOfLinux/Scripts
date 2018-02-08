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
#Get your PTS
yourPTS=$(tty | cut -d "/" -f 3,4)
read -p "User: " userName
echo "What is your message?"
read -p "Message: " message
#Get the user's PTS
userPTS=$(ps -u "$userName" | grep pts | cut -d " " -f 2 | head -n 1)
#Verify you're not writing to yourself
if [ "$userPTS" = "$yourPTS" ]
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
echo "$message" | write "$userName" "$userPTS"
echo "Wrote \"$message\" to $userName on $userPTS"
