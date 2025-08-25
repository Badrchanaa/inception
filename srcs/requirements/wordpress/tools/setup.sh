
set -e

if [ -z $(ls -A "$WP_DATADIR") ]; then
	echo "Installing wordpress DATADIR="$WP_DATADIR
	wp core download --path=$WP_DATADIR

	wp config create --path=$WP_DATADIR \
		--dbname=$WORDPRESS_DB --dbuser="$WP_DB_USER" \
		--dbpass="$(cat /run/secrets/db_password)" --dbhost=$DB_HOST

	wp core install --url=$HOSTNAME --path=$WP_DATADIR --title="$WP_TITLE" \
		--admin_user=$WP_ADMIN --admin_password=$(cat /run/secrets/wp_admin_password) \
		--admin_email=$WP_ADMIN_EMAIL --skip-email

	wp user create $WP_USER $WP_USER_EMAIL --role=subscriber \
		--user_pass=$(cat /run/secrets/wp_user_password) --path=$WP_DATADIR
fi

exec php-fpm84 -F
