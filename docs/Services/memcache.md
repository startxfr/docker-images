<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/sv-memcache.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image MEMCACHE

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/Services/memcache/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-memcache.svg)](https://hub.docker.com/r/startx/sv-memcache) [![Docker memcache pulls](https://img.shields.io/docker/pulls/startx/sv-memcache)](https://hub.docker.com/r/startx/sv-memcache) [![Docker Repository on Quay](https://quay.io/repository/startx/memcache/status "Docker Repository on Quay")](https://quay.io/repository/startx/memcache)

Startx memcache is a base container used for distributed cache published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Memcache SQL server and fundamentals modules (memcache release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Memcache image in many ways :

- [Image MEMCACHE](#image-memcache)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Using this image as Openshift Build image](#using-this-image-as-openshift-build-image)
      - [Openshift images streams](#openshift-images-streams)
      - [Openshift builder template](#openshift-builder-template)
      - [Openshift deploy template](#openshift-deploy-template)
    - [Using this image as S2I builder](#using-this-image-as-s2i-builder)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Environment variable](#environment-variable)
  - [For advanced users](#for-advanced-users)
    - [Build & run a container using `docker`](#build--run-a-container-using-docker)
    - [Build & run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more cache nodes builders and sample on [startx docker images repository](https://gitlab.com/startx1/containers/blob/master)

## Container flavours

| Docker Hub repository                                                       | Content             | Memcache |
| --------------------------------------------------------------------------- | ------------------- | -------- |
| [`startx/sv-memcache:latest`](https://hub.docker.com/r/startx/sv-memcache)  | Fedora core rawhide | 1.6.9    |
| [`startx/sv-memcache:35`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 35      | 1.6.9    |
| [`startx/sv-memcache:34`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 34      | 1.6.9    |
| [`startx/sv-memcache:33`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 33      | 1.6.6    |
| [`startx/sv-memcache:32`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 32      |          |
| [`startx/sv-memcache:31`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 31      | 1.5.17   |
| [`startx/sv-memcache:30`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 30      | 1.5.16   |
| [`startx/sv-memcache:29`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 29      | 1.5.16   |
| [`startx/sv-memcache:28`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 28      | 1.5.16   |
| [`startx/sv-memcache:27`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 27      | 1.5.16   |
| [`startx/sv-memcache:26`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 26      | 1.5.16   |
| [`startx/sv-memcache:23`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 23      |          |
| [`startx/sv-memcache:22`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 22      |          |
| [`startx/sv-memcache:21`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 21      |          |
| [`startx/sv-memcache:20`](https://hub.docker.com/r/startx/sv-memcache)      | Fedora core 20      |          |
| [`startx/sv-memcache:alma8`](https://hub.docker.com/r/startx/sv-memcache)   | Alma 8              | 1.5.22   |
| [`startx/sv-memcache:rocky8`](https://hub.docker.com/r/startx/sv-memcache)  | Rocky 8             | 1.5.22   |
| [`startx/sv-memcache:centos9`](https://hub.docker.com/r/startx/sv-memcache) | Centos 9            | 1.5.22   |
| [`startx/sv-memcache:centos8`](https://hub.docker.com/r/startx/sv-memcache) | Centos 8            | 1.5.22   |
| [`startx/sv-memcache:centos7`](https://hub.docker.com/r/startx/sv-memcache) | Centos 7            | 1.4.15   |
| [`startx/sv-memcache:centos6`](https://hub.docker.com/r/startx/sv-memcache) | Centos 6            | 1.4.4    |
| [`startx/sv-memcache:ubi8`](https://hub.docker.com/r/startx/sv-memcache)    | RedHat UBI 8        | 1.5.22   |
| [`startx/sv-memcache:alpine3`](https://hub.docker.com/r/startx/sv-memcache) | Alpine 3.12         | 1.6.6    |

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
docker run -it -p 9278:11211 --name="example-memcache" startx/sv-memcache
```

- Connect to your local cache node

```bash
echo -e 'stats\r' | nc localhost 11211
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
memcache:
  image: startx/sv-memcache:latest
  container_name: "example-memcache"
```

- Connect to your local cache node

```bash
mysql -h localhost -P 9278
```

- Execute the following command

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
s2i build https://gitlab.com/startx1/containers-example-memcache startx/sv-memcache startx-memcache-sample
docker run --rm -d -p 9278:11211 startx-memcache-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/memcache:latest
#... your container specifications
```

## Environment variable

| Variable   | Type     | Default              | Description                                                    |
| ---------- | -------- | -------------------- | -------------------------------------------------------------- |
| SX_VERSION | `string` | `latest`             | container version                                              |
| SX_TYPE    | `string` | `service`            | Container family (os, service, application). could be enhanced |
| SX_SERVICE | `string` | `memcache`           | Define the type of service or application provided             |
| SX_ID      | `auto`   | `startx/sv-memcache` | Container ID coresponding to the image repository              |
| SX_NAME    | `auto`   | `yes`                | Container name                                                 |
| SX_SUMMARY | `auto`   | `yes`                | Container purpose description                                  |
| SX_VERBOSE | `bool`   | `no`                 | Display information about the execution                        |
| SX_DEBUG   | `bool`   | `no`                 | Display debug informations during execution                    |
| SX_S2IDIR  | `string` | `/tmp`               | Destination path to the application pushed via s2i process     |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

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
