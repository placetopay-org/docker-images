FROM laravelphp/vapor:php80

RUN apk del icu-data-en && apk add icu-data-full

RUN pecl install pcov && \
    docker-php-ext-enable pcov

# Added for better RSA encryption/decryption
RUN apk --update add gmp-dev && \
    docker-php-ext-install gmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apk add --no-cache git

COPY . /var/task
