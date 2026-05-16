#!/usr/bin/env bash
# exit on error
set -o errexit

# Install composer dependencies
composer install --no-dev --optimize-autoloader

# Install NPM dependencies and build assets
npm install
npm run build

# Clear caches
php artisan optimize:clear
