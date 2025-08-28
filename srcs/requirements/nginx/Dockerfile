FROM alpine:3.21

ARG WP_DATA
RUN apk update
RUN apk add --no-cache nginx openssl
RUN addgroup -g 1000 www && adduser -D -s /sbin/nologin -H -u 1000 -G www www
RUN mkdir -p ${WP_DATA}
RUN mkdir /www
RUN chown -R www:www ${WP_DATA}
RUN chown -R www:www /www

COPY ./tools/setup.sh .
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x setup.sh
RUN ./setup.sh

CMD ["nginx", "-g", "daemon off;"]
