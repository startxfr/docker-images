# Docker OS Images : CentOS 6

Simple container used for all startx based services and applications published in [Dockerhub registry](https://github.com/startxfr/docker-images). 
This container contain updated core OS rpm (kernel, libs,...) as well as usefull tools like pwgen, tar, zip, psmisc, procps, coreutils, findutils, wget

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=centos6)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/centos) | [Sources](https://github.com/startxfr/docker-images/tree/master/OS/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------|-----------------------------------------------|

## Container flavours

| Version    | Docker Hub repository                                                   | Openshift                                   | Centos distribution                         |
|------------|-------------------------------------------------------------------------|---------------------------------------------|---------------------------------------------|
| latest     | [`startx/centos:latest`](https://hub.docker.com/r/startx/centos)        | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-dc.json)        | Centos 7.4 (kernel 3.10.0-693  )        |
| 7          | [`startx/centos:7`](https://hub.docker.com/r/startx/centos)             | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/centos7/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/centos7/OS/openshift-dc.json)        | Centos 7 (kernel 3.10.0-514  )        |
| 6          | [`startx/centos:6`](https://hub.docker.com/r/startx/centos)             | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/centos6/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/centos6/OS/openshift-dc.json)        | Centos 6 (kernel 2.6.32-696  )        |

## Running this image

### Running from dockerhub registry

* with `docker` you can run `docker run -it --name="centos6" startx/centos:6` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```yaml
centos6:
  image: startx/centos:6
  container_name: "os-centos6"
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
 ```bash
s2i build https://github.com/startxfr/docker-images-example-bash startx/centos:6 test-centos6
docker run --rm -i -t test-centos6
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container
 ```
FROM startx/centos:6
#... your container specifications
CMD ["/bin/sx"]
```


## Environment variable

| Variable                  | Type     | Default         | Description                                                              |
|---------------------------|----------|-----------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `latest`        | container version
| SX_TYPE                   | `string` | `OS`            | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `centos`        | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/centos` | Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`           | Container name
| SX_SUMMARY                | `auto`   | `yes`           | Container purpose description


## For advanced users

You you want to use this container and code to build and create locally this container. You can follow theses instructions to setup and working environment.

This section will help you if you want to :
* Get latest version of this container OS
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch centos6`
2. Jump into the container directory with `cd OS`
3. Build the container using `docker build -t centos .`
4. Run this container 
  1. Interactively with `docker run -it centos`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -d centos`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch centos6`
2. Jump into the container directory with `cd OS`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

