FROM alpine:3.6
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
  php7 php7-openssl php7-zlib php7-mbstring php7-fpm php7-gd php7-session php7-xml nginx \
  supervisor curl tar \
  && rm -rf /var/cache/apk/*

ENV DOKUWIKI_VERSION="2017-02-19e" \
  MD5_CHECKSUM="09bf175f28d6e7ff2c2e3be60be8c65f"

RUN mkdir -p /run/nginx \
  && mkdir -p /var/www \
  && cd /var/www \
  && curl -O -L "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" \
  && tar -xzf "dokuwiki-$DOKUWIKI_VERSION.tgz" --strip 1 \
  && rm "dokuwiki-$DOKUWIKI_VERSION.tgz"

ADD entrypoint.sh /entrypoint.sh
ADD assets /

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php7/php-fpm.ini \
  && sed -i -e "s|;daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf \
  && sed -i -e "s|listen\s*=\s*127\.0\.0\.1:9000|listen = /var/run/php-fpm7.sock|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i -e "s|;listen\.owner\s*=\s*\w*|listen.owner = nginx|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i -e "s|;listen\.group\s*=\s*\w*|listen.group = nginx|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i -e "s|user\s*=\s*\w*|user = nginx|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i -e "s|;listen\.mode\s*=\s*|listen.mode = |g" /etc/php7/php-fpm.d/www.conf \
  && chmod a+x /entrypoint.sh

EXPOSE 80
VOLUME [ "/var/www/conf", "/var/www/data/attic", "/var/www/data/media", "/var/www/data/media_attic", "/var/www/data/media_meta", "/var/www/data/meta", "/var/www/data/pages", "/var/www/lib/plugins", "/var/www/lib/tpl" ]

WORKDIR "/var/www"
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
