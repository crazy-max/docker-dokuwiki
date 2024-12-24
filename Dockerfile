# syntax=docker/dockerfile:1

ARG DOKUWIKI_VERSION="2024-02-06b"
ARG ALPINE_VERSION="3.21"

FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION} AS src
RUN apk --update --no-cache add wget tar
WORKDIR /src/dokuwiki
ARG DOKUWIKI_VERSION
RUN wget -qO- "https://github.com/dokuwiki/dokuwiki/releases/download/release-${DOKUWIKI_VERSION}/dokuwiki-${DOKUWIKI_VERSION}.tgz" | tar xvz --strip 1

FROM crazymax/yasu:latest AS yasu
FROM crazymax/alpine-s6:${ALPINE_VERSION}-2.2.0.3
COPY --from=yasu / /
RUN apk --update --no-cache add \
    curl \
    imagemagick \
    inotify-tools \
    libgd \
    nginx \
    php83 \
    php83-cli \
    php83-ctype \
    php83-curl \
    php83-dom \
    php83-fpm \
    php83-gd \
    php83-iconv \
    php83-json \
    php83-ldap \
    php83-mbstring \
    php83-openssl \
    php83-pdo \
    php83-pdo_sqlite \
    php83-pecl-imagick \
    php83-session \
    php83-simplexml \
    php83-sqlite3 \
    php83-xml \
    php83-zip \
    php83-zlib \
    shadow \
    tar \
    tzdata \
  && rm -rf /tmp/* /var/www/*

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS="2" \
  TZ="UTC" \
  PUID="1500" \
  PGID="1500"

COPY --from=src /src/dokuwiki /var/www
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
