FROM mysql:5.7

MAINTAINER "Pengo Development Team"

ENV MYSQL_INNODB_BUFFER_POOL_SIZE="134217728"
ENV MYSQL_INNODB_THREAD_CONCURRENCY="0"

RUN rm -rf /etc/mysql/conf.d/* && \
    rm -rf /etc/mysql/mysql.conf.d/* && \
    rm /etc/mysql/my.cnf && rm /etc/mysql/mysql.cnf

COPY conf/my.cnf /etc/mysql/

COPY bin/config.sh /usr/local/bin/
RUN config.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]