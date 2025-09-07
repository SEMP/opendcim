#!/bin/bash

# OpenDCIM Initialization Script
# Sets up the database configuration file with proper permissions

CONFIG_DIR="/var/www/html"
DB_CONFIG="$CONFIG_DIR/db.inc.php"
DB_TEMPLATE="$CONFIG_DIR/db.inc.php-dist"

echo "Initializing OpenDCIM configuration..."

# Copy template to actual config if it doesn't exist
if [ ! -f "$DB_CONFIG" ]; then
    echo "Setting up database configuration from template..."
    
    # Copy the template
    cp "$DB_TEMPLATE" "$DB_CONFIG"
    
    # Set proper permissions
    chown www-data:www-data "$DB_CONFIG"
    chmod 640 "$DB_CONFIG"
    
    echo "Database configuration created successfully."
    echo "Using environment variables:"
    echo "  DCIM_DB_HOST: ${DCIM_DB_HOST}"
    echo "  DCIM_DB_NAME: ${DCIM_DB_NAME}"
    echo "  DCIM_DB_USER: ${DCIM_DB_USER}"
else
    echo "Database configuration already exists."
fi

# Update OpenDCIM environment variables to match our naming convention
export OPENDCIM_DB_HOST="${DCIM_DB_HOST}"
export OPENDCIM_DB_NAME="${DCIM_DB_NAME}"
export OPENDCIM_DB_USER="${DCIM_DB_USER}"
export OPENDCIM_DB_PASS="${DCIM_DB_PASS}"

echo "Configuration initialization completed."