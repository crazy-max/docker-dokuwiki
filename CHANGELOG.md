# Changelog

## 2023-04-04-r1 (2023/05/04)

* Add `php81-iconv` extension (#54)

## 2023-04-04-r0 (2023/05/04)

* Dokuwiki 2023-04-04 (#53)
* Add `php81-dom` extension (#49)

## 2022-07-31a-r1 (2022/12/29)

* Alpine Linux 3.17
* PHP 8.1

## 2022-07-31a-r0 (2022/09/11)

* Dokuwiki 2022-07-31a
* Alpine Linux 3.16
* PHP 8

## 2020-07-29-r10 (2021/08/19)

* alpine-s6 3.14-2.2.0.3 (#38)
* Move to `docker/metadata-action`

## 2020-07-29-r9 (2021/03/18)

* Upstream Alpine update

## 2020-07-29-r8 (2021/03/04)

* Renamed `yasu` (more info https://github.com/crazy-max/yasu#yet-another)

## 2020-07-29-r7 (2021/03/02)

* Switch to `gosu`

## 2020-07-29-r6 (2021/02/20)

* Downgrade s6-overlay to 2.1.0.2 (#29)

## 2020-07-29-r5 (2021/02/20)

* Fix preload path for auto prepend (#26)

## 2020-07-29-r4 (2021/02/20)

* Auto preprend preload (#26)
* Add option to disable indexer on startup (#25)
* Fix DOKU_INC (#26)
* s6-overlay 2.2.0.3
* Switch to buildx bake
* Publish to GHCR
* Allow to clear environment in FPM workers

## 2020-07-29-RC3 (2020/09/28)

* Add SQLite 3.x driver for PDO (#21)

## 2020-07-29-RC2 (2020/08/09)

* Now based on [Alpine Linux 3.12 with s6 overlay](https://github.com/crazy-max/docker-alpine-s6/)

## 2020-07-29-RC1 (2020/08/05)

* DokuWiki 2020-07-29

## 2020-06-09rc-RC1 (2020/06/28)

* DokuWiki 2020-06-09rc
* Alpine Linux 3.12

## 2018-04-22c-RC2 (2020/05/29)

* Alpine Linux 3.11

## 2018-04-22c-RC1 (2020/05/13)

* DokuWiki 2018-04-22c
* Add `LISTEN_IPV6` env var

## 2018-04-22b-RC17 (2020/04/18)

* Fix install (#6)
* Switch to Open Container Specification labels as label-schema.org ones are deprecated

## 2018-04-22b-RC16 (2020/03/27)

* Fix folder creation

## 2018-04-22b-RC15 (2020/01/24)

* Move Nginx temp folders to `/tmp`

## 2018-04-22b-RC14 (2019/12/18)

* Add imagemagick libraries for many image formats

## 2018-04-22b-RC13 (2019/12/07)

* Fix timezone

## 2018-04-22b-RC12 (2019/11/25)

* Fix s6-overlay on other platforms

## 2018-04-22b-RC11 (2019/11/17)

* Switch to [s6-overlay](https://github.com/just-containers/s6-overlay/) as a process supervisor
* Add `PUID`/`PGID` vars

## 2018-04-22b-RC10 (2019/10/18)

* Add `php7-simplexml` (PR #5)

## 2018-04-22b-RC9 (2019/10/05)

* Multi-platform Docker image
* Switch to GitHub Actions
* :warning: Stop publishing Docker image on Quay
* :warning: Run as non-root user
* Prevent exposing nginx version
* Set timezone through tzdata

> :warning: **UPGRADE NOTES**
> As the Docker container now runs as a non-root user, you have to first stop the container and change permissions to `data` volume:
> ```
> docker-compose stop
> chown -R 1500:1500 data/
> docker-compose pull
> docker-compose up -d
> ```

## 2018-04-22b-RC8 (2019/09/10)

* Add sqlite3 PHP extension

## 2018-04-22b-RC7 (2019/09/09)

* Add LDAP PHP extension

## 2018-04-22b-RC6 (2019/08/04)

* Add healthcheck
* Remove php-fpm access log (already mirrored by nginx)

## 2018-04-22b-RC5 (2019/06/23)

* Alpine Linux 3.10

## 2018-04-22b-RC4 (2019/04/28)

* Add `large_client_header_buffers` Nginx config

## 2018-04-22b-RC3 (2019/04/14)

* Add `REAL_IP_FROM`, `REAL_IP_HEADER` and `LOG_IP_VAR` environment variables

## 2018-04-22b-RC2 (2019/01/31)

* Alpine Linux 3.9

## 2018-04-22b-RC1 (2019/01/06)

* DokuWiki 2018-04-22b

## 2018-04-22a-RC4 (2018/12/29)

* Bind to unprivileged port : `8000`

## 2018-04-22a-RC3 (2018/09/25)

* Update from upstream
* Dockerfile maintainer deprecated

## 2018-04-22a-RC2 (2018/07/28)

* Alpine Linux 3.8
* PHP 7.2

## 2018-04-22a-RC1 (2018/05/03)

* DokuWiki 2018-04-22a

## 2018-04-22-RC2 (2018/04/25)

* Manage data, conf, plugins and templates in an unique folder (`/data`)
* Bug during first installation

## 2018-04-22-RC1 (2018/04/24)

* DokuWiki 2018-04-22 "Greebo"
* Improve Nginx configuration
* Permissions fix
* Add Traefik (see docker-compose)
* Disable auto restart and retries of "supervisored" programs (Docker Way)
* Redirect Nginx and PHP-FPM to stdout
* Remove build dependencies
* Publish image to Quay
* Add GD and ImageMagick lib

## 2017-02-19e-RC4 (2018/01/10)

* Alpine Linux 3.7

## 2017-02-19e-RC3 (2017/11/14)

* Push Docker image through TravisCI

## 2017-02-19e-RC2 (2017/09/24)

* Problem with symlinks and ajax requests

## 2017-02-19e-RC1 (2017/09/23)

* Initial version based on DokuWiki 2017-02-19e "Frusterick Manners"
