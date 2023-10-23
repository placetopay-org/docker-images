FROM laravelphp/vapor:php82-arm

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
