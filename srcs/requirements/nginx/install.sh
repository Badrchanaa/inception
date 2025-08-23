#!/bin/sh

mkdir /usr/share/nginx/html
cat << EOF > /usr/share/nginx/html/index.html
<h1>Nginx is working</h1>
<p>default nginx page</p>
EOF
chmod -R 755 /usr/share/nginx
