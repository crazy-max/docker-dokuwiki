<p align="center"><a href="https://github.com/crazy-max/docker-dokuwiki" target="_blank"><img height="100"src="https://raw.githubusercontent.com/crazy-max/docker-dokuwiki/master/.res/docker-dokuwiki.png"></a></p>

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

* Alpine Linux 3.7
* DokuWiki 2017-02-19e
* Nginx
* PHP 7
* Supervisord

## Usage

Docker compose is the recommended way to run this image. You can use the following [docker compose template](docker-compose.yml), then run the container :

```bash
$ docker-compose up -d
```

Or use the following command:

```bash
$ docker run -d -p 8000:80 --name dokuwiki \
  -e TZ="Europe/Paris" \
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

## How can i help ?

All kinds of contributions are welcomed :raised_hands:!

The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon:

But we're not gonna lie to each other, I'd rather you buy me a beer or two :beers:!

[![Beerpay](https://beerpay.io/crazy-max/docker-dokuwiki/badge.svg?style=beer-square)](https://beerpay.io/crazy-max/docker-dokuwiki)
[![Paypal](.res/paypal.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USUQWRGP52U7N)

## License

MIT. See `LICENSE` for more details.
