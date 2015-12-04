<!--[metadata]>
+++
title = "STARTX Docker Images Repository"
description = "Docker container repository based on fedora or CentOS and deliverying main opensource project as container"
keywords = ["home, docker, startx, repository, container, swarm, compose, howto, "]
weight=3
+++
<![end-metadata]-->

# STARTX Docker-Images Repository

This repository host various Open Source application or services as a container. 

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution.

You can read each container manual for more information on how you can use it in 
your project and start using stable or experimental services in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Registry](https://github.com/startxfr/docker-images) | [Sources](https://github.com/startxfr/docker-images/tree/master/) | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available services and images

### Operating Systems

| OS            | Docker Hub repository                                      | Flavour                            | Documentation                        | 
|---------------|------------------------------------------------------------|------------------------------------|--------------------------------------|
| Fedora Core   | [`startx/fedora`](https://hub.docker.com/r/startx/fedora)  | `:latest` `:20` `:21` `:22` `:23`  | [manual](tree/master/OS/README.md)   | 
| CentOS        | [`startx/centos`](https://hub.docker.com/r/startx/centos)  | `:6` `:7`                          | [manual](tree/centos7/OS/README.md)  |


### Services

| Service       | Docker Hub repository                                               | Fedora                                    | CentOS                  | Doc                                               | 
|---------------|---------------------------------------------------------------------|-------------------------------------------|-------------------------|---------------------------------------------------|
| Apache        | [`startx/sv-apache`](https://hub.docker.com/r/startx/sv-apache)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/apache/README.md)   | 
| MariaDB       | [`startx/sv-mariadb`](https://hub.docker.com/r/startx/sv-mariadb)   | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/mariadb/README.md)  | 
| Memcache      | [`startx/sv-memcache`](https://hub.docker.com/r/startx/sv-memcache) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/memcache/README.md) | 
| MongoDB       | [`startx/sv-mongo`](https://hub.docker.com/r/startx/sv-mongo)       | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/mongo/README.md)    | 
| nodejs        | [`startx/sv-nodejs`](https://hub.docker.com/r/startx/sv-nodejs)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/nodejs/README.md)   | 
| ooconv        | [`startx/sv-ooconv`](https://hub.docker.com/r/startx/sv-ooconv)     | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/ooconv/README.md)   | 
| php           | [`startx/sv-php`](https://hub.docker.com/r/startx/sv-php)           | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/php/README.md)      | 
| postgreSQL    | [`startx/sv-postgres`](https://hub.docker.com/r/startx/sv-postgres) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Services/postgres/README.md) | 


### Applications

| Service         | Docker Hub repository                                                     | Fedora                                    | CentOS                  | Doc                                                     | 
|-----------------|---------------------------------------------------------------------------|-------------------------------------------|-------------------------|---------------------------------------------------------|
| PhpMyAdmin      | [`startx/app-pma`](https://hub.docker.com/r/startx/app-pma)               | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Applications/pma/README.md)        | 
| RockMongo       | [`startx/app-rockmongo`](https://hub.docker.com/r/startx/app-rockmongo)   | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7`   | [manual](tree/master/Applications/rockmongo/README.md)  | 


## For advanced users

You you want to use this repository and code to build and create locally theses containers. You can follow theses instructions to settup and working environment.

This section is usefull if you want :
* Get latest version of embedded services, applications and underlying OS
* Ehance container content by adding instruction into container(s) Dockefile before the build process
* Use this set of container and flavour to benchmark application performance

### Setup your working environment

1. **Install docker and docker-compose on you environment** 
   a. Check if you have a running docker daemon using `docker --version` If not try to run it using `sudo docker --daemon`. If docker is not installed, follow [docker installation guidelines](https://docs.docker.com/v1.8/installation/)
   b. Check if you have docker compose installed using `docker-compose --version`. If docker-compose is not installed, follow [docker-compose installation guidelines](https://docs.docker.com/compose/install/)
2. **Copy repository source locally**
   a. Setup a working directory with `mkdir startx-docker-images; cd startx-docker-images;`
   b. Clone source repository with `git clone https://github.com/startxfr/docker-images.git .`


### Build all containers (using docker-compose)
If you want to build and run locally all the images provided in this repository, you can follow this instructions

3. Run a complete set of container
   a. Choose your flavour with `git checkout ≤flavour_name>`. You can use every flavour available in this repository. Default is set to master branch related to the `:latest` flavour
   b. Create host directory to store container content with `mkdir /tmp/container`.
   c. Start building all containers with `docker-compose build`. You should be on top of your working directory to run this command. It will use the docker-compose.yml file located into this directory.
   d. Wait... (could take some time as you are building the complete list of services
   e. Run your multi-container with `docker-compose up -d`
   f. Look at your containers startup with `docker-compose logs`. You can add a service name to get logs about this specific container. You can also monitor /tmp/container/logs to see logs comming from all containers
   g. Monitor containers with `docker-compose ps`.

### Build a single container

### Build a container using `docker`

1. Build the container using `docker build -t <image_name> <path_to_Dockerfile>` where *image_name* is the name of your future local image and *path_to_Dockerfile* should point to the targeted service or application directory, not including the Dockefile filename
2. Run this container 
   a. Interactively with `docker run -it <image_name>` where *image_name* is the name of your previously created image name. If you add a second parameter, you can run a particular command instead of the default entrypoint. Could be usefull when you add ` /bin/bash` to get a shell running into the container
   b. As a deamon with `docker run -d <image_name>` where *image_name* is the name of your previously created image name. 






## Running container from docker registry images

### Operating Systems
| OS                  | Command                                                              |
|---------------------|----------------------------------------------------------------------|
| Fedora Core         | `docker run -it --name="fedora" startx/fedora bash`                  | 
| CentOS              | `docker run -it --name="centos" startx/centos bash`                  |

### Services
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

### Applications
| Applications        | Command                                                              |
|---------------------|----------------------------------------------------------------------|
| **PhpMyAdmin**      | `docker run -d -p 80:80 --name="pma" startx/app-pma`                 | 
| **RockMongo**       | `docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo`     | 

## Flavors (tags) for Red Hat like container's

This repository offer various flavour of Red Hat like distribution. Tag `:latest` is actually pointing to fedora core 20

### Operating Systems
| OS            | Docker Hub repository          | Flavour                            |
|---------------|--------------------------------|------------------------------------|
| Fedora Core   | `startx/fedora`                | `:latest` `:20` `:21` `:22` `:23`  | 
| CentOS        | `startx/centos`                | `:6` `:7`                          |

### Services
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

### Applications
| Service    | Docker Hub repository | Fedora                                    | CentOS                |
|------------|-----------------------|-------------------------------------------|-----------------------|
| PhpMyAdmin | `startx/sv-pma`       | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |
| RockMongo  | `startx/sv-rockmongo` | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` | `:centos6` `:centos7` |

### Running sample container's

#### Fedora Core latest (actually fc23) container's

	# For Fedora example, port start from 50100
	docker run -d -it --name="fedora" startx/fedora bash
	docker run -d -p 50100:80 --name="fedora-apache" startx/sv-apache
	docker run -d -p 50101:3306 --name="fedora-mariadb" startx/sv-mariadb
	docker run -d -p 50102:11211 --name="fedora-memcache" startx/sv-memcache
	docker run -d -p 50103:27017 --name="fedora-mongo" startx/sv-mongo
	docker run -d -p 50104:8000 --name="fedora-nodejs" startx/sv-nodejs
	docker run -d -p 50105:80 --name="fedora-php" startx/sv-php
	docker run -d -p 50106:5432 --name="fedora-postgres" startx/sv-postgres
	docker run -d -p 50108:80 --name="fedora-pma" startx/app-pma
	docker run -d -p 50109:80 --name="fedora-rockmongo" startx/app-rockmongo

#### Fedora Core 20 container's

	# For Fedora core 20 example, port start from 50200
	docker run -d -it --name="fedora20" startx/fedora:20 bash
	docker run -d -p 50200:80 --name="fedora20-apache" startx/sv-apache:fc20
	docker run -d -p 50201:3306 --name="fedora20-mariadb" startx/sv-mariadb:fc20
	docker run -d -p 50202:11211 --name="fedora20-memcache" startx/sv-memcache:fc20
	docker run -d -p 50203:27017 --name="fedora20-mongo" startx/sv-mongo:fc20
	docker run -d -p 50204:8000 --name="fedora20-nodejs" startx/sv-nodejs:fc20
	docker run -d -p 50205:80 --name="fedora20-php" startx/sv-php:fc20
	docker run -d -p 50206:5432 --name="fedora20-postgres" startx/sv-postgres:fc20
	docker run -d -p 50208:80 --name="fedora20-pma" startx/app-pma:fc20
	docker run -d -p 50209:80 --name="fedora20-rockmongo" startx/app-rockmongo:fc20

#### Fedora Core 21 container's

	# For Fedora core 21 example, port start from 50300
	docker run -d -it --name="fedora21" startx/fedora:21 bash
	docker run -d -p 50300:80 --name="fedora21-apache" startx/sv-apache:fc21
	docker run -d -p 50301:3306 --name="fedora21-mariadb" startx/sv-mariadb:fc21
	docker run -d -p 50302:11211 --name="fedora21-memcache" startx/sv-memcache:fc21
	docker run -d -p 50303:27017 --name="fedora21-mongo" startx/sv-mongo:fc21
	docker run -d -p 50304:8000 --name="fedora21-nodejs" startx/sv-nodejs:fc21
	docker run -d -p 50305:80 --name="fedora21-php" startx/sv-php:fc21
	docker run -d -p 50306:5432 --name="fedora21-postgres" startx/sv-postgres:fc21
	docker run -d -p 50308:80 --name="fedora21-pma" startx/app-pma:fc21
	docker run -d -p 50309:80 --name="fedora21-rockmongo" startx/app-rockmongo:fc21

#### Fedora Core 22 container's

	# For Fedora core 22 example, port start from 50300
	docker run -d -it --name="fedora22" startx/fedora:22 bash
	docker run -d -p 50600:80 --name="fedora22-apache" startx/sv-apache:fc22
	docker run -d -p 50601:3306 --name="fedora22-mariadb" startx/sv-mariadb:fc22
	docker run -d -p 50602:11211 --name="fedora22-memcache" startx/sv-memcache:fc22
	docker run -d -p 50603:27017 --name="fedora22-mongo" startx/sv-mongo:fc22
	docker run -d -p 50604:8000 --name="fedora22-nodejs" startx/sv-nodejs:fc22
	docker run -d -p 50605:80 --name="fedora22-php" startx/sv-php:fc22
	docker run -d -p 50606:5432 --name="fedora22-postgres" startx/sv-postgres:fc22
	docker run -d -p 50608:80 --name="fedora22-pma" startx/app-pma:fc22
	docker run -d -p 50609:80 --name="fedora22-rockmongo" startx/app-rockmongo:fc22

#### Fedora Core 23 container's

	# For Fedora core 23 example, port start from 50300
	docker run -d -it --name="fedora23" startx/fedora:23 bash
	docker run -d -p 50700:80 --name="fedora23-apache" startx/sv-apache:fc23
	docker run -d -p 50701:3306 --name="fedora23-mariadb" startx/sv-mariadb:fc23
	docker run -d -p 50702:11211 --name="fedora23-memcache" startx/sv-memcache:fc23
	docker run -d -p 50703:27017 --name="fedora23-mongo" startx/sv-mongo:fc23
	docker run -d -p 50704:8000 --name="fedora23-nodejs" startx/sv-nodejs:fc23
	docker run -d -p 50705:80 --name="fedora23-php" startx/sv-php:fc23
	docker run -d -p 50706:5432 --name="fedora23-postgres" startx/sv-postgres:fc23
	docker run -d -p 50708:80 --name="fedora23-pma" startx/app-pma:fc23
	docker run -d -p 50709:80 --name="fedora23-rockmongo" startx/app-rockmongo:fc23

#### CentOS 6 container's

	# For CentOS 6 example, port start from 50400
	docker run -d -it --name="centos6" startx/centos:6 bash
	docker run -d -p 50400:80 --name="centos6-apache" startx/sv-apache:centos6
	docker run -d -p 50401:3306 --name="centos6-mariadb" startx/sv-mariadb:centos6
	docker run -d -p 50402:11211 --name="centos6-memcache" startx/sv-memcache:centos6
	docker run -d -p 50403:27017 --name="centos6-mongo" startx/sv-mongo:centos6
	docker run -d -p 50404:8000 --name="centos6-nodejs" startx/sv-nodejs:centos6
	docker run -d -p 50405:80 --name="centos6-php" startx/sv-php:centos6
	docker run -d -p 50406:5432 --name="centos6-postgres" startx/sv-postgres:centos6
	docker run -d -p 50408:80 --name="centos6-pma" startx/app-pma:centos6
	docker run -d -p 50409:80 --name="centos6-rockmongo" startx/app-rockmongo:centos6

#### CentOS 7 container's

	# For CentOS 7 example, port start from 50500
	docker run -d -it --name="centos7" startx/centos:7 bash
	docker run -d -p 50500:80 --name="centos7-apache" startx/sv-apache:centos7
	docker run -d -p 50501:3306 --name="centos7-mariadb" startx/sv-mariadb:centos7
	docker run -d -p 50502:11211 --name="centos7-memcache" startx/sv-memcache:centos7
	docker run -d -p 50503:27017 --name="centos7-mongo" startx/sv-mongo:centos7
	docker run -d -p 50504:8000 --name="centos7-nodejs" startx/sv-nodejs:centos7
	docker run -d -p 50505:80 --name="centos7-php" startx/sv-php:centos7
	docker run -d -p 50506:5432 --name="centos7-postgres" startx/sv-postgres:centos7
	docker run -d -p 50508:80 --name="centos7-pma" startx/app-pma:centos7
	docker run -d -p 50509:80 --name="centos7-rockmongo" startx/app-rockmongo:centos7

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host / build server

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t <tag_name> <path_to_Dockerfile>

### Running local image
Running an interactive image and get access to shell

	docker run -it <image_name> <cmd>

Running an image as a daemon

	docker run -d <image_name>
	docker exec -it <image_name> <cmd>

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)