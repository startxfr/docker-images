[![docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Docker-Images Repository [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images)

This project is a collection of application or services containers ready to execute 
or embed your application as part of a building process.  

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution. Kumbernetes and Openshift friendly, they can all be used as a s2i builder
within an openshift cluster.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, services and application you will find in this project will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental services in your applications

## OS, Services and Applications guidelines

| Type                    | Manual                             | Available                                                        | Running sample                                                         | Flavours
|-------------------------|------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------------|-------------------------------------------------------------|
| **OS**                  | [read manual](OS)                  | [read OS list](OS#container-flavours)                            | [see sample code](OS#running-from-dockerhub-registry)                  | [read flavours list](OS#container-flavours)                 |
| **Services**            | [read manual](Services)            | [read services list](Services#container-flavours)                | [see sample code](Services#running-from-dockerhub-registry)            | [read flavours list](Services#container-flavours)           |
| Services/**apache**     | [read manual](Services/apache)     | [read services list](Services/apache#container-flavours)         | [see sample code](Services/apache#running-from-dockerhub-registry)     | [read flavours list](Services/apache#container-flavours)    |
| Services/**couchbase**  | [read manual](Services/couchbase)  | [read services list](Services/couchbase#container-flavours)      | [see sample code](Services/couchbase#running-from-dockerhub-registry)  | [read flavours list](Services/couchbase#container-flavours) |
| Services/**mariadb**    | [read manual](Services/mariadb)    | [read services list](Services/mariadb#container-flavours)        | [see sample code](Services/mariadb#running-from-dockerhub-registry)    | [read flavours list](Services/mariadb#container-flavours)   |
| Services/**memcache**   | [read manual](Services/memcache)   | [read services list](Services/memcache#container-flavours)       | [see sample code](Services/memcache#running-from-dockerhub-registry)   | [read flavours list](Services/memcache#container-flavours)  |
| Services/**mongo**      | [read manual](Services/mongo)      | [read services list](Services/mongo#container-flavours)          | [see sample code](Services/mongo#running-from-dockerhub-registry)      | [read flavours list](Services/mongo#container-flavours)     |
| Services/**nodejs**     | [read manual](Services/nodejs)     | [read services list](Services/nodejs#container-flavours)         | [see sample code](Services/nodejs#running-from-dockerhub-registry)     | [read flavours list](Services/nodejs#container-flavours)    |
| Services/**ooconv**     | [read manual](Services/ooconv)     | [read services list](Services/ooconv#container-flavours)         | [see sample code](Services/ooconv#running-from-dockerhub-registry)     | [read flavours list](Services/ooconv#container-flavours)    |
| Services/**php**        | [read manual](Services/php)        | [read services list](Services/php#container-flavours)            | [see sample code](Services/php#running-from-dockerhub-registry)        | [read flavours list](Services/php#container-flavours)       |
| **Applications**        | [read manual](Applications)        | [read applications list](Applications#container-flavours)        | [see sample code](Applications#running-from-dockerhub-registry)        | [read flavours list](Applications#container-flavours)       |
| Applications/**phpmyadmin** | [read manual](Applications/phpmyadmin) | [read services list](Applications/phpmyadmin#container-flavours) | [see sample code](Applications/phpmyadmin#running-from-dockerhub-registry) | [read flavours list](Applications/phpmyadmin#container-flavours) |
| Applications/**rockmongo**  | [read manual](Applications/rockmongo)  | [read services list](Applications/rockmongo#container-flavours)  | [see sample code](Applications/rockmongo#running-from-dockerhub-registry)  | [read flavours list](Applications/rockmongo#container-flavours)  |


## Images flavours

- `latest` based on fedora rawhide [see detail](https://github.com/startxfr/docker-images/tree/master)
- `fc31` based on fedora core 31 [see detail](https://github.com/startxfr/docker-images/tree/fc31)
- `fc30` based on fedora core 30 [see detail](https://github.com/startxfr/docker-images/tree/fc30)
- `fc29` based on fedora core 29 [see detail](https://github.com/startxfr/docker-images/tree/fc29)
- `fc28` based on fedora core 28 [see detail](https://github.com/startxfr/docker-images/tree/fc28)
- `fc27` based on fedora core 27 [see detail](https://github.com/startxfr/docker-images/tree/fc27)
- `fc26` based on fedora core 26 [see detail](https://github.com/startxfr/docker-images/tree/fc26)
- `centos7` based on Centos 7 [see detail](https://github.com/startxfr/docker-images/tree/centos7)
- `centos6` based on Centos 6 [see detail](https://github.com/startxfr/docker-images/tree/centos6)
- `alpine3` based on Alpine 3.7 [see detail](https://github.com/startxfr/docker-images/tree/alpine3)


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


### sx lib release lifecycle

You can run `sx version` to know witch version of the sx-lib you are running. Older environement may not be updated
and stay stiked to a defined stable release. 

| Release  | Description
|----------|-------------
| 0.31.3   | Stable release with images fully compatible with OKD 4.0 (s2i, podman)
| 0.31.0   | Adding support for fedora 31 containers
| 0.4.16   | Adding support for OKD 3.11 (s2i, docker)
| 0.4.10   | Adding build and deploy templates for OCP 3.9
| 0.4.8    | Adding images streams for OCP 3.6
| 0.4.3    | Adding post-build, pre-deploy, post-deploy hooks extentions in code environement
| 0.4.0    | Adding build and run s2i support
| 0.3.0    | Adding support for fedora 30 containers
| 0.2.0    | Adding support for fedora 29 and alpine containers

sx-lib release is defined with the followng rules

| Release  | Name  | Description
|----------|-------|------
| x.0.0    | Major | Major change in the sx-lib constitution
| x.x.0    | Minor | Major change in offered docker image flavour (second numeric coresponding to the fedora release counter. ex: Fedora 31 = x.31.x sx-lib release)
| x.x.x    | Push  | Evolution, bugfix or security fix related to the sx-lib or image construction