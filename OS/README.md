[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : FEDORA 30

Simple container used for all startx based services and applications published in [Dockerhub registry](https://github.com/startxfr/docker-images). 
This container contain updated core OS rpm (kernel, libs,...) as well as usefull tools like pwgen, tar, zip, psmisc, procps, coreutils, findutils, wget

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/fedora.svg)](https://hub.docker.com/r/startx/fedora) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/OS/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Container flavours

| Version    | Docker Hub repository                                             | Openshift                                   | Fedora distribution                         |
|------------|-------------------------------------------------------------------|---------------------------------------------|---------------------------------------------|
| latest     | [`startx/fedora:latest`](https://hub.docker.com/r/startx/fedora)  | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 30 (kernel 5.0  + Gnome 2.32  )      |
| 30         | [`startx/fedora:30`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 30 (kernel 4.20 + Gnome 2.32  )      |
| 29         | [`startx/fedora:29`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 29 (kernel 4.18 + Gnome 2.30  )      |
| 28         | [`startx/fedora:28`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 28 (kernel 4.17 + Gnome 2.28  )      |
| 27         | [`startx/fedora:27`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 27 (kernel 4.13 + Gnome 2.26  )      |
| 26         | [`startx/fedora:26`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)        | Fedora 26 (kernel 4.11 + Gnome 3.24  )      |
| 23         | [`startx/fedora:23`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                             | Fedora 23 (kernel 4.2 + GNU 3.18  )         |
| 22         | [`startx/fedora:22`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                             | Fedora 22 (kernel 4.0 + GNU 3.16  )         |
| 21         | [`startx/fedora:21`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                             | Fedora 21 (kernel 3.16 + GNU 3.14  )        |
| 20         | [`startx/fedora:20`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                             | Fedora 20 (kernel 3.11 + GNU 3.10  )        |

## Running this image

### Running using docker

```bash
docker run -it --name="fedora30" startx/fedora:30
```

### Running using docker-compose

* Create a docker-compose.yml file with the following content
```yaml
fedora:
  image: startx/fedora:30
  container_name: "os-fedora30"
```
* Execute the following command
```bash
docker-compose up -d
docker-compose logs
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template.json
oc process startx-os-fedora-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.json
oc process startx-os-fedora-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image
```bash
# With your current directory application code
s2i build . startx/fedora:30 startx-bash-myapp
docker run --rm -i -t startx-bash-myapp
# With startx application sample code repository
s2i build https://github.com/startxfr/docker-images-example-bash startx/fedora:30 startx-bash-sample
docker run --rm -i -t startx-bash-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/fedora:30
#... your container specifications
```

## Environment variable

| Variable                  | Type     | Default         | Description                                                              |
|---------------------------|----------|-----------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `30`        | container version
| SX_TYPE                   | `string` | `OS`            | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `fedora`        | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/fedora` | Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`           | Container name
| SX_SUMMARY                | `auto`   | `yes`           | Container purpose description
| SX_VERBOSE                | `bool`   | `no`            | Display information about the execution
| SX_DEBUG                  | `bool`   | `no`            | Display debug informations during execution
| APP_PATH                  | `string` | `/app`          | Path to the application
| SX_S2IDIR                 | `string` | `/tmp`          | Destination path to the application pushed via s2i process

## For advanced users

You you want to use this container and code to build and create locally this container. You can follow theses instructions to setup and working environment.

This section will help you if you want to :
* Get latest version of this container OS
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc30`
2. Jump into the container directory with `cd OS`
3. Build the container using `docker build -t fedora .`
4. Run this container 
  1. Interactively with `docker run -it fedora`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -d fedora`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc30`
2. Jump into the container directory with `cd OS`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

