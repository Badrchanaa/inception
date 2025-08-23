
set -e

if [ -z $(ls -A "$WP_DATADIR") ]; then
	echo "Installing wordpress DATADIR="$WP_DATADIR
	wp core download --path=$WP_DATADIR
	export DB_PASSWORD=$(cat /run/secrets/db_password)
	export WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
	wp config create --path=$WP_DATADIR \
		--dbname=$WORDPRESS_DB --dbuser="$WP_DB_USER" \
		--dbpass="$DB_PASSWORD" --dbhost="mariadb:3306"
	wp core install --url=$HOSTNAME --path=$WP_DATADIR --title="Inception wordpress" \
		--admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=test@test.com --skip-email
	unset DB_PASSWORD
	unset WP_ADMIN_PASSWORD
	export WP_USER_PASSWORD = $(cat /run/secrets/wp_user_password)
	wp user create $WP_USER test@example.com --role=subscriber --user_pass=secret --path=/var/www/html
	echo "install END"
fi

exec php-fpm84 -F
