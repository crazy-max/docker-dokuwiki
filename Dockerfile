FROM alpine:3.10

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="CrazyMax" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="dokuwiki" \
  org.label-schema.description="DokuWiki" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/crazy-max/docker-dokuwiki" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/crazy-max/docker-dokuwiki" \
  org.label-schema.vendor="CrazyMax" \
  org.label-schema.schema-version="1.0"

RUN apk --update --no-cache add \
    curl \
    inotify-tools \
    libgd \
    nginx \
    php7 \
    php7-cli \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-imagick \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-openssl \
    php7-session \
    php7-sqlite3 \
    php7-xml \
    php7-zip \
    php7-zlib \
    supervisor \
    tar \
    tzdata \
  && rm -rf /var/cache/apk/* /var/www/* /tmp/*

ENV DOKUWIKI_VERSION="2018-04-22b" \
  DOKUWIKI_MD5="605944ec47cd5f822456c54c124df255"

RUN apk --update --no-cache add -t build-dependencies \
    gnupg \
    wget \
  && cd /tmp \
  && wget -q "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" \
  && echo "$DOKUWIKI_MD5  /tmp/dokuwiki-$DOKUWIKI_VERSION.tgz" | md5sum -c - | grep OK \
  && tar -xzf "dokuwiki-$DOKUWIKI_VERSION.tgz" --strip 1 -C /var/www \
  && apk del build-dependencies \
  && chown -R nginx. /var/lib/nginx /var/log/nginx /var/log/php7 /var/tmp/nginx /var/www \
  && rm -rf  /root/.gnupg /tmp/* /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
COPY assets /

RUN mkdir -p /var/log/supervisord \
  && chmod a+x /entrypoint.sh /usr/local/bin/*

EXPOSE 8000
WORKDIR /var/www
VOLUME [ "/data" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

HEALTHCHECK --interval=10s --timeout=5s \
  CMD curl --fail http://127.0.0.1:12345/ping || exit 1
