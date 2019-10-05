# Changelog

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
