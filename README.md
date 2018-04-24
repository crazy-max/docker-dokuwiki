<p align="center"><a href="https://github.com/crazy-max/docker-dokuwiki" target="_blank"><img height="128"src="https://raw.githubusercontent.com/crazy-max/docker-dokuwiki/master/.res/docker-dokuwiki.jpg"></a></p>

<p align="center">
  <a href="https://microbadger.com/images/crazymax/dokuwiki"><img src="https://images.microbadger.com/badges/version/crazymax/dokuwiki.svg?style=flat-square" alt="Version"></a>
  <a href="https://travis-ci.org/crazy-max/docker-dokuwiki"><img src="https://img.shields.io/travis/crazy-max/docker-dokuwiki/master.svg?style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/dokuwiki/"><img src="https://img.shields.io/docker/stars/crazymax/dokuwiki.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/dokuwiki/"><img src="https://img.shields.io/docker/pulls/crazymax/dokuwiki.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://quay.io/repository/crazymax/dokuwiki"><img src="https://quay.io/repository/crazymax/dokuwiki/status?style=flat-square" alt="Docker Repository on Quay"></a>
  <a href="https://beerpay.io/crazy-max/docker-dokuwiki"><img src="https://img.shields.io/beerpay/crazy-max/docker-dokuwiki.svg?style=flat-square" alt="Beerpay"></a>
  <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USUQWRGP52U7N"><img src="https://img.shields.io/badge/donate-paypal-7057ff.svg?style=flat-square" alt="Paypal"></a>
</p>

## About

🐳 [DokuWiki](https://www.dokuwiki.org/dokuwiki) Docker image based on Alpine Linux and Nginx.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

## Features

### Included

* Alpine Linux 3.7, Nginx, PHP 7.1
* Tarball authenticity checked during building process
* OPCache enabled to store precompiled script bytecode in shared memory

### From docker-compose

* [Traefik](https://github.com/containous/traefik-library-image) as reverse proxy and creation/renewal of Let's Encrypt certificates

## Docker

### Environment variables

* `TZ` : The timezone assigned to the container (default to `UTC`)
* `MEMORY_LIMIT` : PHP memory limit (default to `256M`)
* `UPLOAD_MAX_SIZE` : Upload max size (default to `16M`)
* `OPCACHE_MEM_SIZE` : PHP OpCache memory consumption (default to `128`)

### Volumes

* `/var/www/conf`
* `/var/www/data/attic`
* `/var/www/data/media`
* `/var/www/data/media_attic`
* `/var/www/data/media_meta`
* `/var/www/data/meta`
* `/var/www/data/pages`
* `/var/www/lib/plugins`
* `/var/www/lib/tpl`

### Ports

* `80` : HTTP port

## Use this image

### Docker Compose

Docker compose is the recommended way to run this image. You can use the following [docker compose template](docker-compose.yml), then run the container :

```bash
touch acme.json
chmod 600 acme.json
docker-compose up -d
docker-compose logs -f
```

### Command line

You can also use the following minimal command :

```bash
$ docker run -d -p 8000:80 --name dokuwiki \
  -v $(pwd)/conf:/var/www/conf \
  -v $(pwd)/data/attic:/var/www/data/attic \
  -v $(pwd)/data/media:/var/www/data/media \
  -v $(pwd)/data/media_attic:/var/www/data/media_attic \
  -v $(pwd)/data/media_meta:/var/www/data/media_meta \
  -v $(pwd)/data/meta:/var/www/data/meta \
  -v $(pwd)/data/pages:/var/www/data/pages \
  -v $(pwd)/lib/plugins:/var/www/data/lib/plugins \
  -v $(pwd)/lib/tpl:/var/www/data/lib/tpl \
  crazymax/dokuwiki:latest
```

## Upgrade

You can upgrade DokuWiki automatically through the UI, it works well. But i recommend to recreate the container whenever i push an update :

```bash
docker-compose pull
docker-compose up -d
```

## How can i help ?

All kinds of contributions are welcomed :raised_hands:!<br />
The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon:<br />
But we're not gonna lie to each other, I'd rather you buy me a beer or two :beers:!

[![Beerpay](https://beerpay.io/crazy-max/docker-dokuwiki/badge.svg?style=beer-square)](https://beerpay.io/crazy-max/docker-dokuwiki)
or [![Paypal](.res/paypal.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USUQWRGP52U7N)

## License

MIT. See `LICENSE` for more details.
