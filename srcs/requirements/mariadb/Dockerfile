FROM alpine:3.21

RUN apk update
RUN apk add --no-cache mariadb mariadb-client

WORKDIR mariadb
COPY ./tools/setup.sh .
RUN chmod +x setup.sh
COPY ./conf/mariadb-server.cnf .
RUN mv mariadb-server.cnf /etc/my.cnf.d/

ENTRYPOINT ["/bin/sh", "./setup.sh"]
