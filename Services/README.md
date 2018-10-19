# STARTX Docker-Images Services based on Fedora 29

This directory host various Open Source services into docker containers based on [startx/fedora:29 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other services flavours](https://github.com/startxfr/docker-images/Services#container-flavours)

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc29)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                     | Doc
|---------------|---------------------------------------------------------------------------|-----------------------------
| Apache        | [`startx/sv-apache:fc29`](https://hub.docker.com/r/startx/sv-apache)      | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb:fc29`](https://hub.docker.com/r/startx/sv-mariadb)    | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache:fc29`](https://hub.docker.com/r/startx/sv-memcache)  | [manual](memcache/README.md) 
| MongoDB       | [`startx/sv-mongo:fc29`](https://hub.docker.com/r/startx/sv-mongo)        | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs:fc29`](https://hub.docker.com/r/startx/sv-nodejs)      | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv:fc29`](https://hub.docker.com/r/startx/sv-ooconv)      | [manual](ooconv/README.md)
| php           | [`startx/sv-php:fc29`](https://hub.docker.com/r/startx/sv-php)            | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres:fc29`](https://hub.docker.com/r/startx/sv-postgres)  | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase:fc29`](https://hub.docker.com/r/startx/sv-couchbase)| [manual](couchbase/README.md)
| Chrome        | [`startx/sv-chrome:fc29`](https://hub.docker.com/r/startx/sv-chrome)      | [manual](chrome/README.md)


## Running from dockerhub registry

| Services            | Command                                                                        |
|---------------------|--------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="fc29-apache" startx/sv-apache:fc29`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="fc29-mariadb" startx/sv-mariadb:fc29`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="fc29-memcache" startx/sv-memcache:fc29`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="fc29-mongo" startx/sv-mongo:fc29`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="fc29-nodejs" startx/sv-nodejs:fc29`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="fc29-ooconv" startx/sv-ooconv:fc29`          | 
| **php**             | `docker run -d -p 80:80 --name="fc29-php" startx/sv-php:fc29`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="fc29-postgres" startx/sv-postgres:fc29`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="fc29-couchbase" startx/sv-couchbase:fc29`  | 
| **chrome**          | `docker run -d -p 5900:5900 --name="fc29-chrome" startx/sv-chrome:fc29`        | 