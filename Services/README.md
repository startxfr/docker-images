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

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services

| Service       | Docker Hub repository                                                | Fedora flavours                                                                   | CentOS flavours             | Doc
|---------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------------|-----------------------------|--------------------------------
| Apache        | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)      | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](apache/README.md)
| MariaDB       | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](mariadb/README.md)
| Memcache      | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache)  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](memcache/README.md)
| MongoDB       | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)        | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](mongo/README.md)
| nodejs        | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)      | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`         | `:centos6` `:centos7`       | [manual](nodejs/README.md)
| ooconv        | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)      | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](ooconv/README.md)
| php           | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)            | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](php/README.md)
| postgreSQL    | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres)  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` | `:centos6` `:centos7`       | [manual](postgres/README.md)
| Couchbase     | [`startx/sv-couchbase`](https://hub.docker.com/r/startx/sv-couchbase)|                                                                                   | `:centos7`                  | [manual](couchbase/README.md)
| Chrome        | [`startx/sv-chrome`](https://hub.docker.com/r/startx/sv-chrome)      | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30`                                 | `:centos7`                  | [manual](chrome/README.md)

## Running from dockerhub registry

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
| **chrome**          | `docker run -d -p 5900:5900 --name="chrome" startx/sv-chrome`        | 

## Container flavours

| Service    | Docker Hub repository                                                | Fedora                                                                               | CentOS                |
|------------|----------------------------------------------------------------------|--------------------------------------------------------------------------------------|-----------------------|
| Apache     | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)      | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| MariaDB    | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)    | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| Memcache   | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache)  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| MongoDB    | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)        | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| nodejs     | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)      | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`            | `:centos6` `:centos7` |
| ooconv     | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)      | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| php        | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)            | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| postgreSQL | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres)  | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30`    | `:centos6` `:centos7` |
| Chrome     | [`startx/sv-chrome`](https://hub.docker.com/r/startx/sv-chrome)      | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30`                                    | `:centos7`            |
