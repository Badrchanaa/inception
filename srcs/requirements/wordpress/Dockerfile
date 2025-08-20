FROM alpine:3.21

RUN apk add --no-cache \
    php84-fpm \
    php84-mysqli \
    php84-pdo_mysql \
    php84-gd \
    php84-curl \
    php84-mbstring \
    php84-json \
    curl \
    tar \

COPY ./install.sh .
RUN chmod +x install.sh

WORKDIR /var/www/html

ENTRYPOINT["/bin/sh", "install.sh"]
