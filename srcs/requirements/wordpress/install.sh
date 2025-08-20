
set -e

if [ ! -d $WP_DATADIR ]; then
	echo "Initializing wordpress"
	mkdir -p $WP_DATADIR
	chown -R www-data:www-data $WP_DATADIR
	cd $WP_DATADIR
	curl -o latest.tar.gz https://wordpress.org/latest.tar.gz \
		&& tar -xzf latest.tar.gz --strip-components=1 \
		&& rm latest.tar.gz
	echo "INIT END"
fi

exec php-fpm84 -F
