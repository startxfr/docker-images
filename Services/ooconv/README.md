<!--[metadata]>
+++
title = "STARTX Docker Services Images : OOCONV on Fedora 23"
description = "Docker container with ooconv service based on fedora 23"
keywords = ["home, docker, startx, ooconv, fedora 23, centos, repository, container, swarm, compose"]
weight=3
+++
<![end-metadata]-->

# Docker OS Images : OOCONV on Fedora 23

Simple and lightweight (450Mo) container used to document convertion and manipulation tools
Run [libreoffice](https://www.libreoffice.org/) as a daemon using [dagwieers unoconv](https://github.com/dagwieers/unoconv) under a container 
based on [startx/fedora:23 container](https://hub.docker.com/r/startx/fedora)

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or **[other ooconv flavours](https://github.com/startxfr/docker-images/Services/ooconv/#available-flavours)**

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-ooconv/) | [Sources](https://github.com/startxfr/docker-images/Services/ooconv)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|----------------------------------------------------------------------------------|-----------------------------------------------|

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-ooconv" startx/sv-ooconv` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-ooconv:fc23
  container_name: "service-ooconv-fc23"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "ooconv"
    CONTAINER_INSTANCE: "service-ooconv-fc23"
  volumes:
    - "/tmp/container-fc23/logs/ooconv:/data/logs/ooconv"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```
service:
  image: startx/sv-ooconv:fc23
  container_name: "service-ooconv-fc23"
  environment:
    CONTAINER_INSTANCE: "service-ooconv-fc23"
  ports:
    - "1000:2002"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-ooconv:fc23
  container_name: "service-ooconv-fc23"
  environment:
    CONTAINER_INSTANCE: "service-ooconv-fc23"
  expose:
    - "2002"
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-ooconv:fc23
#... your container specifications
CMD ["/bin/run.sh"]
```

## Environment variable

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| CONTAINER_INSTANCE        | `string` | `yes`     | Container name. Should be uning to get fine grained log and application reporting
| CONTAINER_TYPE            | `string` | `no`      | Container family (os, service, application. could be enhanced 
| CONTAINER_SERVICE         | `string` | `no`      | Define the type of service or application provided
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /data/logs/ooconv and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 2002  | network port used to communicate with unoconv service

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /data/logs/ooconv    | log directory used to record container and ooconv logs

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc23`
2. Jump into the container directory with `cd Services/ooconv`
3. Build the container using `docker build -t sv-ooconv .`
4. Run this container 
  1. Interactively with `docker run -p 2002:2002 -v /data/logs/ooconv -it sv-ooconv`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 2002:2002 -v /data/logs/ooconv -d sv-ooconv`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc23`
2. Jump into the container directory with `cd Services/ooconv`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
