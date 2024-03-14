# Utiliser une image PHP Apache
FROM php:8.1-apache

# Copier les fichiers de l'application Laravel dans le conteneur
COPY . /var/www/html

# Installer les dépendances de l'application Laravel
RUN apt-get update && \
    apt-get install -y libzip-dev zip && \
    docker-php-ext-configure zip && \
    docker-php-ext-install zip pdo pdo_mysql

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installer les dépendances de l'application
RUN composer install

# Générer la clé d'application Laravel
RUN php artisan key:generate

# Définir le port d'écoute du serveur web Apache
EXPOSE 80

# Point d'entrée pour le conteneur
CMD ["apache2-foreground"]
