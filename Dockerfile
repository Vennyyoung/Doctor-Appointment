# Use a base image with Apache and PHP
FROM php:7.4-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli

# Enable Apache modules if needed
RUN a2enmod rewrite

# Copy app files into the Apache web root
COPY . /var/www/html/

# Set permissions and ownership
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Configure Apache to allow access
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/allow-access.conf && \
    a2enconf allow-access

# Expose Apache port
EXPOSE 80

