FROM --platform=linux/amd64 php:8.4-fpm-bullseye

# Install `docker-php-ext-install` helper to ease installation of PHP
# extensions
#
# Ref: https://github.com/mlocati/docker-php-extension-installer
ENV PHP_EXT_INSTALLER_VERSION=2.9.20

RUN set -eux; \
      curl --fail -Lo /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/download/${PHP_EXT_INSTALLER_VERSION}/install-php-extensions; \
      chmod +x /usr/local/bin/install-php-extensions

# Install common PHP extensions (using `install-php-extensions`)
# (no need to install mbstring, pdo, sodium, openssl, tokenizer or xml as they are already part of base image)
RUN set -eux; \
      install-php-extensions \
        bcmath \
        exif \
        gd \
        gettext \
        intl \
        mcrypt \
        mysqli \
        redis \
        pcov \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        soap \
        sockets \
        xsl \
        zip \
        gnupg \
        gmp \
        ftp \
        @composer \
      ;

COPY ./runtime/bootstrap /opt/bootstrap
COPY ./runtime/bootstrap.php /opt/bootstrap.php
COPY ./runtime/php.ini /usr/local/etc/php/php.ini
COPY ./runtime/newrelic.cfg /usr/local/etc/newrelic/newrelic.cfg

RUN chmod 755 /opt/bootstrap
RUN chmod 755 /opt/bootstrap.php

RUN apt-get update -y && apt-get install -y wget git openjdk-17-jre-headless

# Download and install newrelic from: https://download.newrelic.com/php_agent/release/
RUN set -eux \
  && NEWRELIC_FILE=`curl -s "https://download.newrelic.com/php_agent/release/" |  \
    grep -o 'newrelic-php5.*\-linux.tar.gz' |  sed -e 's/^.*>//;s/<[^>]*>//g'` || exit; \
    curl -L "https://download.newrelic.com/php_agent/release/${NEWRELIC_FILE}" | tar -C /tmp -zx && \
    export NR_INSTALL_USE_CP_NOT_LN=1 && \
    export NR_INSTALL_SILENT=1 && \
    /tmp/newrelic-php5-*/newrelic-install install

# Remove installation files
RUN rm /usr/local/etc/php/conf.d/newrelic.ini

RUN wget -O /etc/ssl/cert.pem "https://curl.haxx.se/ca/cacert.pem" && \
    cp "/etc/ssl/cert.pem" /opt/cert.pem

ADD entrypoint.sh /var/task/entrypoint.sh

USER root
RUN chmod +x /var/task/entrypoint.sh
ENTRYPOINT ["/var/task/entrypoint.sh"]
