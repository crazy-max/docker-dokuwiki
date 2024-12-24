#!/usr/bin/with-contenv sh
# shellcheck shell=sh

echo "Fixing perms..."
mkdir -p /data \
  /var/run/nginx \
  /var/run/php-fpm
chown dokuwiki:dokuwiki \
  /data
chown -R dokuwiki:dokuwiki \
  /tpls \
  /var/lib/nginx \
  /var/log/nginx \
  /var/log/php82 \
  /var/run/nginx \
  /var/run/php-fpm \
  /var/www/bin \
  /var/www/conf \
  /var/www/data \
  /var/www/lib/plugins \
  /var/www/lib/tpl
