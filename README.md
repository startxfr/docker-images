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

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, services and application you will find here will be closer to your favorite distrbution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental services in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## OS, Services and Applications guidelines

| Type             | Manual                      | Available                                                 | Running sample                                                  | Flavours
|------------------|-----------------------------|-----------------------------------------------------------|-----------------------------------------------------------------|------------------------------------------------------|
| **OS**           | [read manual](OS)           | [read OS list](OS#container-flavours)                     | [see sample code](OS#running-from-dockerhub-registry)           | [read flavours list](OS#container-flavours)          |
| **Services**     | [read manual](Services)     | [read services list](Services#container-flavours)         | [see sample code](Services#running-from-dockerhub-registry)     | [read flavours list](Services#container-flavours)    |
| **Applications** | [read manual](Applications) | [read applications list](Applications#container-flavours) | [see sample code](Applications#running-from-dockerhub-registry) | [read flavours list](Applications#container-flavours)|

## For advanced users

You you want to use this repository and code to build and create locally theses containers. You can follow theses instructions to setup and working environment.

This section is usefull if you want :
* Get latest version of embedded services, applications and underlying OS
* Enhance container content by adding instruction into container(s) Dockefile before the build process
* Use this set of container and flavour to benchmark application performance

### Setup your working environment (mandatory)

1. **Install docker and docker-compose on you environment** 
  1. Check if you have a running docker daemon using `docker --version` If not try to run it using `sudo docker --daemon`. If docker is not installed, follow [docker installation guidelines](https://docs.docker.com/v1.8/installation/)
  2. Check if you have docker-compose installed using `docker-compose --version`. If docker-compose is not installed, follow [docker-compose installation guidelines](https://docs.docker.com/compose/install/)
  3. Check if you have git installed using `git --version`. If git is not installed, execute `sudo dnf install -y git`
2. **Copy repository source locally**
  1. Setup a working directory with `mkdir startx-docker-images; cd startx-docker-images;`
  2. Clone source repository with `git clone https://github.com/startxfr/docker-images.git .`


### Build all containers using `docker-compose`

If you want to build and run locally all the images provided in this repository, you can follow this instructions

1. Choose your flavour with `git checkout ≤flavour_name>`. You can use every flavour available in this repository. Default is set to master branch related to the `:latest` flavour
2. Create host directory to store container content with `mkdir /tmp/container`.
3. Start building all containers with `docker-compose build`. You should be on top of your working directory to run this command. It will use the docker-compose.yml file located into this directory.
4. Wait... (could take some time as you are building the complete list of services
5. Run your multi-container with `docker-compose up -d`
6. Look at your containers startup with `docker-compose logs`. You can add a service name to get logs about this specific container. You can also monitor /tmp/container/logs to see logs comming from all containers
7. Monitor containers with `docker-compose ps`.

### Run a single container

### Build & run a container using `docker`

1. Build the container using `docker build -t <image_name> <path_to_Dockerfile>` where *image_name* is the name of your future local image and *path_to_Dockerfile* should point to the targeted service or application directory, not including the Dockefile filename
2. Run this container 
  1. Interactively with `docker run -it <image_name>` where *image_name* is the name of your previously created image name. If you add a second parameter, you can run a particular command instead of the default entrypoint. Could be usefull when you add ` /bin/bash` to get a shell running into the container
  2. As a daemon with `docker run -d <image_name>` where *image_name* is the name of your previously created image name. 


### Build & run a container using `docker-compose`

1. Jump into the container directory you wan to build with `cd <path_to_service>` where *path_to_service* is the targeted service or application directory, not including the docker-compose.yml filename
2. Run this container 
  1. Interactively with `docker-compose up`. You should see container startup logs and escaping this command will stop the container
  2. As a daemon with `docker-compose up -d`. You can look at your container startup and behaviour with `docker-compose logs`
