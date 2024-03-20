FROM php:8.2.0-fpm

# Installation de Composer
RUN apt-get update && apt-get install -y wget && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update && apt-get install -y default-mysql-client

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

COPY --chown=appuser:appgroup ./laravel-app-01 /var/www/html/laravel-app-01

RUN chown -R appuser:appgroup /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html/laravel-app-01

# Installation des dépendances Composer
RUN composer install

EXPOSE 9000

USER appuser

CMD ["php-fpm"]

