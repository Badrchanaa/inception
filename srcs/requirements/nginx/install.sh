#!/bin/sh

mkdir -p /etc/nginx/ssl/
openssl req -x509 -newkey rsa:4096 -days 365 \
  -noenc -keyout "/etc/nginx/ssl/bchanaa.42.fr.key" -out "/etc/nginx/ssl/bchanaa.42.fr.crt" -subj "/CN=$HOSTNAME"
