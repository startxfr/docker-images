<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker OS Images : COUCHBASE on Fedora 31

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/couchbase/)

[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-couchbase.svg)](https://hub.docker.com/r/startx/sv-couchbase) [![Docker couchbase pulls](https://img.shields.io/docker/pulls/startx/sv-couchbase)](https://hub.docker.com/r/startx/sv-couchbase) [![Docker Repository on Quay](https://quay.io/repository/startx/couchbase/status "Docker Repository on Quay")](https://quay.io/repository/startx/couchbase)

Simple container used to deliver distributed and low latency document oriented database
Run [couchbase daemon](https://www.couchbase.org/) under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

Startx couchbase is a base container used for deliver distributed and low latency document oriented database published in [Dockerhub registry](https://hub.docker.com/u/startx)
and [Quay registry](https://quay.io/repository/startx).
This container contain :

- fedora / centos /alpine /ubi operating system
- core OS packages (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` flavour.
- Couchbase NoSQL server and tools (couchbase release depend on the flavour you use, see [container flavours](#container-flavours)
  for more information)

You can use Startx couchbase image in many ways :

- [Docker OS Images : COUCHBASE](#docker-os-images--couchbase)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Running using Openshift](#running-using-openshift)
    - [Using this image as S2I builder](#using-this-image-as-s2i-builder)
  - [Docker-compose in various situations](#docker-compose-in-various-situations)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Testing the service](#testing-the-service)
  - [Environment variable](#environment-variable)
  - [Exposed port](#exposed-port)
  - [Exposed volumes](#exposed-volumes)
  - [Container command](#container-command)
  - [For advanced users](#for-advanced-users)
    - [Build & run a container using `docker`](#build--run-a-container-using-docker)
    - [Build & run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

## Container flavours

| Docker Hub repository                                                         | Content                                      |
| ----------------------------------------------------------------------------- | -------------------------------------------- |
| [`startx/sv-couchbase:latest`](https://hub.docker.com/r/startx/sv-couchbase)  | Fedora rawhide + Couchbase Server 6.0.2-2413 |
| [`startx/sv-couchbase:32`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 32 + Couchbase Server 6.0.2-2413      |
| [`startx/sv-couchbase:31`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 31 + Couchbase Server 6.0.2-2413      |
| [`startx/sv-couchbase:30`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 30 + Couchbase Server 6.0.0           |
| [`startx/sv-couchbase:29`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 29 + Couchbase Server 5.5.0-beta      |
| [`startx/sv-couchbase:28`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 28 + Couchbase Server 4.5.0           |
| [`startx/sv-couchbase:27`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora 27 + Couchbase Server 4.5.0           |
| [`startx/sv-couchbase:26`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora core 26 + couchbase 2.4.17            |
| [`startx/sv-couchbase:23`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora core 23 + couchbase x.x.x             |
| [`startx/sv-couchbase:22`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora core 22 + couchbase x.x.x             |
| [`startx/sv-couchbase:21`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora core 21 + couchbase x.x.x             |
| [`startx/sv-couchbase:20`](https://hub.docker.com/r/startx/sv-couchbase)      | Fedora core 20 + couchbase x.x.x             |
| [`startx/sv-couchbase:centos8`](https://hub.docker.com/r/startx/sv-couchbase) | Centos 8 + Couchbase Server 6.0.0            |
| [`startx/sv-couchbase:centos7`](https://hub.docker.com/r/startx/sv-couchbase) | Centos 7 + Couchbase Server 6.0.0            |
| [`startx/sv-couchbase:centos6`](https://hub.docker.com/r/startx/sv-couchbase) | Centos 6 + couchbase x.x.x                   |
| [`startx/sv-couchbase:ubi8`](https://hub.docker.com/r/startx/sv-couchbase)    | RedHat UBI 8 + Couchbase Server 6.0.0        |

## Running this image

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

### Running using docker

```bash
docker run -it -p 9201:8080 --name="example-couchbase" startx/sv-couchbase
```

- Connect to your local application

```bash
firefox http://localhost:9201
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "fc28-service-couchbase"
  volumes:
    - "/tmp/container/couchbase/logs:/logs:z"
    - "/tmp/container/couchbase/data:/data:z"
```

- Execute the following command

```bash
docker-compose up -d
docker-compose logs
```

- Connect to your local application

```bash
firefox http://localhost:9201
```

### Running using Openshift

- Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-imageStreams.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-imageStreams.yml
```

- Openshift builder template

Openshift cluster administrator can add a build and deploy template to their consumers.
As an administrator, you can import our [openshift builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-template-build.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-template-build.yml
```

You can then build an application

```bash
# create an example project
oc new-project example
# start a new application
oc process -f startx-couchbase-build-template \
    -p APP_NAME=myapp \
| oc create -f -
```

- Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-template-deploy.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/couchbase/openshift-template-deploy.yml
```

You can then deploy an application

```bash
# create a example project
oc new-project example
# start a new application
oc process -f startx-couchbase-deploy-template \
    -p APP_NAME=myapp \
| oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image.

```bash
s2i build https://github.com/startxfr/docker-images-example-couchbase startx/sv-couchbase test-couchbase
docker run --rm -i -t test-couchbase
```

## Docker-compose in various situations

- sample docker-compose.yml linked to host port 1000

```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "service-couchbase-fc28"
  ports:
    - "1000:11211"
```

- sample docker-compose.yml with port exposed only to linked services

```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "service-couchbase-fc28"
  expose:
    - "11211"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM startx/sv-couchbase:fc28
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Testing the service

access to the running couchbase daemon with `telnet localhost 11211; stats`. Change port and hostname according to your current configuration

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [predefined environment variable](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)

| Variable                       | Type     | Mandatory             | Description                                                                                           |
| ------------------------------ | -------- | --------------------- | ----------------------------------------------------------------------------------------------------- |
| <i>base image environement</i> |          |                       | [see environment list](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable) |
| SX_VERSION                     | `string` | `latest`              | container version                                                                                     |
| SX_TYPE                        | `string` | `service`             | Container family (os, service, application). could be enhanced                                        |
| SX_SERVICE                     | `string` | `couchbase`           | Define the type of service or application provided                                                    |
| SX_ID                          | `auto`   | `startx/sv-couchbase` | Container ID coresponding to the image repository                                                     |
| SX_NAME                        | `auto`   | `yes`                 | Container name                                                                                        |
| SX_SUMMARY                     | `auto`   | `yes`                 | Container purpose description                                                                         |
| SX_VERBOSE                     | `bool`   | `no`                  | Display information about the execution                                                               |
| SX_DEBUG                       | `bool`   | `no`                  | Display debug informations during execution                                                           |
| APP_PATH                       | `string` | `/app`                | Path to the application                                                                               |
| APP_PORT                       | `string` | `8080`                | Port to the application                                                                               |
| LOG_PATH                       | `string` | `/var/log/httpd`      | Destination path to the log produced by the webserver                                                 |
| SX_S2IDIR                      | `string` | `/tmp`                | Destination path to the application pushed via s2i process                                            |

## Exposed port

| Port  | Description                                                 |
| ----- | ----------------------------------------------------------- |
| 11211 | standard couchbase network port used for key/value recovery |

## Exposed volumes

| Container directory | Description                                                                      |
| ------------------- | -------------------------------------------------------------------------------- |
| /logs               | log directory used to record container and couchbase logs                        |
| /data               | data directory served by couchbase. If empty will be filled with app on startup. |

## Container command

| Variable    | Description                                        |
| ----------- | -------------------------------------------------- |
| assemble    | Execute the build script on \$APP_PATH application |
| post-build  | Execute the post-build script                      |
| pre-deploy  | Execute the pre-deployment script                  |
| post-deploy | Execute the post-deployment script                 |
| run         | Start the application                              |
| isLive      | Execute the liveness-probe script                  |
| isReady     | Execute the readyness-probe script                 |
| info        | Get information about the sx-couchbase script      |
| usage       | Get the usage message                              |
| version     | Get information about the sx-couchbase version     |

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/couchbase`
2. Build the container using `docker build -t sv-couchbase .`
3. Run this container
4. Interactively with `docker run -p 11211:11211 -v /logs -it sv-couchbase`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 11211:11211 -v /logs -d sv-couchbase`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/couchbase`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
