#!/bin/bash

set -euo pipefail

NGINX_ROOT=${NGINX_ROOT:=/var/www}

# Display PHP error's or not
sed -i -e "s/error_reporting =.*=/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/g" /etc/php/5.6/fpm/php.ini
sed -i -e "s/display_errors =.*/display_errors = Off/g" /etc/php/5.6/fpm/php.ini

# Tweak nginx to match the workers to cpu's
procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

# Set the root in the conf
sed -i -e "s#%%NGINX_ROOT%%#$NGINX_ROOT#" /etc/nginx/sites-available/default.conf

# Again set the right permissions (needed when mounting from a volume)
set +e 
chown -Rf www-data.www-data $NGINX_ROOT
set -e

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
