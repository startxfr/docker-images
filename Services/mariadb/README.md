<!--[metadata]>
+++
title = "STARTX Docker Services Images : MARIADB"
description = "Docker container with mariadb service based on latest fedora"
keywords = ["home, docker, startx, mariadb, fedora, centos, repository, container, swarm, compose"]
weight=3
+++
<![end-metadata]-->

# Docker OS Images : MARIADB

Simple and lightweight (170Mo) container used to deliver simple and easy to use transactional database using mysql like database provided by [mariadb open-source project](https://mariadb.org/).
Run [mariadb daemon](https://mariadb.org/) under a container 
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-mariadb/) | [Sources](https://github.com/startxfr/docker-images/Services/mariadb)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------------------------------------------|-----------------------------------------------|

## Available flavours

* `:latest` : Fedora core 23 + MariaDB 
* `:fc23` : Fedora core 23 + MariaDB 
* `:fc22` : Fedora core 22 + MariaDB 
* `:fc21` : Fedora core 21 + MariaDB 
* `:centos7` : CentOS 7 + MariaDB 
* `:centos6` : Centos 6 + MariaDB 

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-mariadb" startx/sv-mariadb` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "mariadb"
    CONTAINER_INSTANCE: "service-mariadb"
    MYSQL_ROOT_PASSWORD: "rootpassword"
    MYSQL_USER: "user-test"
    MYSQL_PASSWORD: "pwd-test"
    MYSQL_DATABASE: "db_test"
  volumes:
    - "/tmp/container/logs/mariadb:/data/logs/mariadb"
    - "/tmp/container/mariadb:/data/mariadb"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  environment:
    CONTAINER_INSTANCE: "service-mariadb"
  ports:
    - "1001:3306"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  environment:
    CONTAINER_INSTANCE: "service-mariadb"
  expose:
    - "3306"
```
* sample docker-compose.yml using data container
```
data:
  image: startx/fedora:latest
  container_name: "service-mariadb-data"
  environment:
    CONTAINER_INSTANCE: "service-mariadb-data"
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  environment:
    CONTAINER_INSTANCE: "service-mariadb"
  volume_from:
    - data:rw
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-mariadb:latest
#... your container specifications
CMD ["/bin/run.sh"]
```

## Environment variable

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| CONTAINER_INSTANCE        | `string` | `yes`     | Container name. Should be uning to get fine grained log and application reporting
| CONTAINER_TYPE            | `string` | `no`      | Container family (os, service, application. could be enhanced 
| CONTAINER_SERVICE         | `string` | `no`      | Define the type of service or application provided
| MYSQL_ROOT_PASSWORD       | `string` | `no`      | Root password used for this instance. Default will use an auto generated password displayed on startup
| MYSQL_USER                | `string` | `no`      | If present, add a new user with this name
| MYSQL_PASSWORD            | `string` | `no`      | Password associated to the new user declared with $MYSQL_USER
| MYSQL_DATABASE            | `string` | `no`      | If present, add a new database with this name
| LOADSQL_PATH              | `string` | `auto`    | Path used to find sql dump to import at startup
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /data/logs/mariadb and used as a volume mountpoint
| DATA_PATH                 | `auto`   | `auto`    | default set to /data/mariadb and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 3306  | standard mariadb network port used for sql communication

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /data/logs/mariadb    | log directory used to record container and mariadb logs
| /data/mariadb         | data directory served by mariadb. If empty will be filled with database files on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running service with mysql terminal `mysql --host=localhost --port=3306 --user=<MYSQL_USER> --password=<MYSQL_PASSWORD>`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/mariadb`
2. Build the container using `docker build -t sv-mariadb .`
3. Run this container 
  1. Interactively with `docker run -p 3306:3306 -v /data/logs/mariadb -it sv-mariadb`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 3306:3306 -v /data/logs/mariadb -d sv-mariadb`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/mariadb`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
