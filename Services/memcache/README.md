<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker OS Images : MEMCACHE on Fedora 30

Startx memcache is a base container used for distributed cache published in [Dockerhub registry](https://hub.docker.com/u/startx). 
This container contain :
- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Memcache SQL server and fundamentals modules (memcache release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Memcache image in many ways :
- Build container based image cache node with [s2i builder technology](#using-this-image-as-s2i-builder)
- Build container based image cache node with [openshift builder image capacity](#using-this-image-as-openshift-build-image)
- Build personalized base image [with docker tools](#using-this-image-as-base-container)
- Run as simple and lightweiht cache node [with docker daemon](#running-using-docker)
- Run a minimal container cache node  [with docker-compose](#running-using-docker-compose)
- Enrich you openshift service catalog with [flavoured images streams](#openshift-images-streams)
- Add to your openshift service catalog a [cache node builder template](#openshift-builder-template)
- Add to your openshift service catalog a [cache node deployement template](#openshift-deploy-template)

See more cache nodes builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-memcache.svg)](https://hub.docker.com/r/startx/sv-memcache) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc28)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc28/Services/memcache/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Container flavours

| Docker Hub repository                                                   | Openshift                                                                                                                                                                                                                                                                                                                                     | Docker-compose                                                                                     | Fedora distribution                        
|-------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|---------------------
| [`startx/sv-memcache:latest`](https://hub.docker.com/r/startx/sv-memcache)  | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core rawhide + memcached 1.5.16
| [`startx/sv-memcache:31`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 31 + memcached 1.5.16
| [`startx/sv-memcache:30`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 30 + memcached 1.5.16
| [`startx/sv-memcache:29`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 29 + memcached 1.5.16
| [`startx/sv-memcache:28`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 28 + memcached 1.5.16
| [`startx/sv-memcache:27`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 27 + memcached 1.5.16
| [`startx/sv-memcache:26`](https://hub.docker.com/r/startx/sv-memcache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Fedora core 26 + memcached 1.5.16
| [`startx/sv-memcache:23`](https://hub.docker.com/r/startx/sv-memcache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 23
| [`startx/sv-memcache:22`](https://hub.docker.com/r/startx/sv-memcache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 22
| [`startx/sv-memcache:21`](https://hub.docker.com/r/startx/sv-memcache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 21
| [`startx/sv-memcache:20`](https://hub.docker.com/r/startx/sv-memcache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 20
| [`startx/sv-memcache:centos8`](https://hub.docker.com/r/startx/sv-memcache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Centos 8
| [`startx/sv-memcache:centos7`](https://hub.docker.com/r/startx/sv-memcache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Centos 7
| [`startx/sv-memcache:centos6`](https://hub.docker.com/r/startx/sv-memcache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Centos 6
| [`startx/sv-memcache:alpine3`](https://hub.docker.com/r/startx/sv-memcache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | Alpine 3.10 + memcached 1.5.16
| [`startx/sv-memcache:ubi8`](https://hub.docker.com/r/startx/sv-memcache)    | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/docker-compose.yml) | RedHat UBI 8

## Running this image

### Running using docker

```bash
docker run -it -p 9278:11211 --name="example-memcache" startx/sv-memcache
```

* Connect to your local cache node
```bash
echo -e 'stats\r' | nc localhost 11211
```

### Running using docker-compose

* Create a `docker-compose.yml` file with the following content
```yaml
memcache:
  image: startx/sv-memcache:latest
  container_name: "example-memcache"
```

* Connect to your local cache node
```bash
mysql -h localhost -P 9278
```

* Execute the following command
```bash
docker-compose up -d
docker-compose logs
```

### Using this image as Openshift Build image

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml) 
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own 
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-imageStreams.yml
```

#### Openshift builder template

Openshift cluster administrator can add 2 build and deploy template to their consumers.
As an administrator, you can import our [openshift ephemeral builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml) 
as well as our [openshift persistent builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build-persistent.yml) 
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own 
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this ephemeral template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-build.yml
```

You can then build a cache node
```bash
# create an example project
oc new-project example
# start a new ephemeral cache node
oc process -f startx-memcache-build-template \
    -p APP_NAME=mycache-e \
| oc create -f -
```

#### Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml) 
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own 
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this ephemeral template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/memcache/openshift-template-deploy.yml
```

You can then deploy a cache node
```bash
# create a example project
oc new-project example
# start a new ephemeral cache node
oc process -f startx-memcache-deploy-template \
    -p APP_NAME=mycache-e \
| oc create -f -
```

### Using this image as S2I builder

Then you can use this image as an s2i builder image
```bash
# With your current directory cache node code
s2i build . startx/sv-memcache:latest startx-memcache-mycache
docker run --rm -d -p 9278:11211 startx-memcache-mycache
# With startx cache node sample code repository
s2i build https://github.com/startxfr/docker-images-example-memcache startx/sv-memcache startx-memcache-sample
docker run --rm -d -p 9278:11211 startx-memcache-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-memcache:fc28
#... your container specifications
```

## Environment variable

| Variable                  | Type     | Default            | Description                                                              |
|---------------------------|----------|--------------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `latest`           | container version
| SX_TYPE                   | `string` | `service`          | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `memcache`          | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/sv-memcache`| Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`              | Container name
| SX_SUMMARY                | `auto`   | `yes`              | Container purpose description
| SX_VERBOSE                | `bool`   | `no`               | Display information about the execution
| SX_DEBUG                  | `bool`   | `no`               | Display debug informations during execution
| SX_S2IDIR                 | `string` | `/tmp`             | Destination path to the application pushed via s2i process

## For advanced users

You can contribute or start this container initiative locally. 
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :
* Get latest version of this container Service source code
* Enhance and share your container improvement by adding instruction in Dockefile


### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/memcache`
2. Build the container using `docker build -t startx-memcache .`
3. Run this container 
   - Interactively with `docker run -it startx-memcache`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
   - As a daemon with `docker run -d -p 9278:11211 startx-memcache`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/memcache`
2. Run this container 
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

