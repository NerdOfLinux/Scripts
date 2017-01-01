if [ $(whoami) != "root" ]
then
	echo "Please run as root."
	exit 0
fi
if [ -z $1 ]
then
	echo "Updating package indexes..."
	apt update
	"Updating..."
	apt upgrade -y
	apt dist-upgrade -y
elif [ $1 = "fix" ]
then
	rm /var/lib/apt/lists/lock
	rm /var/cache/apt/archives/lock
	rm /var/lib/dpkg/lock
	dpkg --configure -a
	apt update
elif [ $1 = "clean" ]
then
	echo "Cleaning apt cache..."
	apt clean
	apt autoclean
	echo "Removing old/unused packages..."
	apt autoremove -y
fi
