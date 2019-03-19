[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Docker-Images Services Repository

This directory host various Open Source services into docker containers based on [startx/fedora:30 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc30)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                     | Doc
|---------------|---------------------------------------------------------------------------|-----------------------------
| Apache        | [`startx/sv-apache:fc30`](https://hub.docker.com/r/startx/sv-apache)      | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb:fc30`](https://hub.docker.com/r/startx/sv-mariadb)    | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache:fc30`](https://hub.docker.com/r/startx/sv-memcache)  | [manual](memcache/README.md) 
| MongoDB       | [`startx/sv-mongo:fc30`](https://hub.docker.com/r/startx/sv-mongo)        | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs:fc30`](https://hub.docker.com/r/startx/sv-nodejs)      | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv:fc30`](https://hub.docker.com/r/startx/sv-ooconv)      | [manual](ooconv/README.md)
| php           | [`startx/sv-php:fc30`](https://hub.docker.com/r/startx/sv-php)            | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres:fc30`](https://hub.docker.com/r/startx/sv-postgres)  | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase:fc30`](https://hub.docker.com/r/startx/sv-couchbase)| [manual](couchbase/README.md)


## Running from dockerhub registry

| Services            | Command                                                                        |
|---------------------|--------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="fc30-apache" startx/sv-apache:fc30`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="fc30-mariadb" startx/sv-mariadb:fc30`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="fc30-memcache" startx/sv-memcache:fc30`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="fc30-mongo" startx/sv-mongo:fc30`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="fc30-nodejs" startx/sv-nodejs:fc30`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="fc30-ooconv" startx/sv-ooconv:fc30`          | 
| **php**             | `docker run -d -p 80:80 --name="fc30-php" startx/sv-php:fc30`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="fc30-postgres" startx/sv-postgres:fc30`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="fc30-couchbase" startx/sv-couchbase:fc30`  | 
| **chrome**          | `docker run -d -p 5900:5900 --name="fc30-chrome" startx/sv-chrome:fc30`        | 