#!/bin/sh
apk update
apk add --no-cache nginx
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

mkdir /usr/share/nginx/html
cat << EOF > /usr/share/nginx/html/index.html
<h1>Nginx is working</h1>
<p>default nginx page</p>
EOF
chmod -R 755 /usr/share/nginx
