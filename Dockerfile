ARG DOKUWIKI_VERSION="2020-07-29"
ARG DOKUWIKI_MD5="8867b6a5d71ecb5203402fe5e8fa18c9"

FROM --platform=${TARGETPLATFORM:-linux/amd64} crazymax/gosu:latest AS gosu
FROM --platform=${TARGETPLATFORM:-linux/amd64} crazymax/alpine-s6:3.12-2.1.0.2
LABEL maintainer="CrazyMax"

COPY --from=gosu / /
RUN apk --update --no-cache add \
    curl \
    imagemagick \
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
    php7-pdo \
    php7-pdo_sqlite \
    php7-session \
    php7-simplexml \
    php7-sqlite3 \
    php7-xml \
    php7-zip \
    php7-zlib \
    shadow \
    tar \
    tzdata \
  && rm -rf /tmp/* /var/cache/apk/* /var/www/*

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
  && rm -rf /root/.gnupg /tmp/* /var/cache/apk/*

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
