# Configuración de OpenDCIM con Docker

## Resumen

Este documento describe el proceso completo de configuración e instalación de OpenDCIM 23.04 utilizando contenedores Docker para su evaluación en un entorno de investigación académica. La implementación incluye una configuración automatizada con MariaDB como base de datos y phpMyAdmin como herramienta de administración.

## Requisitos del Sistema

### Hardware Mínimo
- **CPU**: 2 núcleos
- **RAM**: 4 GB
- **Almacenamiento**: 10 GB de espacio libre
- **Red**: Conexión a internet para descarga de componentes

### Software Requerido
- **Docker Engine**: versión 20.10 o superior
- **Docker Compose**: versión 2.0 o superior
- **Sistema Operativo**: Linux (recomendado), Windows con WSL2, o macOS
- **Navegador Web**: Firefox, Chrome, Safari o Edge

## Arquitectura de la Solución

La implementación consta de tres servicios principales:

1. **dcim-db**: Servidor de base de datos MariaDB 10.11
2. **dcim-web**: Servidor web Apache con PHP 8.2 y OpenDCIM
3. **dcim-phpmyadmin**: Interfaz web para administración de base de datos

### Diagrama de Componentes

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   dcim-web      │    │    dcim-db      │    │ dcim-phpmyadmin │
│ (OpenDCIM)      │────│   (MariaDB)     │────│   (phpMyAdmin)  │
│ Puerto: 8080    │    │ Puerto: 3306    │    │ Puerto: 8081    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  dcim-network   │
                    │  (Bridge)       │
                    └─────────────────┘
```

## Proceso de Configuración

### Paso 1: Preparación del Entorno

1. **Clonar o crear el repositorio del proyecto**:
```bash
mkdir opendcim-evaluation
cd opendcim-evaluation
```

2. **Crear la estructura de directorios**:
```bash
mkdir -p workspace/opendcim-stack/opendcim
```

### Paso 2: Configuración de Variables de Entorno

Crear el archivo `workspace/opendcim-stack/example.env` con las siguientes configuraciones:

```env
# Database Configuration
MYSQL_ROOT_PASSWORD=your_secure_root_password
MYSQL_DATABASE=dcim
MYSQL_USER=dcim
MYSQL_PASSWORD=your_secure_user_password

# OpenDCIM Configuration
OPENDCIM_VERSION=23.04

# Ports Configuration
OPENDCIM_PORT=8080
PHPMYADMIN_PORT=8081

# phpMyAdmin Configuration
PMA_USER=root
PMA_PASSWORD=your_secure_root_password

# Container Names
DB_CONTAINER_NAME=dcim-db
WEB_CONTAINER_NAME=dcim-web
PMA_CONTAINER_NAME=dcim-pma

# Volume Names
DB_VOLUME=dcim-db
HTML_VOLUME=dcim-html
```

**Copiar el archivo de ejemplo para uso local**:
```bash
cp example.env .env
# Editar .env con contraseñas seguras
```

### Paso 3: Configuración del Dockerfile

Crear `workspace/opendcim-stack/opendcim/Dockerfile`:

```dockerfile
FROM php:8.2-apache

ARG OPENDCIM_VERSION=23.04

# Install system dependencies and locales
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libzip-dev libonig-dev libldap2-dev \
    libsnmp-dev snmp graphviz curl unzip ca-certificates \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate common locales for OpenDCIM internationalization
RUN sed -i '/^#.* en_US.UTF-8 /s/^#//' /etc/locale.gen \
    && sed -i '/^#.* es_ES.UTF-8 /s/^#//' /etc/locale.gen \
    && sed -i '/^#.* fr_FR.UTF-8 /s/^#//' /etc/locale.gen \
    && sed -i '/^#.* de_DE.UTF-8 /s/^#//' /etc/locale.gen \
    && sed -i '/^#.* it_IT.UTF-8 /s/^#//' /etc/locale.gen \
    && sed -i '/^#.* pt_BR.UTF-8 /s/^#//' /etc/locale.gen \
    && locale-gen

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

# Copy database configuration
COPY db.inc.php /var/www/html/db.inc.php
RUN chown www-data:www-data /var/www/html/db.inc.php \
    && chmod 644 /var/www/html/db.inc.php

EXPOSE 80

CMD ["apache2-foreground"]
```

### Paso 4: Configuración de la Base de Datos

1. **Extraer el archivo de configuración desde un contenedor temporal**:
```bash
# Ejecutar contenedor temporal para obtener plantilla
docker run --rm php:8.2-apache sh -c "curl -s https://opendcim.org/packages/openDCIM-23.04.tar.gz | tar -xz --strip-components=1 -C /tmp && cat /tmp/db.inc.php-dist" > opendcim/db.inc.php-dist
```

2. **Crear configuración personalizada**:
```bash
cp opendcim/db.inc.php-dist opendcim/db.inc.php
```

3. **Modificar autenticación en `opendcim/db.inc.php`**:
Cambiar la línea:
```php
@define( "AUTHENTICATION", "Apache" );
```
Por:
```php
@define( "AUTHENTICATION", "Native" );
```

### Paso 5: Configuración de Docker Compose

Crear `workspace/opendcim-stack/docker-compose.yaml`:

```yaml
services:
  dcim-db:
    image: mariadb:10.11
    container_name: ${DB_CONTAINER_NAME}
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - ${DB_VOLUME}:/var/lib/mysql
      - /etc/localtime:/etc/localtime:ro
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]
      interval: 10s
      timeout: 5s
      retries: 10
    networks:
      - dcim-network

  dcim-web:
    build:
      context: ./opendcim
      args:
        OPENDCIM_VERSION: ${OPENDCIM_VERSION}
    container_name: ${WEB_CONTAINER_NAME}
    depends_on:
      dcim-db:
        condition: service_healthy
    restart: unless-stopped
    environment:
      OPENDCIM_DB_HOST: dcim-db
      OPENDCIM_DB_NAME: ${MYSQL_DATABASE}
      OPENDCIM_DB_USER: ${MYSQL_USER}
      OPENDCIM_DB_PASS: ${MYSQL_PASSWORD}
      OPENDCIM_DEVMODE: "TRUE"
    ports:
      - "${OPENDCIM_PORT}:80"
    volumes:
      - ${HTML_VOLUME}:/var/www/html
      - /etc/localtime:/etc/localtime:ro
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/install.php", "||", "curl", "-f", "http://localhost/"]
      interval: 30s
      timeout: 10s
      retries: 3
    networks:
      - dcim-network

  dcim-phpmyadmin:
    image: phpmyadmin:5-apache
    container_name: ${PMA_CONTAINER_NAME}
    restart: unless-stopped
    depends_on:
      dcim-db:
        condition: service_healthy
    environment:
      PMA_HOST: dcim-db
      PMA_USER: ${PMA_USER}
      PMA_PASSWORD: ${PMA_PASSWORD}
    ports:
      - "${PHPMYADMIN_PORT}:80"
    volumes:
      - /etc/localtime:/etc/localtime:ro
    networks:
      - dcim-network

volumes:
  dcim-db:
    name: ${DB_VOLUME}
  dcim-html:
    name: ${HTML_VOLUME}

networks:
  dcim-network:
    driver: bridge
```

## Proceso de Instalación

### Paso 1: Construcción e Inicio de Servicios

```bash
cd workspace/opendcim-stack

# Construir y ejecutar los contenedores
docker compose up --build

# Para ejecutar en segundo plano (opcional)
docker compose up --build -d
```

### Paso 2: Verificación de Servicios

1. **Verificar estado de contenedores**:
```bash
docker compose ps
```

2. **Revisar logs en caso de errores**:
```bash
docker compose logs dcim-web
docker compose logs dcim-db
```

### Paso 3: Acceso a las Interfaces

- **OpenDCIM**: http://localhost:8080
- **phpMyAdmin**: http://localhost:8081

## Solución de Problemas

### Problemas Comunes y Soluciones

#### 1. Error de Conexión a Base de Datos
**Síntoma**: "Error! Connection failed: SQLSTATE[HY000] [2002]"

**Solución**:
```bash
# Verificar que la base de datos esté ejecutándose
docker compose exec dcim-db mysql -u root -p

# Reiniciar servicios manteniendo datos
docker compose restart
```

#### 2. Problemas de Permisos de Archivos
**Síntoma**: Errores de escritura en directorios

**Solución**:
```bash
# Acceder al contenedor y corregir permisos
docker compose exec dcim-web bash
chown -R www-data:www-data /var/www/html/pictures /var/www/html/drawings /var/www/html/templates
chmod -R 775 /var/www/html/pictures /var/www/html/drawings /var/www/html/templates
```

#### 3. Problemas de Localización
**Síntoma**: Warning sobre locales en preflight check

**Solución**: El Dockerfile incluye la generación automática de locales comunes. Si persiste el problema:
```bash
docker compose exec dcim-web locale -a
# Verificar que aparezcan los locales UTF-8
```

#### 4. Reinicio Completo
Para comenzar desde cero:
```bash
# Detener y eliminar todo (incluyendo datos)
docker compose down -v

# Reconstruir desde cero
docker compose up --build
```

## Verificación de la Instalación

### Checklist de Verificación

- [ ] Contenedores ejecutándose correctamente
- [ ] Acceso a http://localhost:8080 sin errores
- [ ] Dashboard de OpenDCIM visible con datos en cero
- [ ] Acceso a phpMyAdmin en http://localhost:8081
- [ ] Base de datos 'dcim' creada y accesible
- [ ] No hay errores en logs de contenedores

### Comandos de Verificación

```bash
# Estado de servicios
docker compose ps

# Verificar conectividad de base de datos
docker compose exec dcim-web php -r "
include '/var/www/html/db.inc.php';
echo 'Database connection: ' . (isset(\$dbh) ? 'SUCCESS' : 'FAILED') . PHP_EOL;
"

# Verificar locales
docker compose exec dcim-web locale -a | grep -i utf

# Verificar permisos
docker compose exec dcim-web ls -la /var/www/html/ | grep -E "(pictures|drawings|templates)"
```

## Mantenimiento y Operación

### Comandos Útiles

```bash
# Ver logs en tiempo real
docker compose logs -f dcim-web

# Backup de base de datos
docker compose exec dcim-db mysqldump -u root -p dcim > backup_dcim.sql

# Restaurar backup
docker compose exec -T dcim-db mysql -u root -p dcim < backup_dcim.sql

# Acceso directo a contenedores
docker compose exec dcim-web bash
docker compose exec dcim-db mysql -u dcim -p

# Actualizar OpenDCIM (cambiar versión en .env y reconstruir)
docker compose down
docker compose up --build
```

### Consideraciones de Seguridad

1. **Contraseñas**: Usar contraseñas seguras en el archivo `.env`
2. **Red**: Los contenedores están aislados en una red privada
3. **Acceso**: Limitar acceso a puertos 8080 y 8081 según sea necesario
4. **Backups**: Implementar respaldos regulares de datos
5. **Actualizaciones**: Mantener imágenes Docker actualizadas

## Conclusiones

Esta configuración proporciona un entorno completamente funcional de OpenDCIM 23.04 para evaluación académica, con las siguientes ventajas:

- **Reproducibilidad**: Configuración completamente automatizada
- **Aislamiento**: Entorno contenarizado sin afectar el sistema host
- **Facilidad de uso**: Inicio con un solo comando
- **Completitud**: Incluye todas las herramientas necesarias
- **Mantenibilidad**: Configuración versionada y documentada

La implementación permite realizar una evaluación completa de las capacidades de OpenDCIM como solución DCIM para su comparación con otras alternativas del mercado.

## Referencias

- [OpenDCIM Official Documentation](http://opendcim.org/)
- [OpenDCIM Wiki](http://wiki.opendcim.org/)
- [Docker Documentation](https://docs.docker.com/)
- [MariaDB Documentation](https://mariadb.org/documentation/)
- [PHP Official Documentation](https://www.php.net/docs.php)