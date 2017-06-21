FROM php:7.0.13-fpm

MAINTAINER "Pengo Development Team"

ENV PENGO_REPO_PUBLIC_KEY="236573746120657320756e6120636c617665206c6172676123"

ENV SERVER_NAME="localhost"
ENV WEBSERVER_USER="www-data"

ENV PHP_EXTRA_CONFIGURE_ARGS="--enable-fpm --with-fpm-user=${WEBSERVER_USER} --with-fpm-group=${WEBSERVER_USER}"
ENV PHP_HOST="127.0.0.1"
ENV PHP_PORT="9000"
ENV PHP_MEMORY_LIMIT="2G"
ENV PHP_MAXEXECUTION_TIME="18000"
ENV PHP_UPLOAD_MAX_FILESIZE="100M"
ENV PHP_POST_MAX_SIZE="100M"
ENV PHP_MAX_IMPUT_VARS="5000"
ENV PHP_DISPLAY_ERRORS="On"

ENV MAGENTO_USER="magento2"
ENV MAGENTO_VERSION="project-community-edition=2.1.6"
ENV MAGENTO_REPO_PUBLIC_KEY="2d6040b5384fca8a83388639194a9030"
ENV MAGENTO_REPO_PRIVATE_KEY="63f1690d868495884ab274bcef884f0b"
ENV MAGENTO_DEPLOY_MODE="developer"
ENV MAGENTO_BASE_URL="http://magento2dev.pengostores.mx/"
ENV MAGENTO_BACKEND_FRONTNAME="admindev"
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

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
    apt-utils \
    ssh \
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
    supervisor \
    mysql-client \
    ocaml \
    expect \
    librabbitmq-dev \
    erlang-nox \
    logrotate \
    socat \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /build/ \
    
## PHP
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-configure hash --with-mhash \
&& docker-php-ext-install -j$(nproc) mcrypt mbstring intl xsl gd zip pdo_mysql opcache soap bcmath json iconv \
&& docker-php-ext-install bcmath \
    
## Composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& rm -rf /usr/local/etc/php-fpm.d/* 

## Xdebug
RUN cd /tmp && wget -c "http://xdebug.org/files/xdebug-2.5.0.tgz" \
    && tar -xf xdebug-2.5.0.tgz \
    && cd xdebug-2.5.0 \
    && phpize \
    && ./configure \
    && make && make install
           
## Git
RUN cd /tmp && wget https://www.kernel.org/pub/software/scm/git/git-2.9.2.tar.gz
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

## Grunt
WORKDIR /tmp/grunt
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update \
    && apt-get install -y build-essential nodejs
RUN npm install -g express \
    && npm install -g grunt-cli
         
# PHP config
COPY conf/php.ini /usr/local/etc/php/

# php-fpm config
COPY conf/www.conf /usr/local/etc/php-fpm.d/

# nginx config
COPY conf/nginx.conf /etc/nginx/
COPY conf/default.conf /etc/nginx/conf.d/

# create magento2 user
RUN useradd -m -d /home/${MAGENTO_USER} -s /bin/bash ${MAGENTO_USER} && usermod -g www-data ${MAGENTO_USER} && usermod -aG sudo ${MAGENTO_USER}

# repo.magento
COPY keys/auth.json /home/${MAGENTO_USER}/.composer/

# icebrick
RUN mkdir /home/${MAGENTO_USER}/.ssh
COPY keys/id_rsa /home/${MAGENTO_USER}/.ssh
COPY keys/id_rsa.pub /home/${MAGENTO_USER}/.ssh
COPY keys/known_hosts /home/${MAGENTO_USER}/.ssh
RUN chown ${MAGENTO_USER} /home/${MAGENTO_USER}/.ssh && \
   chmod 600 /home/${MAGENTO_USER}/.ssh/id_rsa && \
   chmod 644 /home/${MAGENTO_USER}/.ssh/id_rsa.pub  && \
   chmod 600 /home/${MAGENTO_USER}/.ssh/known_hosts
COPY bin/m2install.sh /home/${MAGENTO_USER}/
COPY bin/composer_update /home/${MAGENTO_USER}/
COPY bin/composer_update.sh /home/${MAGENTO_USER}/
RUN chmod +x /home/${MAGENTO_USER}/m2install.sh

COPY bin/cronjobs.sh /home/${MAGENTO_USER}/

# supervisord config
RUN rm /etc/supervisor/supervisord.conf
COPY conf/supervisord.conf /etc/supervisord.conf

# entrypoint
COPY bin/entrypoint.sh /usr/local/bin/
    
EXPOSE 80 44100
WORKDIR /var/www/html
USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
