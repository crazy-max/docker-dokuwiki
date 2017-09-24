[![Docker DokuWiki](https://raw.githubusercontent.com/crazy-max/docker-dokuwiki/master/res/dokuwiki_docker.png)](https://github.com/crazy-max/docker-dokuwiki)

[![Version](https://images.microbadger.com/badges/version/crazymax/dokuwiki.svg?style=flat-square)](https://microbadger.com/images/crazymax/dokuwiki) [![Docker Build Status](https://img.shields.io/docker/build/crazymax/dokuwiki.svg?style=flat-square)](https://hub.docker.com/r/crazymax/dokuwiki/) [![Docker Stars](https://img.shields.io/docker/stars/crazymax/dokuwiki.svg?style=flat-square)](https://hub.docker.com/r/crazymax/dokuwiki/) [![Docker Pulls](https://img.shields.io/docker/pulls/crazymax/dokuwiki.svg?style=flat-square)](https://hub.docker.com/r/crazymax/dokuwiki/) [![Docker Build](https://img.shields.io/docker/automated/crazymax/dokuwiki.svg?style=flat-square)](https://hub.docker.com/r/crazymax/dokuwiki/) [![DokuWiki Version](https://img.shields.io/badge/dokuwiki-2017--02--19e-yellow.svg?style=flat-square)](https://www.dokuwiki.org/releasenames) [![Donate Paypal](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USUQWRGP52U7N) [![Flattr this!](https://img.shields.io/badge/flattr-this-green.svg?style=flat-square)](https://flattr.com/submit/auto?user_id=crazymax&url=https://github.com/crazy-max/docker-dokuwiki)

## About

[DokuWiki](https://www.dokuwiki.org/dokuwiki) Docker image based on Alpine Linux and Nginx.

* Alpine Linux 3.6
* DokuWiki 2017-02-19e
* Nginx
* PHP7
* Supervisord

## How to use this image

### Run using Docker Compose

This is the recommended way to run Dokuwiki. You can use the following docker compose template :

```yaml
version: '2'

services:
  dokuwiki:
    image: crazymax/dokuwiki:latest
    container_name: dokuwiki
    ports:
      - 8000:80
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./conf:/var/www/conf
      - ./data/attic:/var/www/data/attic
      - ./data/media:/var/www/data/media
      - ./data/media_attic:/var/www/data/media_attic
      - ./data/media_meta:/var/www/data/media_meta
      - ./data/meta:/var/www/data/meta
      - ./data/pages:/var/www/data/pages
      - ./lib/plugins:/var/www/lib/plugins
      - ./lib/tpl:/var/www/lib/tpl
    restart: always
```

Then run :

```bash
$ docker-compose up -d
```

### Run manually

If you want to run the application manually instead of using docker-compose, you can run the Dokuwiki container with the following command:

```bash
$ docker run -d -p 8000:80 --name dokuwiki \
  -v /etc/localtime:/etc/localtime:ro \
  -v $(pwd)/conf:/var/www/conf \
  -v $(pwd)/data/attic:/var/www/data/attic \
  -v $(pwd)/data/media:/var/www/data/media \
  -v $(pwd)/data/media_attic:/var/www/data/media_attic \
  -v $(pwd)/data/media_meta:/var/www/data/media_meta \
  -v $(pwd)/data/pages:/var/www/data/pages \
  -v $(pwd)/data/lib/plugins:/var/www/data/lib/plugins \
  -v $(pwd)/data/lib/tpl:/var/www/data/lib/tpl \
  crazymax/dokuwiki:latest
```
