FROM laravelphp/vapor:php81

RUN pecl install pcov && \
    docker-php-ext-enable pcov RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache git mysql-client gnupg1
RUN /bin/sh -c set -eux;  printf "[client]\nprotocol=tcp" > /etc/my.cnf # buildkit

COPY . /var/task
