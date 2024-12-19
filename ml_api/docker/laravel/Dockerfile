FROM composer AS builder
WORKDIR /app
COPY composer.json composer.json
RUN composer install  \
--ignore-platform-reqs \
--no-interaction \
--no-plugins \
--no-scripts \
--prefer-dist

FROM php:8.3-apache
WORKDIR /var/www

RUN set -ex \
 && apt-get update \
 && apt-get install -y libgcrypt-dev libxml2-dev zip libzip-dev \
 && docker-php-ext-configure zip \
 && docker-php-ext-install zip bcmath xml

COPY . .
COPY --from=builder /app/vendor vendor
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

COPY docker/laravel/apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

CMD ["apache2-foreground"]
