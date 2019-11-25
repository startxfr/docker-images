[![docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Docker-Images Repository Alpine 3

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/alpine3/OS/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=alpine3)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)
 
[![Dockerhub Registry](https://img.shields.io/docker/build/startx/fedora.svg)](https://hub.docker.com/r/startx/fedora) [![Docker Fedora pulls](https://img.shields.io/docker/pulls/startx/fedora)](https://hub.docker.com/r/startx/fedora) [![Docker Repository on Quay](https://quay.io/repository/startx/fedora/status "Docker Repository on Quay")](https://quay.io/repository/startx/fedora)


This project is a collection of application or services containers ready to execute 
or embed your application as part of a building process 
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
 [podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
 [s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md))
or by running it direcly with various containers engines like 
[docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md) or 
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md).  

Each container is provided with various underlying OS version based on 
[CentOS](https://quay.io/repository/startx/centos), 
[Fedora Linux](https://quay.io/repository/startx/fedora), 
[Alpine](https://quay.io/repository/startx/alpine) and 
[UBI](https://quay.io/repository/startx/ubi) distributions. 
[Kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md) and 
[Openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md) friendly, 
they can all be used as a [s2i builder](https://github.com/startxfr/containers-engines/blob/master/S2I.md)
within an openshift cluster.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, services and application you will find in this project will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental services in your applications

## OS, Services and Applications guidelines

| Type                        | Guideline                       | Available                                              | Running sample                                         | Registry                                           |
|-----------------------------|---------------------------------|--------------------------------------------------------|--------------------------------------------------------|----------------------------------------------------|
| **OS**                      | [guide](OS)                     | [OS list](OS#container-flavours)                       | [examples](OS#running-this-image)                      |
| **Services**                | [guide](Services)               | [services list](Services#container-flavours)           | [examples](Services#running-this-image)                |
| Services/**apache**         | [guide](Services/apache)        | [flavours](Services/apache#container-flavours)         | [examples](Services/apache#running-this-image)         | [docker.io](https://hub.docker.com/r/startx/sv-apache) [quay.io](https://quay.io/repository/startx/apache) 
| Services/**couchbase**      | [guide](Services/couchbase)     | [flavours](Services/couchbase#container-flavours)      | [examples](Services/couchbase#running-this-image)      | [docker.io](https://hub.docker.com/r/startx/sv-couchbase) [quay.io](https://quay.io/repository/startx/couchbase) 
| Services/**mariadb**        | [guide](Services/mariadb)       | [flavours](Services/mariadb#container-flavours)        | [examples](Services/mariadb#running-this-image)        | [docker.io](https://hub.docker.com/r/startx/sv-mariadb) [quay.io](https://quay.io/repository/startx/mariadb) 
| Services/**memcache**       | [guide](Services/memcache)      | [flavours](Services/memcache#container-flavours)       | [examples](Services/memcache#running-this-image)       | [docker.io](https://hub.docker.com/r/startx/sv-memcache) [quay.io](https://quay.io/repository/startx/memcache) 
| Services/**mongo**          | [guide](Services/mongo)         | [flavours](Services/mongo#container-flavours)          | [examples](Services/mongo#running-this-image)          | [docker.io](https://hub.docker.com/r/startx/sv-mongo) [quay.io](https://quay.io/repository/startx/mongo) 
| Services/**nodejs**         | [guide](Services/nodejs)        | [flavours](Services/nodejs#container-flavours)         | [examples](Services/nodejs#running-this-image)         | [docker.io](https://hub.docker.com/r/startx/sv-nodejs) [quay.io](https://quay.io/repository/startx/nodejs) 
| Services/**ooconv**         | [guide](Services/ooconv)        | [flavours](Services/ooconv#container-flavours)         | [examples](Services/ooconv#running-this-image)         | [docker.io](https://hub.docker.com/r/startx/sv-ooconv) [quay.io](https://quay.io/repository/startx/ooconv) 
| Services/**php**            | [guide](Services/php)           | [flavours](Services/php#container-flavours)            | [examples](Services/php#running-this-image)            | [docker.io](https://hub.docker.com/r/startx/sv-php) [quay.io](https://quay.io/repository/startx/php) 
| Services/**postgres**       | [guide](Services/postgres)      | [flavours](Services/postgres#container-flavours)       | [examples](Services/postgres#running-this-image)       | [docker.io](https://hub.docker.com/r/startx/sv-postgres) [quay.io](https://quay.io/repository/startx/postgres) 
| **VDI**                     | [guide](VDI)                    | [VDI list](VDI#container-flavours)                     | [examples](VDI#running-this-image)                     | 
| VDI/**chrome**              | [guide](VDI/chrome)             | [flavours](VDI/chrome#container-flavours)              | [examples](VDI/chrome#running-this-image)              | [docker.io](https://hub.docker.com/r/startx/vdi-chrome) [quay.io](https://quay.io/repository/startx/chrome) 
| VDI/**firefox**             | [guide](VDI/firefox)            | [flavours](VDI/firefox#container-flavours)             | [examples](VDI/firefox#running-this-image)             | [docker.io](https://hub.docker.com/r/startx/vdi-firefox) [quay.io](https://quay.io/repository/startx/firefox) 
| **Applications**            | [guide](Applications)           | [applications list](Applications#container-flavours)   | [examples](Applications#running-this-image)            | 
| Applications/**phpmyadmin** | [guide](Applications/phpmyadmin)| [flavours](Applications/phpmyadmin#container-flavours) | [examples](Applications/phpmyadmin#running-this-image) | [docker.io](https://hub.docker.com/r/startx/app-phpmyadmin) [quay.io](https://quay.io/repository/startx/phpmyadmin) 
| Applications/**rockmongo**  | [guide](Applications/rockmongo) | [flavours](Applications/rockmongo#container-flavours)  | [examples](Applications/rockmongo#running-this-image)  | [docker.io](https://hub.docker.com/r/startx/app-rockmongo) [quay.io](https://quay.io/repository/startx/rockmongo) 


## Images flavours

- `latest` based on fedora rawhide [see detail](https://github.com/startxfr/docker-images/tree/master)
- `fc31` based on fedora core 31 [see detail](https://github.com/startxfr/docker-images/tree/fc31)
- `fc30` based on fedora core 30 [see detail](https://github.com/startxfr/docker-images/tree/fc30)
- `fc29` based on fedora core 29 [see detail](https://github.com/startxfr/docker-images/tree/fc29)
- `fc28` based on fedora core 28 [see detail](https://github.com/startxfr/docker-images/tree/fc28)
- `fc27` based on fedora core 27 [see detail](https://github.com/startxfr/docker-images/tree/fc27)
- `fc26` based on fedora core 26 [see detail](https://github.com/startxfr/docker-images/tree/fc26)
- `centos8` based on Centos 8 [see detail](https://github.com/startxfr/docker-images/tree/centos8)
- `centos7` based on Centos 7 [see detail](https://github.com/startxfr/docker-images/tree/centos7)
- `centos6` based on Centos 6 [see detail](https://github.com/startxfr/docker-images/tree/centos6)
- `alpine3` based on Alpine 3.10 [see detail](https://github.com/startxfr/docker-images/tree/alpine3)
- `ubi8` based on RedHat UBI 8 [see detail](https://github.com/startxfr/docker-images/tree/ubi8)


## For advanced users

You you want to use this repository and code to build and create locally theses containers. You can follow theses instructions to setup and working environment.

This section is usefull if you want :
* Get latest version of embedded services, applications and underlying OS
* Enhance container content by adding instruction into container(s) Dockefile before the build process
* Use this set of container and flavour to benchmark application performance

### Setup your working environment (mandatory)

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
 [podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
 [s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
 [dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
 [kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
 [openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

1. **Install docker and docker-compose on your environment** 
  1. Check if you have a running docker daemon using `docker --version` If not try to run it using `sudo docker --daemon`. If docker is not installed, follow [docker installation guidelines](https://docs.docker.com/v1.8/installation/)
  2. Check if you have docker-compose installed using `docker-compose --version`. If docker-compose is not installed, follow [docker-compose installation guidelines](https://docs.docker.com/compose/install/)
  3. Check if you have git installed using `git --version`. If git is not installed, execute `sudo apk --no-cache add git`
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


### sx lib release lifecycle

You can run `sx version` to know witch version of the sx-lib you are running. Older environement may not be updated
and stay stiked to a defined stable release. 

| Release  | Description
|----------|-------------
| 0.95.3   | Updating docker for better diff and merge. Improve doc structures
| 0.93.1   | Unstable release with UBI and centos8 added. Prepare first major release
| 0.40.0   | Stable release with updated images lib packages
| 0.31.3   | Stable release with images fully compatible with OKD 4.0 (s2i, podman)
| 0.31.1   | Adding temporize function into sx lib
| 0.31.0   | Adding support for fedora 31 containers
| 0.4.16   | Adding support for OKD 3.11 (s2i, docker)
| 0.4.10   | Adding build and deploy templates for OCP 3.9
| 0.4.8    | Adding images streams for OCP 3.6
| 0.4.3    | Adding post-build, pre-deploy, post-deploy hooks extentions in code environement
| 0.4.0    | Adding build and run s2i support
| 0.3.0    | Adding support for fedora 30 containers
| 0.2.0    | Adding support for fedora 29 and alpine containers

sx-lib release is defined with the following rules

| Release  | Name  | Description
|----------|-------|------
| x.0.0    | Major | Major change in the sx-lib constitution
| x.x.0    | Minor | Major change in offered docker image flavour (second numeric coresponding to the fedora release counter. ex: Fedora 31 = x.31.x sx-lib release)
| x.x.x    | Push  | Evolution, bugfix or security fix related to the sx-lib or image construction