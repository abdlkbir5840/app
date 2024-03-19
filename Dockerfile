FROM php:8.2.0-fpm

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update && apt-get install -y default-mysql-client

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

#COPY --chown=appuser:appgroup laravel-app-01 /var/www/html
COPY --chown=appuser:appgroup ./laravel-app-01 /var/www/html

WORKDIR /var/www/html

EXPOSE 9000

USER appuser

CMD ["php-fpm"]
