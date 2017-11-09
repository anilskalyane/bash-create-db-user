#Declare DB details variables
DB_HOST=52.187.3.60

echo "Please enter root user MySQL password!"
read rootpasswd

printf "\n***** Start DB User Creation *****\n"

mysql -h $DB_HOST -u root -p${rootpasswd} -e "SHOW DATABASES LIKE 'rubicon_%';" | while read -r rcDatabase
do
MAINDB=$rcDatabase

# assign username
USERNAME="$rcDatabase""AppAccess"

# create random password for APP USER
PASSWDDB="$(openssl rand -base64 15)"

# create application DB user access
: '
mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@'%' IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'%';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
'
echo "\n\n----- $rcDatabase DATABASE APP USER ACCESS -----\n" 

echo "USERNAME: $USERNAME"
echo "PASSWORD: $PASSWDDB" 

echo "\n----- END APP USER ACCESS -----\n\n"

# assign username
USERNAME="$rcDatabase""DevAccess"

# create random password for DEV USER
PASSWDDB="$(openssl rand -base64 15)"

# create developer DB user access - only view access 
: '
mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@'%' IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -p${rootpasswd} -e "GRANT SELECT PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'%';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
'

echo "\n----- $rcDatabase DATABASE DEV USER ACCESS -----\n"

echo "USERNAME: $USERNAME" 
echo "PASSWORD: $PASSWDDB" 

echo "\n----- END DEV USER ACCESS -----\n\n"

done

echo "***** Start DB User Creation *****"
