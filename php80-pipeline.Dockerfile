FROM laravelphp/vapor:php80

RUN pecl install pcov
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apk add --no-cache git

COPY . /var/task
