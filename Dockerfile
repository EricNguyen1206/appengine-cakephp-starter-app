# Use the official PHP image with Apache
FROM php:7.4-apache

# Install extension
RUN apt-get update && apt-get install -y libicu-dev \
    zip \
    git \
    && docker-php-ext-install intl pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy the application files
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer config --no-plugins allow-plugins.cakephp/plugin-installer true \
    && composer install

# Install PHP dependencies
RUN composer install
