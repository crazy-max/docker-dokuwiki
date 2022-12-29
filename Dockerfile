ARG DOKUWIKI_VERSION="2022-07-31a"
ARG DOKUWIKI_MD5="4459ea99e3a4ce2b767482f505724dcc"

FROM crazymax/yasu:latest AS yasu
FROM crazymax/alpine-s6:3.17-2.2.0.3

COPY --from=yasu / /
RUN apk --update --no-cache add \
    curl \
    imagemagick \
    inotify-tools \
    libgd \
    nginx \
    php81 \
    php81-cli \
    php81-ctype \
    php81-curl \
    php81-fpm \
    php81-gd \
    php81-json \
    php81-ldap \
    php81-mbstring \
    php81-openssl \
    php81-pdo \
    php81-pdo_sqlite \
    php81-pecl-imagick \
    php81-session \
    php81-simplexml \
    php81-sqlite3 \
    php81-xml \
    php81-zip \
    php81-zlib \
    shadow \
    tar \
    tzdata \
  && rm -rf /tmp/* /var/www/*

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS="2" \
  TZ="UTC" \
  PUID="1500" \
  PGID="1500"

ARG DOKUWIKI_VERSION
ARG DOKUWIKI_MD5
RUN apk --update --no-cache add -t build-dependencies \
    gnupg \
    wget \
  && cd /tmp \
  && wget -q "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" \
  && echo "$DOKUWIKI_MD5  /tmp/dokuwiki-$DOKUWIKI_VERSION.tgz" | md5sum -c - | grep OK \
  && tar -xzf "dokuwiki-$DOKUWIKI_VERSION.tgz" --strip 1 -C /var/www \
  && apk del build-dependencies \
  && rm -rf /root/.gnupg /tmp/*

COPY rootfs /

RUN chmod a+x /usr/local/bin/* \
  && addgroup -g ${PGID} dokuwiki \
  && adduser -D -H -u ${PUID} -G dokuwiki -s /bin/sh dokuwiki

EXPOSE 8000
WORKDIR /var/www
VOLUME [ "/data" ]

ENTRYPOINT [ "/init" ]

HEALTHCHECK --interval=10s --timeout=5s --start-period=20s \
  CMD curl --fail http://127.0.0.1:12345/ping || exit 1
