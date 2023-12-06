FROM amazonlinux:2.0.20231116.0

# Maintainer
MAINTAINER "Diego Calle <diego.calle@placetopay.com>"

# Mandatory packages
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y update
RUN yum install -y gnupg1 git wget gzip tar \
    php74 php74-php-gmp php74-php-json php74-php-mbstring php74-php-cli php74-php-sodium php74-php-json php74-php-soap php74-php-xml php74-php-pecl-pcov php74-php-bcmath php74-php-pdo php74-php-pecl-zip php74-php-intl php74-php-pecl-mysql php74-php-mysqlnd php74-php-gd \
    mysql which

RUN ln -s /usr/bin/php74 /usr/bin/php

RUN wget -O /composer-setup.php https://getcomposer.org/installer && \
    php /composer-setup.php && \
    rm /composer-setup.php && \
    mv /composer.phar /usr/bin/composer && \
    composer config --global process-timeout 2000
