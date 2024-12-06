FROM php:8.3-fpm-alpine

WORKDIR /var/www
RUN chmod -R 777 /var/www
RUN set -ex \
 && apk update \
 && apk upgrade \
 && apk --no-cache add $PHPIZE_DEPS openssl-dev libgcrypt-dev libxml2-dev zip libzip-dev libstdc++ bash \
 && docker-php-ext-configure zip \
 && docker-php-ext-install zip bcmath xml

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

CMD ["php-fpm"]
