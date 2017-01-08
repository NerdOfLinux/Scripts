#Update script for Ubuntu
#Check that user is root
if [ $(whoami) != "root" ]
then
	echo "Please run as root."
	#Exit
	exit 0
fi
#If $1 is empty
if [ -z $1 ]
then
	echo "Updating package indexes..."
	apt update
	"Updating..."
	apt upgrade -y
	apt dist-upgrade -y
#Else if $1 is fix
elif [ $1 = "fix" ]
then
	rm /var/lib/apt/lists/lock
	rm /var/cache/apt/archives/lock
	rm /var/lib/dpkg/lock
	dpkg --configure -a
	apt update
#Else if $1 is clean
elif [ $1 = "clean" ]
then
	echo "Cleaning apt cache..."
	apt clean
	apt autoclean
	echo "Removing old/unused packages..."
	apt autoremove -y
fi
