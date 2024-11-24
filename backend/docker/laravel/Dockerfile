FROM composer AS vendor

COPY composer.json .
COPY composer.lock .
RUN composer install  \
--ignore-platform-reqs \
--no-interaction \
--no-plugins \
--no-scripts \
--prefer-dist

FROM php:8.3-fpm-alpine

WORKDIR /var/www
RUN chmod 777 /var/www
RUN set -ex \
 && apk update \
 && apk upgrade \
 && apk --no-cache add $PHPIZE_DEPS openssl-dev libgcrypt-dev libxml2-dev zip libzip-dev libstdc++ bash \
 && docker-php-ext-configure zip \
 && docker-php-ext-install zip bcmath xml

RUN pecl install mongodb redis \
&& docker-php-ext-enable mongodb \
&& docker-php-ext-enable redis

RUN echo "* * * * * /usr/bin/php /var/www/artisan schedule:run" >> /etc/crontab
RUN touch /var/log/cron.log

COPY --from=vendor . vendor/
CMD bash -c "crond && php-fpm"
