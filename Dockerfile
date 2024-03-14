# Utilisez l'image de PHP avec FPM (FastCGI Process Manager)
FROM php:8.1.0-fpm

# Installez les extensions PHP nécessaires
RUN docker-php-ext-install pdo pdo_mysql

# Installation du client MySQL
RUN apt-get update && apt-get install -y default-mysql-client

# Créez un utilisateur non root pour l'exécution du conteneur
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Copiez les fichiers de l'application Laravel dans le conteneur avec les permissions appropriées
COPY --chown=appuser:appgroup laravel-app-01 /var/www/html

# Définir le répertoire de travail
WORKDIR /var/www/html

# Exposez le port PHP-FPM (9000 par défaut)
EXPOSE 9000

# Changez l'utilisateur pour l'exécution du conteneur
USER appuser

# Commande pour démarrer PHP-FPM
CMD ["php-fpm"]