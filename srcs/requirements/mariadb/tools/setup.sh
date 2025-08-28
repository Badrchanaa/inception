#!/bin/sh

set -e

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi


init_database()
{
	rm -rf $DB_DATADIR/*
	DB_PASSWORD=$(cat /run/secrets/db_password)
	DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
	echo "initializing db, datadir=" $DB_DATADIR
	chown -R mysql:mysql "$DB_DATADIR"
	mariadb-install-db --user=mysql --datadir="$DB_DATADIR"
	mariadbd --user=mysql --datadir="$DB_DATADIR" --bootstrap << EOF

FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB};
CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL ON ${WORDPRESS_DB}.* TO '${WP_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	unset DB_PASSWORD;
	unset DB_ROOT_PASSWORD;
	echo "END INIT"
}
	
if [ -z "${DB_DATADIR}" ]; then
	echo "Database directory not set"
	exit 1
fi

mkdir -p "$DB_DATADIR"
if [ ! -d "$DB_DATADIR/mysql" ]; then
	init_database
fi

exec mariadbd --user=mysql --datadir="$DB_DATADIR"
