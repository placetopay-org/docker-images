FROM laravelphp/vapor:php74

RUN apk add --no-cache tzdata git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Download and install newrelic from: https://download.newrelic.com/php_agent/release/
RUN set -eux \
  && NEWRELIC_FILE=`curl -s "https://download.newrelic.com/php_agent/release/" | grep -o 'newrelic-php5-\(\d\+.\)\+-linux-musl.tar.gz' | head -n 1` || exit; \
  curl -L "https://download.newrelic.com/php_agent/release/${NEWRELIC_FILE}" | tar -C /tmp -zx \
  && export NR_INSTALL_USE_CP_NOT_LN=1 \
  && export NR_INSTALL_SILENT=1 \
  && /tmp/newrelic-php5-*/newrelic-install install

RUN echo 'extension = "newrelic.so"' >> /usr/local/etc/php/php.ini
RUN echo 'newrelic.logfile = "/dev/null"' >> /usr/local/etc/php/php.ini
RUN echo 'newrelic.loglevel = "error"' >> /usr/local/etc/php/php.ini

# Remove installation files
RUN rm /usr/local/etc/php/conf.d/newrelic.ini

RUN mkdir -p /usr/local/etc/newrelic
RUN echo "loglevel=error" > /usr/local/etc/newrelic/newrelic.cfg
RUN echo "logfile=/dev/null" >> /usr/local/etc/newrelic/newrelic.cfg

ADD entrypoint.sh /var/task/entrypoint.sh

USER root
RUN chmod +x /var/task/entrypoint.sh
ENTRYPOINT ["/var/task/entrypoint.sh"]
