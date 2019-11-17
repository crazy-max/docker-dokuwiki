#!/usr/bin/with-contenv sh

if [ -n "${PGID}" ] && [ "${PGID}" != "$(id -g dokuwiki)" ]; then
  echo "Switching to PGID ${PGID}..."
  sed -i -e "s/^dokuwiki:\([^:]*\):[0-9]*/dokuwiki:\1:${PGID}/" /etc/group
  sed -i -e "s/^dokuwiki:\([^:]*\):\([0-9]*\):[0-9]*/dokuwiki:\1:\2:${PGID}/" /etc/passwd
fi
if [ -n "${PUID}" ] && [ "${PUID}" != "$(id -u dokuwiki)" ]; then
  echo "Switching to PUID ${PUID}..."
  sed -i -e "s/^dokuwiki:\([^:]*\):[0-9]*:\([0-9]*\)/dokuwiki:\1:${PUID}:\2/" /etc/passwd
fi
