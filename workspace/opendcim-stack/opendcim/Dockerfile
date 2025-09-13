FROM php:8.2-apache

ARG OPENDCIM_VERSION=23.04

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libzip-dev libonig-dev libldap2-dev \
    libsnmp-dev snmp graphviz curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by OpenDCIM
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" gd mysqli pdo_mysql gettext ldap zip snmp

# Configure PHP settings
RUN { \
    echo "memory_limit=512M"; \
    echo "upload_max_filesize=50M"; \
    echo "post_max_size=50M"; \
    echo "max_execution_time=300"; \
    echo "max_input_time=300"; \
    } > /usr/local/etc/php/conf.d/z-opendcim.ini

# Enable Apache modules
RUN a2enmod rewrite

# Download and extract OpenDCIM
ADD https://opendcim.org/packages/openDCIM-${OPENDCIM_VERSION}.tar.gz /tmp/opendcim.tar.gz

RUN set -eux; \
    tar -xzf /tmp/opendcim.tar.gz -C /var/www/html --strip-components=1; \
    rm /tmp/opendcim.tar.gz; \
    chown -R www-data:www-data /var/www/html; \
    chmod -R 755 /var/www/html

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/pictures /var/www/html/drawings /var/www/html/templates \
    && chown -R www-data:www-data /var/www/html/pictures /var/www/html/drawings /var/www/html/templates \
    && chmod -R 775 /var/www/html/pictures /var/www/html/drawings /var/www/html/templates

EXPOSE 80

CMD ["apache2-foreground"]