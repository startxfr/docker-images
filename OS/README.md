<!--[metadata]>
+++
title = "STARTX Docker Images Repository"
description = "Docker container repository based on fedora or CentOS and deliverying main opensource project as container"
keywords = ["home, docker, startx, repository, container, swarm, compose, howto, "]
weight=3
+++
<![end-metadata]-->

# Fedora OS container's

Simple container used for all startx based services and application published in [Dockerhub registry](https://github.com/startxfr/docker-images). 
This container contain updated core OS rpm (kernel, libs,...) as well as usefull tools like pwgen, tar, zip, psmisc, procps, coreutils, findutils, wget

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/fedora) | [Sources](https://github.com/startxfr/docker-images/OS/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------|-----------------------------------------------|


## Available flavours

* `:latest` : Fedora core 23 at this time
* `:23` : Fedora core 23 
* `:22` : Fedora core 22
* `:21` : Fedora core 21
* `:21` : Fedora core 21

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="fedora" startx/fedora` from every docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
fedora:
  image: startx/fedora
  container_name: "os-fedora"
  environment:
    CONTAINER_TYPE: "os"
    CONTAINER_SERVICE: "fedora"
    CONTAINER_INSTANCE: "os-fedora"
```

## Using this image in your own container

You can use this Dockerfile template to start a new prsonalized container based on this container
 ```
FROM startx/fedora:latest
#... your container specifications
CMD ["/bin/run.sh"]
```

## For advanced users

You you want to use this container and code to build and create locally this container. You can follow theses instructions to setup and working environment.

This section will help you if you want to :
* Get latest version of this container OS
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd OS`
2. Build the container using `docker build -t fedora .`
3. Run this container 
  1. Interactively with `docker run -it fedora`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -d fedora`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd OS`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup and behaviour can be read using `docker-compose logs`
