#!/bin/bash
#THIS SCRIPT IS IN BETA AND HAS NOT BEEN TESTED YET
#Make function to check for installed apps
check_installed(){
  installed=$1
  checkFor=$2
  if echo "$installed" | grep "$checkFor"
  then
    return 1
  else
    return 0
  fi
}
#Made from https://www.tecmint.com/install-wordpress-on-ubuntu-16-04-with-lamp/
#Check for root, and exit if not root
if [ $(whoami) != "root" ]
then
  echo "Please run as root."
  exit 0
fi
#Print welcome messages
echo "This script will help you install the WordPress CMS on your server."
echo "This script will only work on Ubuntu or Debian distros, are you on a Debian Based distro?"
read -p "y)es or n)o?: " yesno1
if [ $yesno1 != "y" ]
then
  echo "Sorry, more Operating System support will be coming soon."
  exit 0
fi
#Check for installed packages
echo "Checking installed packages..."
apps=$(dpkg --list)
if [ $(check_installed $apps "apache2") ] || [ $(check_installed $apps "nginx") ] || [ $(check_installed $apps "mysql") ]
then
  echo "Warning, you appear to have some web hosting and/or database software installed."
  echo "This script will OVERWRITE those. Please make a backup of all current contents."
  echo "Type 'y' if you already have a backup..."
  read -p "Do you have a backup y)es or n)o?: " alreadyInstalled
  if [ $alreadyInstalled != "y" ]
  then
    echo "OK. Bye"
    exit 0
  fi
fi
#Install required packages
echo "Installing apache2..."
apt install -y apache2
echo "Installing PHP..."
apt install -y  php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
echo "Installing MariaDB: "
echo "Please remember the password you enter if you are promtped for one."
apt install -y mariadb-server-10.0
echo "Required packages installed... moving on"
echo "Downloading WordPress..."
cd /tmp
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rsync -av wordpress/* /var/www/html
chown -R www-data /var/www/html
#Make DB
echo "Creating DB..."
echo "CREATE DATABASE wp_myblog" | mysql 
#Generate password
password=$(openssl rand -base64 32)
echo "GRANT ALL PRIVILEGES ON wp_myblog.* TO 'wp-user'@'localhost' IDENTIFIED BY \"$password\";" | mysql
echo "FLUSH PRIVILEGES" | mysql
#set up wp-config.php
cd /var/www/html
cat > wp-config.php <<EOF
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wp_myblog');
/** MySQL database username */
define('DB_USER', 'wp_user');
/** MySQL database password */
define('DB_PASSWORD', "$password");
/** MySQL hostname */
define('DB_HOST', 'localhost');
/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');
/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
$(curl https://api.wordpress.org/secret-key/1.1/salt/)
/**#@-*/
/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);
/* That's all, stop editing! Happy blogging. */
/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
EOF
#Get IP
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "Install done, finish setting up at: http://$ip or your domain name."
