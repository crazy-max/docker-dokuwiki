#!/usr/bin/with-contenv sh

runas_user() {
  yasu dokuwiki:dokuwiki "$@"
}

TZ=${TZ:-UTC}
MEMORY_LIMIT=${MEMORY_LIMIT:-256M}
UPLOAD_MAX_SIZE=${UPLOAD_MAX_SIZE:-16M}
CLEAR_ENV=${CLEAR_ENV:-yes}
OPCACHE_MEM_SIZE=${OPCACHE_MEM_SIZE:-128}
LISTEN_IPV6=${LISTEN_IPV6:-true}
REAL_IP_FROM=${REAL_IP_FROM:-0.0.0.0/32}
REAL_IP_HEADER=${REAL_IP_HEADER:-X-Forwarded-For}
LOG_IP_VAR=${LOG_IP_VAR:-remote_addr}
DOKUWIKI_RUN_INDEXER=${DOKUWIKI_RUN_INDEXER:-true}

# Timezone
echo "Setting timezone to ${TZ}..."
ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime
echo ${TZ} > /etc/timezone

# PHP
echo "Setting PHP-FPM configuration..."
sed -e "s/@MEMORY_LIMIT@/$MEMORY_LIMIT/g" \
  -e "s/@UPLOAD_MAX_SIZE@/$UPLOAD_MAX_SIZE/g" \
  -e "s/@CLEAR_ENV@/$CLEAR_ENV/g" \
  /tpls/etc/php7/php-fpm.d/www.conf > /etc/php7/php-fpm.d/www.conf

echo "Setting PHP INI configuration..."
sed -i "s|memory_limit.*|memory_limit = ${MEMORY_LIMIT}|g" /etc/php7/php.ini
sed -i "s|;date\.timezone.*|date\.timezone = ${TZ}|g" /etc/php7/php.ini
sed -i "s|auto_prepend_file.*|auto_prepend_file = /var/www/inc/preload.php|g" /etc/php7/php.ini

# OpCache
echo "Setting OpCache configuration..."
sed -e "s/@OPCACHE_MEM_SIZE@/$OPCACHE_MEM_SIZE/g" \
  /tpls/etc/php7/conf.d/opcache.ini > /etc/php7/conf.d/opcache.ini

# Nginx
echo "Setting Nginx configuration..."
sed -e "s/@UPLOAD_MAX_SIZE@/$UPLOAD_MAX_SIZE/g" \
  -e "s#@REAL_IP_FROM@#$REAL_IP_FROM#g" \
  -e "s#@REAL_IP_HEADER@#$REAL_IP_HEADER#g" \
  -e "s#@LOG_IP_VAR@#$LOG_IP_VAR#g" \
  /tpls/etc/nginx/nginx.conf > /etc/nginx/nginx.conf

if [ "$LISTEN_IPV6" != "true" ]; then
  sed -e '/listen \[::\]:/d' -i /etc/nginx/nginx.conf
fi

# DokuWiki
echo "Initializing DokuWiki files / folders..."
runas_user mkdir -p /data/plugins /data/tpl

echo "Adding preload.php..."
cp -f /tpls/preload.php /var/www/inc/

echo "Copying global config..."
runas_user cp -Rf /var/www/conf /data/

firstInstall=0
if [ ! -f /data/conf/local.protected.php ]; then
  firstInstall=1
  echo "First install detected..."
  sed -i "1s/.*/<?php define('DOKU_CONF', '\/data\/conf\/'); define('DOKU_LOCAL', '\/data\/conf\/');/" /var/www/install.php
fi

if [ ! -d /data/data ]; then
  echo "Creating initial data folder..."
  runas_user cp -Rf /var/www/data /data/
fi

echo "Bootstrapping configuration..."
runas_user cat > /data/conf/local.protected.php <<EOL
<?php

\$conf['savedir'] = '/data/data';
EOL
chown dokuwiki:dokuwiki /data/conf/local.protected.php

echo -n "Saving bundled plugins list..."
bundledPlugins=$(ls -d /var/www/lib/plugins/*/ | cut -f6 -d'/')
for bundledPlugin in ${bundledPlugins}; do
  echo "${bundledPlugin}" >> /tmp/bundledPlugins.txt
done
echo " $(wc -l < /tmp/bundledPlugins.txt) found"

echo -n "Saving bundled templates list..."
bundledTpls=$(ls -d /var/www/lib/tpl/*/ | cut -f6 -d'/')
for bundledTpl in ${bundledTpls}; do
  echo "${bundledTpl}" >> /tmp/bundledTpls.txt
done
echo " $(wc -l < /tmp/bundledTpls.txt) found"

echo "Checking user plugins in /data/plugins..."
userPlugins=$(ls -l /data/plugins | egrep '^d' | awk '{print $9}')
for userPlugin in ${userPlugins}; do
  if [ -d "/var/www/lib/plugins/${userPlugin}" ]; then
    echo "WARNING: Plugin ${userPlugin} will not be used (already bundled in DokuWiki)"
    continue
  fi
  ln -sf "/data/plugins/${userPlugin}" "/var/www/lib/plugins/${userPlugin}"
done

echo "Checking user templates in /data/tpl..."
userTpls=$(ls -l /data/tpl | egrep '^d' | awk '{print $9}')
for userTpl in ${userTpls}; do
  if [ -d "/var/www/lib/tpl/${userTpl}" ]; then
    echo "WARNING: Template ${userTpl} will not be used (already bundled in DokuWiki)"
    continue
  fi
  ln -sf "/data/tpl/${userTpl}" "/var/www/lib/tpl/${userTpl}"
done

# First install ?
if [ ${firstInstall} -eq 1 ]; then
  echo ">>"
  echo ">> Open your browser to install DokuWiki through the wizard (/install.php)"
  echo ">>"
elif [ "$DOKUWIKI_RUN_INDEXER" = "true" ]; then
  echo "Launching DokuWiki indexer..."
  runas_user php7 /var/www/bin/indexer.php -c
fi
