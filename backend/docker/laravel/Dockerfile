FROM php:8.3-fpm-alpine

WORKDIR /var/www
RUN chmod 777 /var/www
RUN set -ex \
 && apk update \
 && apk upgrade \
 && apk --no-cache add $PHPIZE_DEPS openssl-dev libgcrypt-dev libxml2-dev zip libzip-dev libstdc++ bash \
 && docker-php-ext-configure zip \
 && docker-php-ext-install zip bcmath xml

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN pecl install mongodb redis \
&& docker-php-ext-enable mongodb \
&& docker-php-ext-enable redis

CMD ["php-fpm"]
