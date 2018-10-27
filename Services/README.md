[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Docker-Images Services Repository

This directory host various Open Source services into docker containers based on [startx/fedora:27 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other services flavours](https://github.com/startxfr/docker-images/Services#container-flavours)

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc27)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                     | Doc
|---------------|---------------------------------------------------------------------------|-----------------------------
| Apache        | [`startx/sv-apache:fc27`](https://hub.docker.com/r/startx/sv-apache)      | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb:fc27`](https://hub.docker.com/r/startx/sv-mariadb)    | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache:fc27`](https://hub.docker.com/r/startx/sv-memcache)  | [manual](memcache/README.md) 
| MongoDB       | [`startx/sv-mongo:fc27`](https://hub.docker.com/r/startx/sv-mongo)        | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs:fc27`](https://hub.docker.com/r/startx/sv-nodejs)      | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv:fc27`](https://hub.docker.com/r/startx/sv-ooconv)      | [manual](ooconv/README.md)
| php           | [`startx/sv-php:fc27`](https://hub.docker.com/r/startx/sv-php)            | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres:fc27`](https://hub.docker.com/r/startx/sv-postgres)  | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase:fc27`](https://hub.docker.com/r/startx/sv-couchbase)| [manual](couchbase/README.md)


## Running from dockerhub registry

| Services            | Command                                                                        |
|---------------------|--------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="fc27-apache" startx/sv-apache:fc27`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="fc27-mariadb" startx/sv-mariadb:fc27`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="fc27-memcache" startx/sv-memcache:fc27`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="fc27-mongo" startx/sv-mongo:fc27`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="fc27-nodejs" startx/sv-nodejs:fc27`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="fc27-ooconv" startx/sv-ooconv:fc27`          | 
| **php**             | `docker run -d -p 80:80 --name="fc27-php" startx/sv-php:fc27`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="fc27-postgres" startx/sv-postgres:fc27`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="fc27-couchbase" startx/sv-couchbase:fc27`  | 