FROM --platform=linux/arm64 php:8.4-fpm-alpine

ONBUILD ARG __VAPOR_RUNTIME=
ONBUILD RUN if [ -z "$__VAPOR_RUNTIME" ] ; then \
    echo "No runtime provided. Please upgrade to the latest version of laravel/vapor-cli." ; \
    exit 1 ; \
    elif [ "$__VAPOR_RUNTIME" != "docker-arm" ] ; then \
    echo "The provided runtime [$__VAPOR_RUNTIME] is not supported by the vapor:php84-arm base image." ; \
    exit 1 ; \
    fi

RUN apk --update add \
    wget \
    curl \
    build-base \
    libmcrypt-dev \
    libxml2-dev \
    pcre-dev \
    zlib-dev \
    autoconf \
    oniguruma-dev \
    openssl \
    openssl-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    jpeg-dev \
    libpng-dev \
    imagemagick-dev \
    imagemagick \
    postgresql-dev \
    libzip-dev \
    gettext-dev \
    libxslt-dev \
    libgcrypt-dev \
    linux-headers && \
    rm /var/cache/apk/*

RUN pecl channel-update pecl.php.net && \
    pecl install redis-6.1.0 && \
    rm -rf /tmp/pear

RUN docker-php-ext-install \
    mysqli \
    mbstring \
    pdo \
    pdo_mysql \
    xml \
    pcntl \
    bcmath \
    pdo_pgsql \
    zip \
    intl \
    gettext \
    soap \
    sockets \
    xsl

RUN docker-php-ext-configure gd --with-freetype=/usr/lib/ --with-jpeg=/usr/lib/ && \
    docker-php-ext-install gd

RUN docker-php-ext-enable redis

RUN cp "/etc/ssl/cert.pem" /opt/cert.pem

COPY runtime/bootstrap /opt/bootstrap
COPY runtime/bootstrap.php /opt/bootstrap.php
COPY runtime/php.ini /usr/local/etc/php/php.ini

RUN chmod 755 /opt/bootstrap
RUN chmod 755 /opt/bootstrap.php

RUN apk del icu-data-en && apk add icu-data-full

RUN apk add --no-cache tzdata

RUN pecl install pcov && \
    docker-php-ext-enable pcov

# Added for better RSA encryption/decryption
RUN apk --update add gmp-dev && \
    docker-php-ext-install gmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache git mysql-client
RUN apk add gnupg1 --repository=http://dl-cdn.alpinelinux.org/alpine/v3.15/community/


RUN /bin/sh -c set -eux;  printf "[client]\nprotocol=tcp" > /etc/my.cnf # buildkit

COPY . /var/task