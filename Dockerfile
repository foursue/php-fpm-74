FROM php:7.4-fpm-alpine

# php ext
RUN apk update && \
    apk --no-cache upgrade && \
    apk --no-cache add libmcrypt-dev mysql-client git openssl-dev

# php ext redis
RUN docker-php-source extract && \
    git clone -b 5.2.2 --depth 1 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-install redis

RUN docker-php-ext-install pdo_mysql json mbstring

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer config -g repos.packagist composer https://packagist.jp
RUN composer global require hirak/prestissimo