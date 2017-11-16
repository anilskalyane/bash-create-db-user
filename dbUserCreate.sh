#!/bin/bash

#Declare DB details variables
echo "Please enter Host/IP"
#read DB_HOST
DB_HOST="localhost"
echo "Please enter the database name or prefix (if matched with multiple then individual user will create)"
#read databasePrefix

echo "Please enter root user MySQL password!"
#read rootpasswd
rootpasswd="aceturtle"
echo
printf "***** Start DB User Creation *****"
echo 

mysql -B -h $DB_HOST -u root -p${rootpasswd} -e "SHOW DATABASES LIKE 'f%';" | tail -n +2 | while read -r rcDatabase
do
#MAINDB=$rcDatabase
: ' 
replace "-" with "_" for database username
'
MAINDB=${rcDatabase//_/}
#MAINDB=${rcDatabase//-/_}

# assign username
USERNAME="$MAINDB""App"

# create random password for APP USER
PASSWDDB="$(openssl rand -base64 15)"

# create application DB user access

mysql -uroot -p${rootpasswd} -e "CREATE USER ${USERNAME}@'%' IDENTIFIED BY '"${PASSWDDB}"';"
mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON $rcDatabase.* TO ${USERNAME}@'%';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"

echo
echo
echo "----- $rcDatabase DATABASE APP USER ACCESS -----"
echo 

echo "USERNAME: $USERNAME"
echo "PASSWORD: $PASSWDDB" 

echo
echo "----- END APP USER ACCESS -----"
echo
echo

# assign username
USERNAME="$MAINDB""Dev"

# create random password for DEV USER
PASSWDDB="$(openssl rand -base64 15)"

# create developer DB user access - only view access 

mysql -uroot -p${rootpasswd} -e "CREATE USER ${USERNAME}@'%' IDENTIFIED BY '"${PASSWDDB}"';"
mysql -uroot -p${rootpasswd} -e "GRANT SELECT ON $rcDatabase.* TO ${USERNAME}@'%';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"

#mysql delete mysql users
#mysql -uroot -p${rootpasswd} -e "DELETE FROM mysql.user WHERE user LIKE 'rubicon%';"
#mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"

echo
echo "----- $rcDatabase DATABASE DEV USER ACCESS -----"
echo

echo "USERNAME: $USERNAME" 
echo "PASSWORD: $PASSWDDB" 

echo
echo "----- END DEV USER ACCESS -----"
echo
echo

done
echo "***** Start DB User Creation *****"

