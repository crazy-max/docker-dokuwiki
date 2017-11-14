#!/bin/sh

# Timezone
ln -snf /usr/share/zoneinfo/${TZ:-"UTC"} /etc/localtime
echo ${TZ:-"UTC"} > /etc/timezone

# Perms
chown -R nginx. /var/lib/nginx
chown -R nginx. /var/www

# Launch indexer
su -s /bin/sh nginx -c 'php7 /var/www/bin/indexer.php -c'

exec "$@"
