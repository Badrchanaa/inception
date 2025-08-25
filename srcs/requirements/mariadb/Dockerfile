FROM alpine:3.21

RUN apk update
RUN apk add --no-cache mariadb mariadb-client

WORKDIR mariadb
COPY ./tools/install.sh .
RUN chmod +x install.sh
COPY ./config/mariadb-server.cnf .
RUN mv mariadb-server.cnf /etc/my.cnf.d/

ENTRYPOINT ["/bin/sh", "./install.sh"]
