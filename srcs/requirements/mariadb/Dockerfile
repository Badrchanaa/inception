FROM alpine:3.21

RUN apk update
RUN apk add --no-cache mariadb mariadb-client gettext

WORKDIR mariadb_setup
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
COPY ./tools/setup.sh .
COPY ./conf/init.sql.template .
RUN envsubst < ./init.sql.template > init.sql
RUN chmod +x setup.sh
COPY ./conf/mariadb-server.cnf .
RUN mv mariadb-server.cnf /etc/my.cnf.d/

ENTRYPOINT ["/bin/sh", "./setup.sh"]
