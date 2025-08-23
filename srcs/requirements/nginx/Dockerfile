FROM alpine:3.21

RUN apk update
RUN apk add --no-cache nginx
RUN addgroup -g 1001 www && adduser -D -s /sbin/nologin -H -u 1001 -G www www
RUN mkdir -p /var/www/html/
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /var/www/html/
RUN chown -R www:www /www

COPY install.sh .
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod +x install.sh
RUN ./install.sh

CMD ["nginx", "-g", "daemon off;"]
