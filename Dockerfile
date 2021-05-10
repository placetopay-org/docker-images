FROM laravelphp/vapor:php74

ENV NEWRELIC_VERSION 9.17.1.301
ENV NEWRELIC_NAME newrelic-php5-${NEWRELIC_VERSION}-linux-musl

# Download and install newrelic from: https://download.newrelic.com/php_agent/release/
RUN curl -L "https://download.newrelic.com/php_agent/release/${NEWRELIC_NAME}.tar.gz" | tar -C /tmp -zx
RUN export NR_INSTALL_USE_CP_NOT_LN=1
RUN export NR_INSTALL_SILENT=1
RUN /tmp/${NEWRELIC_NAME}/newrelic-install install

RUN echo 'extension = "newrelic.so"' >> /usr/local/etc/php/php.ini
RUN echo 'newrelic.logfile = "/dev/null"' >> /usr/local/etc/php/php.ini
RUN echo 'newrelic.loglevel = "error"' >> /usr/local/etc/php/php.ini

# Remove installation files
RUN rm /usr/local/etc/php/conf.d/newrelic.ini

RUN mkdir -p /usr/local/etc/newrelic
RUN echo "loglevel=error" > /usr/local/etc/newrelic/newrelic.cfg
RUN echo "logfile=/dev/null" >> /usr/local/etc/newrelic/newrelic.cfg

ENTRYPOINT []