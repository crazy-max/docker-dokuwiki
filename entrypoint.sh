#!/bin/sh

TZ=${TZ:-"UTC"}
MEMORY_LIMIT=${MEMORY_LIMIT:-"256M"}
UPLOAD_MAX_SIZE=${UPLOAD_MAX_SIZE:-"16M"}
OPCACHE_MEM_SIZE=${OPCACHE_MEM_SIZE:-"128"}

# Timezone
echo "Setting timezone to ${TZ}..."
ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime
echo ${TZ} > /etc/timezone

# PHP
echo "Setting PHP-FPM configuration..."
sed -e "s/@MEMORY_LIMIT@/$MEMORY_LIMIT/g" \
  -e "s/@UPLOAD_MAX_SIZE@/$UPLOAD_MAX_SIZE/g" \
  /tpls/etc/php7/php-fpm.d/www.conf > /etc/php7/php-fpm.d/www.conf

# OpCache
echo "Setting OpCache configuration..."
sed -e "s/@OPCACHE_MEM_SIZE@/$OPCACHE_MEM_SIZE/g" \
  /tpls/etc/php7/conf.d/opcache.ini > /etc/php7/conf.d/opcache.ini

# Nginx
echo "Setting Nginx configuration..."
sed -e "s/@UPLOAD_MAX_SIZE@/$UPLOAD_MAX_SIZE/g" \
  /tpls/etc/nginx/nginx.conf > /etc/nginx/nginx.conf

# Fix perms
echo "Fixing permissions..."
chown -R nginx. /var/lib/nginx \
  /var/tmp/nginx \
  /var/www/conf \
  /var/www/data/attic \
  /var/www/data/media \
  /var/www/data/media_attic \
  /var/www/data/media_meta \
  /var/www/data/meta \
  /var/www/data/pages \
  /var/www/lib/plugins \
  /var/www/lib/tpl

# Launch DokuWiki indexer
echo "Launching DokuWiki indexer..."
su -s /bin/sh nginx -c 'php7 /var/www/bin/indexer.php -c'

exec "$@"
