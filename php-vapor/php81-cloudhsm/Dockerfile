FROM php:8.1-fpm-buster

# Install `docker-php-ext-install` helper to ease installation of PHP
# extensions
#
# Ref: https://github.com/mlocati/docker-php-extension-installer
ENV PHP_EXT_INSTALLER_VERSION=1.5.52

RUN set -eux; \
      curl --fail -Lo /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/download/${PHP_EXT_INSTALLER_VERSION}/install-php-extensions; \
      chmod +x /usr/local/bin/install-php-extensions

# Install common PHP extensions (using `install-php-extensions`)
# (no need to install mbstring, pdo, tokenizer or xml as they are already part of base image)
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
        @composer \
      ;

RUN apt-get update -y && apt-get install -y wget

RUN wget -O /etc/ssl/cert.pem "https://curl.haxx.se/ca/cacert.pem" && \
    cp "/etc/ssl/cert.pem" /opt/cert.pem

COPY ./runtime/bootstrap /opt/bootstrap
COPY ./runtime/bootstrap.php /opt/bootstrap.php
COPY ./runtime/php.ini /usr/local/etc/php/php.ini

RUN chmod 755 /opt/bootstrap
RUN chmod 755 /opt/bootstrap.php

ENTRYPOINT []

CMD /opt/bootstrap