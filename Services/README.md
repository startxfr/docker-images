<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# STARTX Docker-Images Services Repository

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/)

[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

This directory host various Open Source services into docker containers based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry
or as a parent container in your own container's.
Each container is provided with various underlying OS version based on CentOS or
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in
your project and start using stable or experimental services in your applications

## Available services

| Service        | Docker.io                                                             | Quay.io                                                           | Docs                          |
| -------------- | --------------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------- |
| **Apache**     | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)       | [`startx/apache`](https://quay.io/repository/startx/apache)       | [manual](apache/README.md)    |
| **MariaDB**    | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)     | [`startx/mariadb`](https://quay.io/repository/startx/mariadb)     | [manual](mariadb/README.md)   |
| **Memcache**   | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache)   | [`startx/memcache`](https://quay.io/repository/startx/memcache)   | [manual](memcache/README.md)  |
| **MongoDB**    | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)         | [`startx/mongo`](https://quay.io/repository/startx/mongo)         | [manual](mongo/README.md)     |
| **nodejs**     | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)       | [`startx/nodejs`](https://quay.io/repository/startx/nodejs)       | [manual](nodejs/README.md)    |
| **ooconv**     | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)       | [`startx/ooconv`](https://quay.io/repository/startx/ooconv)       | [manual](ooconv/README.md)    |
| **php**        | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)             | [`startx/php`](https://quay.io/repository/startx/php)             | [manual](php/README.md)       |
| **postgreSQL** | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres)   | [`startx/postgres`](https://quay.io/repository/startx/postgres)   | [manual](postgres/README.md)  |
| **Couchbase**  | [`startx/sv-couchbase`](https://hub.docker.com/r/startx/sv-couchbase) | [`startx/couchbase`](https://quay.io/repository/startx/couchbase) | [manual](couchbase/README.md) |

## Available Flavours

| Service        | Fedora flavours                                                                                   | CentOS flavours                  | Alpine     | UBI     |
| -------------- | ------------------------------------------------------------------------------------------------- | -------------------------------- | ---------- | ------- |
| **Apache**     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **MariaDB**    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **Memcache**   | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32`         | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **MongoDB**    | `:latest` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32`                 | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **nodejs**     | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32`         | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **ooconv**     | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32`         | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **php**        | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **postgreSQL** | `:latest` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32`                         | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **Couchbase**  | `:latest` `:fc29` `:fc30` `:fc31` `:fc32`                                                         | `:centos7` `:centos8`            |            | `:ubi8` |

## Running from dockerhub registry

| Services       | Command                                                             |
| -------------- | ------------------------------------------------------------------- |
| **Apache**     | `docker run -d -p 80:80 --name="apache" startx/sv-apache`           |
| **MariaDB**    | `docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb`     |
| **Memcache**   | `docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache` |
| **MongoDB**    | `docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo`       |
| **nodejs**     | `docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs`       |
| **ooconv**     | `docker run -d -p XXX:XXX --name="ooconv" startx/sv-ooconv`         |
| **php**        | `docker run -d -p 80:80 --name="php" startx/sv-php`                 |
| **postgreSQL** | `docker run -d -p 5432:5432 --name="postgres" startx/sv-postgres`   |
