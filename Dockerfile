FROM alpine:3.7
MAINTAINER CrazyMax <crazy-max@users.noreply.github.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="dokuwiki" \
  org.label-schema.description="DokuWiki based on Alpine Linux and Nginx" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/crazy-max/docker-dokuwiki" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/crazy-max/docker-dokuwiki" \
  org.label-schema.vendor="CrazyMax" \
  org.label-schema.schema-version="1.0"

RUN apk --update --no-cache add \
    libgd nginx supervisor tar tzdata \
    php7 php7-cli php7-ctype php7-curl php7-fpm php7-gd php7-imagick php7-json php7-mbstring php7-openssl \
    php7-session php7-xml php7-zip php7-zlib \
  && rm -rf /var/cache/apk/* /var/www/* /tmp/*

ENV DOKUWIKI_VERSION="2018-04-22" \
  DOKUWIKI_MD5="cec26670452f0122807d4f812432df4d"

RUN apk --update --no-cache add -t build-dependencies \
    gnupg wget \
  && cd /tmp \
  && wget -q "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" \
  && echo "$DOKUWIKI_MD5  /tmp/dokuwiki-$DOKUWIKI_VERSION.tgz" | md5sum -c - | grep OK \
  && tar -xzf "dokuwiki-$DOKUWIKI_VERSION.tgz" --strip 1 -C /var/www \
  && apk del build-dependencies \
  && rm -rf  /root/.gnupg /tmp/* /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh
ADD assets /

RUN mkdir -p /var/log/supervisord \
  && chmod a+x /entrypoint.sh \
  && chown -R nginx. /var/lib/nginx /var/log/nginx /var/log/php7 /var/tmp/nginx /var/www

EXPOSE 80
WORKDIR "/var/www"
VOLUME [ "/var/www/conf", \
  "/var/www/data/attic", \
  "/var/www/data/media", \
  "/var/www/data/media_attic", \
  "/var/www/data/media_meta", \
  "/var/www/data/meta", \
  "/var/www/data/pages", \
  "/var/www/lib/plugins", \
  "/var/www/lib/tpl" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
