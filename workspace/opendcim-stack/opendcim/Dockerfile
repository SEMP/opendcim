# multi-arch (amd64/arm64) compatible
FROM php:8.2-apache

ARG OPENDCIM_VERSION=23.04

# Dependencias del sistema (gd/snmp/ldap/curl/zip/graphviz son útiles)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libzip-dev libonig-dev libldap2-dev \
    libsnmp-dev snmp graphviz curl unzip ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Extensiones PHP requeridas/comunes para openDCIM
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd mysqli pdo_mysql gettext ldap zip snmp

# Opcional: algunos límites PHP por variables de entorno
RUN { \
    echo "memory_limit=${PHP_MEMORY_LIMIT:-512M}"; \
    echo "upload_max_filesize=${PHP_UPLOAD_MAX_FILESIZE:-50M}"; \
    echo "post_max_size=${PHP_POST_MAX_SIZE:-50M}"; \
  } > /usr/local/etc/php/conf.d/z-limits.ini

# Descargar y desplegar openDCIM desde el sitio oficial
# (23.04 figura como última estable en la página de descargas)
ADD https://opendcim.org/packages/openDCIM-${OPENDCIM_VERSION}.tar.gz /tmp/opendcim.tar.gz

RUN set -eux; \
    tar -xzf /tmp/opendcim.tar.gz -C /var/www/html --strip-components=1; \
    rm /tmp/opendcim.tar.gz; \
    chown -R www-data:www-data /var/www/html; \
    a2enmod rewrite

# DocumentRoot ya es /var/www/html; aseguramos .htaccess funcionando
# para que openDCIM pueda servir correctamente recursos.

