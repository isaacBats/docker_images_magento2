#!/bin/bash

[ ! -z "${MYSQL_THREAD_CONCURRENCY}" ] && sed -i "s/MYSQL_THREAD_CONCURRENCY/${MYSQL_THREAD_CONCURRENCY}/" /etc/mysql/my.cnf
[ ! -z "${MYSQL_INNODB_BUFFER_POOL_SIZE}" ] && sed -i "s/MYSQL_INNODB_BUFFER_POOL_SIZE/${MYSQL_INNODB_BUFFER_POOL_SIZE}/" /etc/mysql/my.cnf

