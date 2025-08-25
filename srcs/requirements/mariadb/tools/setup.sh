#!/bin/sh

set -e

mkdir -p /var/run/mysqld

echo "before INSTALL TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
mysql_install_db --user=mysql --datadir=${DB_DATADIR}
echo "before DAEMON TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
mysqld --user=mysql --skip-networking=0 --bind-address=0.0.0.0 --port=3306 --datadir=${DB_DATADIR} &


echo "before TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
sleep 2
echo "AFTER TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
export DB_PASSWORD=$(cat /run/secrets/db_password)
mariadb -e "DELETE FROM mysql.user WHERE User='';"
mariadb -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB};"
mariadb -e "CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb -e "GRANT ALL ON ${WORDPRESS_DB}.* TO '${WP_DB_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root
mysqld --bind-address=0.0.0.0 --port=3306 --user=root
