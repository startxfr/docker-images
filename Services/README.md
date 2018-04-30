# STARTX Docker-Images Services based on alpine 3.7

This directory host various Open Source services into docker containers based on [startx/alpine:3 container](https://hub.docker.com/r/startx/alpine)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Alpine Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other services flavours](https://github.com/startxfr/docker-images/Services#container-flavours)

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=alpine3)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                     | Doc
|---------------|---------------------------------------------------------------------------|-----------------------------
| Apache        | [`startx/sv-apache:alpine3`](https://hub.docker.com/r/startx/sv-apache)      | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb:alpine3`](https://hub.docker.com/r/startx/sv-mariadb)    | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache:alpine3`](https://hub.docker.com/r/startx/sv-memcache)  | [manual](memcache/README.md) 
| MongoDB       | [`startx/sv-mongo:alpine3`](https://hub.docker.com/r/startx/sv-mongo)        | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs:alpine3`](https://hub.docker.com/r/startx/sv-nodejs)      | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv:alpine3`](https://hub.docker.com/r/startx/sv-ooconv)      | [manual](ooconv/README.md)
| php           | [`startx/sv-php:alpine3`](https://hub.docker.com/r/startx/sv-php)            | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres:alpine3`](https://hub.docker.com/r/startx/sv-postgres)  | [manual](postgres/README.md)


## Running from dockerhub registry

| Services            | Command                                                                        |
|---------------------|--------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="alpine3-apache" startx/sv-apache:alpine3`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="alpine3-mariadb" startx/sv-mariadb:alpine3`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="alpine3-memcache" startx/sv-memcache:alpine3`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="alpine3-mongo" startx/sv-mongo:alpine3`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="alpine3-nodejs" startx/sv-nodejs:alpine3`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="alpine3-ooconv" startx/sv-ooconv:alpine3`          | 
| **php**             | `docker run -d -p 80:80 --name="alpine3-php" startx/sv-php:alpine3`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="alpine3-postgres" startx/sv-postgres:alpine3`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="alpine3-couchbase" startx/sv-couchbase:alpine3`  | 
