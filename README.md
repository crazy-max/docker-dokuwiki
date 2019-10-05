<p align="center"><a href="https://github.com/crazy-max/docker-dokuwiki" target="_blank"><img height="128"src="https://raw.githubusercontent.com/crazy-max/docker-dokuwiki/master/.res/docker-dokuwiki.jpg"></a></p>

<p align="center">
  <a href="https://hub.docker.com/r/crazymax/dokuwiki/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/github/v/tag/crazy-max/docker-dokuwiki?label=version&style=flat-square" alt="Latest Version"></a>
  <a href="https://github.com/crazy-max/docker-dokuwiki/actions?workflow=build"><img src="https://github.com/crazy-max/docker-dokuwiki/workflows/build/badge.svg" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/dokuwiki/"><img src="https://img.shields.io/docker/stars/crazymax/dokuwiki.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/dokuwiki/"><img src="https://img.shields.io/docker/pulls/crazymax/dokuwiki.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://www.codacy.com/app/crazy-max/docker-dokuwiki"><img src="https://img.shields.io/codacy/grade/e1c3ab643f734445bf7f6ecdd44a2614.svg?style=flat-square" alt="Code Quality"></a>
  <br /><a href="https://www.patreon.com/crazymax"><img src="https://img.shields.io/badge/donate-patreon-f96854.svg?logo=patreon&style=flat-square" alt="Support me on Patreon"></a>
  <a href="https://www.paypal.me/crazyws"><img src="https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square" alt="Donate Paypal"></a>
</p>

## About

🐳 [DokuWiki](https://www.dokuwiki.org/dokuwiki) Docker image based on Alpine Linux.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

💡 Want to be notified of new releases? Check out 🔔 [Diun (Docker Image Update Notifier)](https://github.com/crazy-max/diun) project!

## Docker

### Multi-platform image

Following platforms for this image are available:

```
$ docker run --rm mplatform/mquery crazymax/dokuwiki:latest
Image: crazymax/dokuwiki:latest
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v6
   - linux/arm/v7
   - linux/arm64
   - linux/386
   - linux/ppc64le
   - linux/s390x
```

### Environment variables

* `TZ` : The timezone assigned to the container (default `UTC`)
* `MEMORY_LIMIT` : PHP memory limit (default `256M`)
* `UPLOAD_MAX_SIZE` : Upload max size (default `16M`)
* `OPCACHE_MEM_SIZE` : PHP OpCache memory consumption (default `128`)
* `REAL_IP_FROM` : Trusted addresses that are known to send correct replacement addresses (default `0.0.0.0/32`)
* `REAL_IP_HEADER` : Request header field whose value will be used to replace the client address (default `X-Forwarded-For`)
* `LOG_IP_VAR` : Use another variable to retrieve the remote IP address for access [log_format](http://nginx.org/en/docs/http/ngx_http_log_module.html#log_format) on Nginx. (default `remote_addr`)

### Volumes

* `/data` : Contains configuration, plugins, templates and data

> :warning: Note that the volume should be owned by uid `1500` and gid `1500`. If you don't give the volume correct permissions, the container may not start.

### Ports

* `8000` : HTTP port

## Usage

### Docker Compose

Docker compose is the recommended way to run this image. You can use the following [docker compose template](examples/compose/docker-compose.yml), then run the container :

```bash
touch acme.json
chmod 600 acme.json
docker-compose up -d
docker-compose logs -f
```

### Command line

You can also use the following minimal command :

```bash
docker run -d -p 8000:8000 --name dokuwiki \
  -v $(pwd)/data:/data \
  crazymax/dokuwiki:latest
```

## Upgrade

You can upgrade DokuWiki automatically through the UI, it works well. But i recommend to recreate the container whenever i push an update :

```bash
docker-compose pull
docker-compose up -d
```

## How can I help ?

All kinds of contributions are welcome :raised_hands:!<br />
The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon:<br />
But we're not gonna lie to each other, I'd rather you buy me a beer or two :beers:!

[![Support me on Patreon](.res/patreon.png)](https://www.patreon.com/crazymax) 
[![Paypal Donate](.res/paypal.png)](https://www.paypal.me/crazyws)

## License

MIT. See `LICENSE` for more details.
