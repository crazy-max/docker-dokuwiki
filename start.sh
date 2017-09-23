#!/bin/sh

set -e

mkdir -p /var/www
mkdir -p /var/dokuwiki-storage/data
mkdir -p /var/dokuwiki-storage/lib

for dir in conf data/pages data/meta data/media data/media_attic data/media_meta data/attic lib/plugins lib/tpl; do
  if ! [ -e /var/dokuwiki-storage/${dir} ]; then
    cp -r /var/www/${dir} /var/dokuwiki-storage/${dir}
  fi
  rm -rf /var/www/${dir}
  ln -s /var/dokuwiki-storage/${dir} /var/www/${dir}
done

chown -R nginx. /var/lib/nginx
chown -R nginx. /var/www
chown -R nginx. /var/dokuwiki-storage

su -s /bin/sh nginx -c 'php7 /var/www/bin/indexer.php -c'

exec /usr/bin/supervisord -c /etc/supervisord.conf
