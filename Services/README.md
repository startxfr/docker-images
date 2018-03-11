# STARTX Docker-Images Services based on CentOS 6

This directory host various Open Source services into docker containers based on [startx/centos:6 container](https://hub.docker.com/r/startx/centos)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other services flavours](https://github.com/startxfr/docker-images/Services#container-flavours)

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=centos6)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                | Fedora flavours                               | CentOS flavours | Doc
|---------------|----------------------------------------------------------------------|-----------------------------------------------|-----------------|--------------------------------
| Apache        | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)      | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)    | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache)  | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](memcache/README.md)
| MongoDB       | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)        | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)      | `:latest` `:21` `:22` `:23` `:26` `:27`       | `:6` `:7`       | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)      | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](ooconv/README.md)
| php           | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)            | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres)  | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` | `:6` `:7`       | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase`](https://hub.docker.com/r/startx/sv-couchbase)|                                               | `:latest` `:7`  | [manual](couchbase/README.md)

## Running from dockerhub registry

| Services            | Command                                                                              |
|---------------------|--------------------------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="centos6-apache" startx/sv-apache:centos6`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="centos6-mariadb" startx/sv-mariadb:centos6`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="centos6-memcache" startx/sv-memcache:centos6`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="centos6-mongo" startx/sv-mongo:centos6`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="centos6-nodejs" startx/sv-nodejs:centos6`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="centos6-ooconv" startx/sv-ooconv:centos6`          | 
| **php**             | `docker run -d -p 80:80 --name="centos6-php" startx/sv-php:centos6`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="centos6-postgres" startx/sv-postgres:centos6`    | 
| **Couchbase**       | `docker run -d -p 8091:8091 --name="centos6-couchbase" startx/sv-couchbase:centos6`  | 
