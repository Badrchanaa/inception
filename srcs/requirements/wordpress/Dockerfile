FROM alpine:3.21

RUN apk add --no-cache \
    php84-cli \
    php84-fpm \
    php84-mysqli \
    php84-pdo_mysql \
    php84-gd \
    php84-curl \
    php84-mbstring \
    php84-json \
    php84-xml \
    php84-openssl \
    php84-phar \
    curl \
    vim \
    tar

RUN addgroup -g 1000 www && adduser -D -s /sbin/nologin -H -u 1000 -G www www
RUN mkdir -p /var/www/html/
RUN mkdir -p /usr/log/php84/
RUN chown -R www:www /usr/log/php84/
RUN chown -R www:www /var/www/html/
RUN ln -s /usr/bin/php84 /usr/bin/php
WORKDIR wordpress
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ./wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY ./tools/setup.sh .
COPY conf/www.conf .
COPY conf/php.ini .
RUN mv php.ini /etc/php84/
RUN mv  www.conf /etc/php84/php-fpm.d/
RUN chmod +x setup.sh

CMD ["/bin/sh", "setup.sh"]
