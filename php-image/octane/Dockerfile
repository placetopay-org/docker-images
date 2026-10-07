# Imagen única para todos los roles (web/scheduler/queue/migrate); el rol se elige
# en runtime con CONTAINER_ROLE. El código se copia con vendor/ ya instalado.
FROM dunglas/frankenphp:1-php8.2

RUN install-php-extensions \
        bcmath \
        gd \
        soap \
        zip \
        intl \
        pdo_mysql \
        redis \
        opcache \
        ftp \
        gmp \
        pcntl \
        posix \
    && apt-get update \
    && apt-get install -y --no-install-recommends gnupg git unzip ca-certificates default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./php/php.ini /usr/local/etc/php/conf.d/zz-app.ini
COPY ./php/opcache.ini /usr/local/etc/php/conf.d/zz-opcache.ini
COPY ./Caddyfile /etc/caddy/Caddyfile

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# la salud la revisa el ALB (/health), no el healthcheck de FrankenPHP
HEALTHCHECK NONE