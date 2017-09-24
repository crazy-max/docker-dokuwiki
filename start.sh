#!/bin/sh

set -e

chown -R nginx. /var/lib/nginx
chown -R nginx. /var/www

su -s /bin/sh nginx -c 'php7 /var/www/bin/indexer.php -c'

exec /usr/bin/supervisord -c /etc/supervisord.conf
