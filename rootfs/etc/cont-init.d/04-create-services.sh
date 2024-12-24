#!/usr/bin/with-contenv sh
# shellcheck shell=sh

mkdir -p /etc/services.d/nginx
cat > /etc/services.d/nginx/run <<EOL
#!/usr/bin/execlineb -P
with-contenv
s6-setuidgid ${PUID}:${PGID}
nginx -g "daemon off;"
EOL
chmod +x /etc/services.d/nginx/run

mkdir -p /etc/services.d/php-fpm
cat > /etc/services.d/php-fpm/run <<EOL
#!/usr/bin/execlineb -P
with-contenv
s6-setuidgid ${PUID}:${PGID}
php-fpm83 -F
EOL
chmod +x /etc/services.d/php-fpm/run

mkdir -p /etc/services.d/watch-folders
cat > /etc/services.d/watch-folders/run <<EOL
#!/usr/bin/execlineb -P
with-contenv
s6-setuidgid ${PUID}:${PGID}
watch_folders
EOL
chmod +x /etc/services.d/watch-folders/run
