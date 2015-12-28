# STARTX Docker-Images Services based on Fedora 22

This directory host various Open Source services into docker containers based on [startx/fedora:22 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other services flavours](https://github.com/startxfr/docker-images/Services#container-flavours)

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                | Doc
|---------------|----------------------------------------------------------------------|-----------------------------
| Apache        | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)      | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)    | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache)  | [manual](memcache/README.md) 
| MongoDB       | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)        | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)      | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)      | [manual](ooconv/README.md)
| php           | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)            | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres)  | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase`](https://hub.docker.com/r/startx/sv-couchbase)| [manual](couchbase/README.md)


## Running from dockerhub registry

| Services            | Command                                                                        |
|---------------------|--------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="fc22-apache" startx/sv-apache:fc22`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="fc22-mariadb" startx/sv-mariadb:fc22`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="fc22-memcache" startx/sv-memcache:fc22`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="fc22-mongo" startx/sv-mongo:fc22`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="fc22-nodejs" startx/sv-nodejs:fc22`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="fc22-ooconv" startx/sv-ooconv:fc22`          | 
| **php**             | `docker run -d -p 80:80 --name="fc22-php" startx/sv-php:fc22`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="fc22-postgres" startx/sv-postgres:fc22`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="fc22-couchbase" startx/sv-couchbase:fc22`  | 