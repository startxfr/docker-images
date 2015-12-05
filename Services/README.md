<!--[metadata]>
+++
title = "STARTX Docker Images Repository : Services"
description = "Docker services containers based on fedora or CentOS and deliverying main opensources project as container"
keywords = ["home, docker, startx, services, container, swarm, compose, howto, "]
weight=3
+++
<![end-metadata]-->

# STARTX Docker-Images Services Repository

This directory host various Open Source services into docker containers based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, services and application you will find here will be closer to your favorite distrbution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental services in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                               | Fedora                                    | CentOS                  | Doc                                               | 
|---------------|---------------------------------------------------------------------|-------------------------------------------|-------------------------|---------------------------------------------------|
| Apache        | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/apache/README.md)               | 
| MariaDB       | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)   | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/mariadb/README.md)              | 
| Memcache      | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/memcache/README.md)             | 
| MongoDB       | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)       | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/mongo/README.md)                | 
| nodejs        | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/nodejs/README.md)               | 
| ooconv        | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/ooconv/README.md)               | 
| php           | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)           | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/php/README.md)                  | 
| postgreSQL    | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](Services/postgres/README.md)             | 


## Running container from docker registry images

| Services            | Command                                                              |
|---------------------|----------------------------------------------------------------------|
| **Apache**          | `docker run -d -p 80:80 --name="apache" startx/sv-apache`            | 
| **MariaDB**         | `docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb`      | 
| **Memcache**        | `docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache`  | 
| **MongoDB**         | `docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo`        | 
| **nodejs**          | `docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs`        | 
| **ooconv**          | `docker run -d -p XXX:XXX --name="ooconv" startx/sv-ooconv`          | 
| **php**             | `docker run -d -p 80:80 --name="php" startx/sv-php`                  | 
| **postgreSQL**      | `docker run -d -p 5432:5432 --name="postgres" startx/sv-postgres`    | 

## Flavors (tags) for Red Hat like container's

| Service    | Docker Hub repository | Fedora                                    | CentOS                |
|------------|-----------------------|-------------------------------------------|-----------------------|
| Apache     | `startx/sv-apache`    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| MariaDB    | `startx/sv-mariadb`   | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| Memcache   | `startx/sv-memcache`  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| MongoDB    | `startx/sv-mongo`     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| nodejs     | `startx/sv-nodejs`    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| ooconv     | `startx/sv-ooconv`    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| php        | `startx/sv-php`       | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| postgreSQL | `startx/sv-postgres`  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
