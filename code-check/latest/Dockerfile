FROM php:8.1-alpine

RUN apk add bash
RUN curl -fsSL -o /common.sh https://bitbucket.org/bitbucketpipelines/bitbucket-pipes-toolkit-bash/raw/0.6.0/common.sh

RUN apk add nodejs npm
RUN apk add git

RUN curl -L https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v3.14.3/php-cs-fixer.phar -o php-cs-fixer \
    && chmod +x php-cs-fixer \
    && mv php-cs-fixer /usr/local/bin/php-cs-fixer

RUN git config --global --add safe.directory /opt/atlassian/pipelines/agent/build

RUN npm install -g eslint eslint-plugin-vue vue-eslint-parser
# https://eslint.vuejs.org/rules/
# https://eslint.org/docs/latest/rules/camelcase

COPY ci /

COPY ./ci /usr/local/bin/
RUN chmod +x /usr/local/bin/check_coding_back.sh \
    && chmod +x /usr/local/bin/check_coding_front.sh \
    && chmod +x /usr/local/bin/pipe.sh

WORKDIR /home 
COPY ./config/ .

ENTRYPOINT [ "/pipe.sh" ]