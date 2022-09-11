#!/usr/bin/with-contenv sh
# shellcheck shell=sh

echo "Fixing perms..."
mkdir -p /data \
  /var/run/nginx \
  /var/run/php-fpm
chown dokuwiki. \
  /data
chown -R dokuwiki. \
  /tpls \
  /var/lib/nginx \
  /var/log/nginx \
  /var/log/php8 \
  /var/run/nginx \
  /var/run/php-fpm \
  /var/www/bin \
  /var/www/conf \
  /var/www/data \
  /var/www/lib/plugins \
  /var/www/lib/tpl
