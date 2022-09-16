FROM centos:centos7

# Maintainer
MAINTAINER "Diego Calle <diego.calle@placetopay.com>"

# Mandatory packages
RUN yum -y update && yum -y install epel-release yum-utils

# Enable REMI REPO
RUN rpm -ivh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y update && \
    yum-config-manager --enable remi-php74

# Install PHP and its extensions
RUN yum -y install \
    epel-release \
    git \
    gnupg1 \
    unzip \
    php \
    php-cli \
    php-common \
    php-mysql \
    php-mbstring \
    php-xml \
    php-simplexml \
    php-pdo \
    php-imap \
    php-soap \
    php-json \
    php-xmlrpc \
    php-gd \
    php-zip \
    php-intl \
    php-bcmath \
    php-pecl-xdebug \
    php-gmp \
    php-sodium


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
