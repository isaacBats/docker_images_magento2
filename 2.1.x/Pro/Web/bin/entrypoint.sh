#!/bin/bash

# php.ini
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sed -i "s/PHP_MEMORY_LIMIT/${PHP_MEMORY_LIMIT}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_MAXEXECUTION_TIME}" ] && sed -i "s/PHP_MAXEXECUTION_TIME/${PHP_MAXEXECUTION_TIME}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_UPLOAD_MAX_FILESIZE}" ] && sed -i "s/PHP_UPLOAD_MAX_FILESIZE/${PHP_UPLOAD_MAX_FILESIZE}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_POST_MAX_SIZE}" ] && sed -i "s/PHP_POST_MAX_SIZE/${PHP_POST_MAX_SIZE}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_SESSION_AUTO_START}" ] && sed -i "s/PHP_SESSION_AUTO_START/${PHP_SESSION_AUTO_START}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_ZLIB_OUTPUT_COMPRESSION}" ] && sed -i "s/PHP_ZLIB_OUTPUT_COMPRESSION/${PHP_ZLIB_OUTPUT_COMPRESSION}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_TIME_ZONE}" ] && sed -i "s/PHP_TIME_ZONE/${PHP_TIME_ZONE}/" /usr/local/etc/php/php.ini
[ ! -z "${SUHOSIN_SESSION_CRYPTUA}" ] && sed -i "s/SUHOSIN_SESSION_CRYPTUA/${SUHOSIN_SESSION_CRYPTUA}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_DISPLAY_ERRORS}" ] && sed -i "s/PHP_DISPLAY_ERRORS/${PHP_DISPLAY_ERRORS}/" /usr/local/etc/php/php.ini
[ ! -z "${PHP_OPCACHE_REVALIDATE_FREQ}" ] && sed -i "s/PHP_OPCACHE_REVALIDATE_FREQ/${PHP_OPCACHE_REVALIDATE_FREQ}/" /usr/local/etc/php/php.ini
# www.conf
[ ! -z "${WEBSERVER_USER}" ] && sed -i "s/WEBSERVER_USER/${WEBSERVER_USER}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${PHP_PORT}" ] && sed -i "s/PHP_PORT/${PHP_PORT}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${PHP_PM_VAR}" ] && sed -i "s/PHP_PM_VAR/${PHP_PM_VAR}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${PHP_PM_MAX_CHILDREN}" ] && sed -i "s/PHP_PM_MAX_CHILDREN/${PHP_PM_MAX_CHILDREN}/" /usr/local/etc/php-fpm.d/www.conf    
[ ! -z "${PHP_PM_START_SERVERS}" ] && sed -i "s/PHP_PM_START_SERVERS/${PHP_PM_START_SERVERS}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${PHP_PM_MIN_SPARE_SERVERS}" ] && sed -i "s/PHP_PM_MIN_SPARE_SERVERS/${PHP_PM_MIN_SPARE_SERVERS}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${PHP_PM_MAX_SPARE_SERVERS}" ] && sed -i "s/PHP_PM_MAX_SPARE_SERVERS/${PHP_PM_MAX_SPARE_SERVERS}/" /usr/local/etc/php-fpm.d/www.conf
[ ! -z "${MAGENTO_DEPLOY_MODE}" ] && sed -i "s/MAGENTO_DEPLOY_MODE/${MAGENTO_DEPLOY_MODE}/" /usr/local/etc/php-fpm.d/www.conf
# nginx.conf
[ ! -z "${WEBSERVER_USER}" ] && sed -i "s/WEBSERVER_USER/${WEBSERVER_USER}/" /etc/nginx/nginx.conf
# default.conf
[ ! -z "${SERVER_NAME}" ] && sed -i "s/SERVER_NAME/${SERVER_NAME}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${PHP_HOST}" ] && sed -i "s/PHP_HOST/${PHP_HOST}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${PHP_PORT}" ] && sed -i "s/PHP_PORT/${PHP_PORT}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${MAGENTO_DEPLOY_MODE}" ] && sed -i "s/MAGENTO_DEPLOY_MODE/${MAGENTO_DEPLOY_MODE}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${NGINX_FASTCGI_READ_TIMEOUT}" ] && sed -i "s/NGINX_FASTCGI_READ_TIMEOUT/${NGINX_FASTCGI_READ_TIMEOUT}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${NGINX_CLIENT_MAX_BODY_SIZE}" ] && sed -i "s/NGINX_CLIENT_MAX_BODY_SIZE/${NGINX_CLIENT_MAX_BODY_SIZE}/" /etc/nginx/conf.d/default.conf 
[ ! -z "${NGINX_KEEPALIVE_TIMEOUT}" ] && sed -i "s/NGINX_KEEPALIVE_TIMEOUT/${NGINX_KEEPALIVE_TIMEOUT}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_NAME_CRT}" ] && sed -i "s/SSL_NAME_CRT/${SSL_NAME_CRT}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_NAME_KEY}" ] && sed -i "s/SSL_NAME_KEY/${SSL_NAME_KEY}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_PROTOCOLS}" ] && sed -i "s/SSL_PROTOCOLS/${SSL_PROTOCOLS}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_CIPHERS}" ] && sed -i "s/SSL_CIPHERS/${SSL_CIPHERS}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_SESSION_CACHE}" ] && sed -i "s/SSL_SESSION_CACHE/${SSL_SESSION_CACHE}/" /etc/nginx/conf.d/default.conf
[ ! -z "${SSL_SESSION_TIMEOUT}" ] && sed -i "s/SSL_SESSION_TIMEOUT/${SSL_SESSION_TIMEOUT}/" /etc/nginx/conf.d/default.conf
# magento.repo
[ ! -z "${MAGENTO_REPO_PUBLIC_KEY}" ] && sed -i "s/MAGENTO_REPO_PUBLIC_KEY/${MAGENTO_REPO_PUBLIC_KEY}/" /root/.composer/auth.json
[ ! -z "${MAGENTO_REPO_PRIVATE_KEY}" ] && sed -i "s/MAGENTO_REPO_PRIVATE_KEY/${MAGENTO_REPO_PRIVATE_KEY}/" /root/.composer/auth.json
# pengo.repo
[ ! -z "${PENGO_REPO_PUBLIC_KEY}" ] && sed -i "s/PENGO_REPO_PUBLIC_KEY/${PENGO_REPO_PUBLIC_KEY}/" /root/.composer/auth.json
# redis
[ ! -z "${REDIS_MAX_MEMORY}" ] && sed -i "s/REDIS_MAX_MEMORY/${REDIS_MAX_MEMORY}/" /etc/redis/redis.conf

export PATH=$PATH:/var/www/html/bin

supervisord -n -c /etc/supervisord.conf
