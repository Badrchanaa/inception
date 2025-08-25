FROM alpine:3.21

ARG WP_DATA
RUN apk update
RUN apk add --no-cache nginx openssl
RUN addgroup -g 1001 www && adduser -D -s /sbin/nologin -H -u 1001 -G www www
RUN mkdir -p ${WP_DATA}
RUN mkdir /www
# RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www ${WP_DATA}
RUN chown -R www:www /www

COPY ./tools/install.sh .
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x install.sh
RUN ./install.sh

CMD ["nginx", "-g", "daemon off;"]
