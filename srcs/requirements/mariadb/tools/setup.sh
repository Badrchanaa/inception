#!/bin/sh

set -e

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

init_database()
{
	rm -rf $DB_DATADIR/*
	echo "initializing db, datadir=" $DB_DATADIR
	chown -R mysql:mysql "$DB_DATADIR"
	mariadb-install-db --user=mysql --datadir="$DB_DATADIR"
	mariadbd --user=mysql --datadir="$DB_DATADIR" --bootstrap << EOF

FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE ${WORDPRESS_DB};
CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB}.* TO '${WP_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	echo "END INIT"
}
	
if [[ ! -v DB_DATADIR ]]; then
	echo "Database directory not set"
	exit 1
fi

mkdir -p "$DB_DATADIR"
if [ ! -d "$DB_DATADIR/mysql" ]; then
	init_database
fi

exec mariadbd --user=mysql --datadir="$DB_DATADIR"
