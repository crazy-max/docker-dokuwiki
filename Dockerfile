# syntax=docker/dockerfile:1

ARG DOKUWIKI_VERSION="2024-02-06b"
ARG ALPINE_VERSION="3.19"

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
    php82 \
    php82-cli \
    php82-ctype \
    php82-curl \
    php82-dom \
    php82-fpm \
    php82-gd \
    php82-iconv \
    php82-json \
    php82-ldap \
    php82-mbstring \
    php82-openssl \
    php82-pdo \
    php82-pdo_sqlite \
    php82-pecl-imagick \
    php82-session \
    php82-simplexml \
    php82-sqlite3 \
    php82-xml \
    php82-zip \
    php82-zlib \
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
