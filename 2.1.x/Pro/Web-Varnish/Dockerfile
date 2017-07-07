FROM php:7.0.13-fpm

MAINTAINER "Pengo Development Team"

ENV MAGENTO_REPO_PUBLIC_KEY="2d6040b5384fca8a83388639194a9030"
ENV MAGENTO_REPO_PRIVATE_KEY="63f1690d868495884ab274bcef884f0b"

ENV PENGO_REPO_PUBLIC_KEY="236573746120657320756e6120636c617665206c6172676123"

ENV MAGENTO_USER="magento2"
ENV MAGENTO_VERSION="2.1.6"
ENV MAGENTO_DEPLOY_MODE="production"
ENV MAGENTO_REPO_PUBLIC_KEY="2d6040b5384fca8a83388639194a9030"
ENV MAGENTO_REPO_PRIVATE_KEY="63f1690d868495884ab274bcef884f0b"
ENV MAGENTO_BASE_URL="http://magento2pro.pengostores.mx/"
ENV MAGENTO_BACKEND_FRONTNAME="adminpro"
ENV MAGENTO_TIMEZONE="America/Mexico_City"
ENV MAGENTO_CURRENCY="MXN"
ENV MAGENTO_LANGUAGE="es_MX"
ENV MAGENTO_DB_HOST="mysql"
ENV MAGENTO_DB_USERNAME="root"
ENV MAGENTO_DB_PASSWORD="mysql"
ENV MAGENTO_DB_NAME="magento2"
ENV MAGENTO_ADMIN_USER="pengo"
ENV MAGENTO_ADMIN_PASSWORD="p3ng023#"
ENV MAGENTO_ADMIN_EMAIL="svchumboldt@pengostores.com"

ENV SERVER_NAME="localhost"
ENV WEBSERVER_USER="www-data"

ENV NGINX_FASTCGI_READ_TIMEOUT="300"
ENV NGINX_CLIENT_MAX_BODY_SIZE="100M"
ENV NGINX_KEEPALIVE_TIMEOUT="300s"
ENV NGINX_PORT="8080"
ENV NGINX_WORKER_PROCESSES="1"

ENV SSL_NAME_CRT="common.crt"
ENV SSL_NAME_KEY="common.key"
ENV SSL_PROTOCOLS="TLSv1.1 TLSv1.2"
ENV SSL_CIPHERS="AES128+EECDH:AES128+EDH:!aNULL"
ENV SSL_SESSION_CACHE="shared:SSL:10m"
ENV SSL_SESSION_TIMEOUT="24h"

ENV PHP_EXTRA_CONFIGURE_ARGS="--enable-fpm --with-fpm-user=${WEBSERVER_USER} --with-fpm-group=${WEBSERVER_USER}"
ENV PHP_HOST="127.0.0.1"
ENV PHP_PORT="9000"
ENV PHP_MEMORY_LIMIT="2G"
ENV PHP_MAXEXECUTION_TIME="18000"
ENV PHP_UPLOAD_MAX_FILESIZE="100M"
ENV PHP_POST_MAX_SIZE="100M"
ENV PHP_MAX_IMPUT_VARS="10000"
ENV PHP_SESSION_AUTO_START="off"
ENV PHP_ZLIB_OUTPUT_COMPRESSION="on"
ENV PHP_TIME_ZONE="America/Mexico_City"
ENV PHP_DISPLAY_ERRORS="Off"
ENV PHP_OPCACHE_REVALIDATE_FREQ="10"
ENV PHP_PM_VAR="dynamic"
ENV PHP_PM_MAX_CHILDREN="10"
ENV PHP_PM_START_SERVERS="4"
ENV PHP_PM_MIN_SPARE_SERVERS="1"
ENV PHP_PM_MAX_SPARE_SERVERS="5"
ENV SUHOSIN_SESSION_CRYPTUA="off"

ENV REDIS_MAX_MEMORY="# maxmemory <bytes>"

ENV VARNISHD_PORT="80"
ENV VARNISHD_CACHE_SIZE="512G"
ENV VARNISHD_PARAMS="-p default_ttl=3600 -p default_grace=3600"

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
    apt-utils \
    ssh \
    sudo \
    wget \
    unzip \
    cron \
    curl \
    libmcrypt-dev \
    libicu-dev \
    libxml2-dev \
    libxslt1-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libexpat1-dev \
    libpng12-dev \
    libcurl4-gnutls-dev \
    libz-dev \
    libssl-dev \
    build-essential \
    tcl8.5 \
    gettext \
    lsof \
    vim \
    openssh-server \
    supervisor \
    mysql-client \
    ocaml \
    expect \
    librabbitmq-dev \
    erlang-nox \
    logrotate \
    socat \
    net-tools \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /build/ \

## PHP
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-configure hash --with-mhash \
&& docker-php-ext-configure opcache --enable-opcache \
&& docker-php-ext-install -j$(nproc) mcrypt mbstring intl xsl gd zip pdo_mysql opcache soap bcmath json iconv \
&& docker-php-ext-install bcmath \
    
## Composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& rm -rf /usr/local/etc/php-fpm.d/* 
           
## Git
RUN wget https://www.kernel.org/pub/software/scm/git/git-2.9.2.tar.gz
RUN tar -xzf git-2.9.2.tar.gz
RUN cd /tmp/git-2.9.2 && make configure && ./configure --prefix=/usr/local && make install
    
## Nginx
COPY keys/nginx_signing.key /tmp/
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && echo "deb-src http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-key add nginx_signing.key && apt-get clean && apt-get update && apt-get install -y nginx \
    && mkdir -p /etc/nginx/sites-available/ \ 
    && rm /etc/nginx/nginx.conf \
    && rm /etc/nginx/conf.d/default.conf
    
## Redis
#RUN RUN groupadd -r redis && useradd -r -g redis redis
RUN wget http://download.redis.io/redis-stable.tar.gz \
    && tar xzf redis-stable.tar.gz \
    && cd redis-stable \
    && make && make test && make install \
    && mkdir -p /redis/data

## Varnish
RUN apt-get update && RUNLEVEL=1 apt-get install -y varnish && rm /etc/varnish/default.vcl
COPY conf/default.vcl /etc/varnish/
     
# PHP config
COPY conf/php.ini /usr/local/etc/php/

# php-fpm config
COPY conf/www.conf /usr/local/etc/php-fpm.d/

# nginx config
COPY conf/nginx.conf /etc/nginx/
COPY conf/default.conf /etc/nginx/conf.d/

# redis config
COPY conf/redis.conf /etc/redis/redis.conf

# set permisions schema
RUN chown -R root:${WEBSERVER_USER} /var/www/html

# repo.magento
COPY keys/auth.json /root/.composer/

# icebrick
RUN mkdir /root/.ssh
COPY keys/id_rsa /root/.ssh
COPY keys/id_rsa.pub /root/.ssh
COPY keys/known_hosts /root/.ssh
RUN chown root /root/.ssh && \
   chmod 600 /root/.ssh/id_rsa && \
   chmod 644 /root/.ssh/id_rsa.pub  && \
   chmod 600 /root/.ssh/known_hosts
COPY bin/m2install.sh /root/
RUN chmod +x /root/m2install.sh

COPY bin/cronjobs.sh /root/

# supervisord config
RUN rm /etc/supervisor/supervisord.conf
COPY conf/supervisord.conf /etc/supervisord.conf

# entrypoint
COPY bin/entrypoint.sh /usr/local/bin/

EXPOSE 80 8080 443 9000 6379 44100
WORKDIR /var/www/html
USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
