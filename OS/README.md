# Docker OS Images : ALPINE 3.7

Simple container used for all startx based services and applications published in [Dockerhub registry](https://github.com/startxfr/docker-images). 
This container contain updated core OS rpm (kernel, libs,...) as well as usefull tools like pwgen, tar, zip, psmisc, procps, coreutils, findutils, wget

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=alpine3)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/alpine) | [Sources](https://github.com/startxfr/docker-images/tree/alpine3/OS/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------|-----------------------------------------------|

## Container flavours

| Version    | Docker Hub repository                                                   | Openshift                                   | Fedora distribution                         |
|------------|-------------------------------------------------------------------------|---------------------------------------------|---------------------------------------------|
| latest     | [`startx/fedora:latest`](https://hub.docker.com/r/startx/fedora)        | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-dc.json)        | Fedora 28 (kernel 4.14 + GNU 2.23  )        |
| 28         | [`startx/fedora:28`](https://hub.docker.com/r/startx/fedora)            | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/fc27/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/fc27/OS/openshift-dc.json)        | Fedora 27 (kernel 4.11 + GNU 2.21  )        |
| 27         | [`startx/fedora:27`](https://hub.docker.com/r/startx/fedora)            | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/fc27/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/fc27/OS/openshift-dc.json)        | Fedora 27 (kernel 4.11 + GNU 2.21  )        |
| 26         | [`startx/fedora:26`](https://hub.docker.com/r/startx/fedora)            | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/fc26/OS/openshift-is.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/fc26/OS/openshift-dc.json)        | Fedora 26 (kernel 4.09 + GNU 2.20  )        |
| 23         | [`startx/fedora:23`](https://hub.docker.com/r/startx/fedora)            | **N/A**                                                                                                                                                                                                             | Fedora 23 (kernel 4.2 + GNU 3.18  )         |
| 22         | [`startx/fedora:22`](https://hub.docker.com/r/startx/fedora)            | **N/A**                                                                                                                                                                                                             | Fedora 22 (kernel 4.0 + GNU 3.16  )         |
| 21         | [`startx/fedora:21`](https://hub.docker.com/r/startx/fedora)            | **N/A**                                                                                                                                                                                                             | Fedora 21 (kernel 3.16 + GNU 3.14  )        |
| 20         | [`startx/fedora:20`](https://hub.docker.com/r/startx/fedora)            | **N/A**                                                                                                                                                                                                             | Fedora 20 (kernel 3.11 + GNU 3.10  )        |

## Running this image

### Running from dockerhub registry

* with `docker` you can run `docker run -it --name="alpine3" startx/alpine:3` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```yaml
alpine:
  image: startx/alpine:3
  container_name: "os-alpine3"
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
 ```bash
s2i build https://github.com/startxfr/docker-images-example-bash startx/alpine:3 test-alpine3
docker run --rm -i -t test-alpine3
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container
 ```
FROM startx/alpine:3
#... your container specifications
CMD ["/bin/sx"]
```


## Environment variable

| Variable                  | Type     | Default         | Description                                                              |
|---------------------------|----------|-----------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `3.7`           | container version
| SX_TYPE                   | `string` | `OS`            | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `alpine`        | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/alpine` | Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`           | Container name
| SX_SUMMARY                | `auto`   | `yes`           | Container purpose description


## For advanced users

You you want to use this container and code to build and create locally this container. You can follow theses instructions to setup and working environment.

This section will help you if you want to :
* Get latest version of this container OS
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch alpine3`
2. Jump into the container directory with `cd OS`
3. Build the container using `docker build -t alpine .`
4. Run this container 
  1. Interactively with `docker run -it alpine`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -d alpine`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch alpine3`
2. Jump into the container directory with `cd OS`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

