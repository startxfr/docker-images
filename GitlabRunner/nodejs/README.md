<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker gitlab runner : NodeJS

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/GitlabRunner/nodejs/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-nodejs.svg)](https://hub.docker.com/r/startx/runner-nodejs) [![Docker nodejs pulls](https://img.shields.io/docker/pulls/startx/runner-nodejs)](https://hub.docker.com/r/startx/runner-nodejs) [![Docker Repository on Quay](https://quay.io/repository/startx/nodejs/status "Docker Repository on Quay")](https://quay.io/repository/startx/nodejs)

Startx nodejs is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Nodejs + npm + express webserver and fundamentals modules (nodejs release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Nodejs image in many ways :

- [Docker gitlab runner : NodeJS](#docker-gitlab-runner--nodejs)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Environment variable](#environment-variable)
  - [For advanced users](#for-advanced-users)
    - [Build & run a container using `docker`](#build--run-a-container-using-docker)
    - [Build & run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

## Container flavours

| Docker Hub repository                                                           | Docker-compose                                                                                                      | Fedora distribution                              |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| [`startx/runner-nodejs:latest`](https://hub.docker.com/r/startx/runner-nodejs)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core rawhide + NodeJS v12.4.0 + npm 6.9.0 |
| [`startx/runner-nodejs:32`](https://hub.docker.com/r/startx/runner-nodejs)      | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core 32 + NodeJS v10.15.0                 |
| [`startx/runner-nodejs:30`](https://hub.docker.com/r/startx/runner-nodejs)      | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core 30 + NodeJS v10.15.0                 |
| [`startx/runner-nodejs:29`](https://hub.docker.com/r/startx/runner-nodejs)      | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core 29 + NodeJS v10.16.0 + npm 6.9.0     |
| [`startx/runner-nodejs:28`](https://hub.docker.com/r/startx/runner-nodejs)      | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core 28 + NodeJS v0.10.36                 |
| [`startx/runner-nodejs:27`](https://hub.docker.com/r/startx/runner-nodejs)      | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Fedora core 27 + NodeJS v0.10.36                 |
| [`startx/runner-nodejs:centos8`](https://hub.docker.com/r/startx/runner-nodejs) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Centos 8                                         |
| [`startx/runner-nodejs:centos7`](https://hub.docker.com/r/startx/runner-nodejs) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Centos 7                                         |
| [`startx/runner-nodejs:centos6`](https://hub.docker.com/r/startx/runner-nodejs) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Centos 6                                         |
| [`startx/runner-nodejs:alpine3`](https://hub.docker.com/r/startx/runner-nodejs) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | Alpine 3.10 + NodeJS 8.11.1                      |
| [`startx/runner-nodejs:ubi8`](https://hub.docker.com/r/startx/runner-nodejs)    | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/GitlabRunner/nodejs/docker-compose.yml) | RedHat UBI 8                                     |

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
docker run -it -p 9221:8080 --name="example-nodejs" startx/runner-nodejs
```

- Connect to your local application

```bash
firefox http://localhost:9221
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
nodejs:
  image: startx/runner-nodejs:latest
  container_name: "example-nodejs"
  ports:
    - "9221:8080"
```

- Execute the following command

```bash
docker-compose up -d
docker-compose logs
```

- Connect to your local application

```bash
firefox http://localhost:9221
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/runner-nodejs:latest
#... your container specifications
```

## Environment variable

| Variable   | Type     | Default                | Description                                                    |
| ---------- | -------- | ---------------------- | -------------------------------------------------------------- |
| SX_VERSION | `string` | `latest`               | container version                                              |
| SX_TYPE    | `string` | `service`              | Container family (os, service, application). could be enhanced |
| SX_SERVICE | `string` | `nodejs`               | Define the type of service or application provided             |
| SX_ID      | `auto`   | `startx/runner-nodejs` | Container ID coresponding to the image repository              |
| SX_NAME    | `auto`   | `yes`                  | Container name                                                 |
| SX_SUMMARY | `auto`   | `yes`                  | Container purpose description                                  |
| SX_VERBOSE | `bool`   | `no`                   | Display information about the execution                        |
| SX_DEBUG   | `bool`   | `no`                   | Display debug informations during execution                    |
| APP_PATH   | `string` | `/app`                 | Path to the application                                        |
| LOG_PATH   | `string` | `/var/log/httpd`       | Destination path to the log produced by the webserver          |
| DATA_PATH  | `string` | `/data`                | Destination path to the data manipulated by the application    |
| APP_MAIN   | `string` | `/app/app.js`          | Main application entrypoint                                    |
| SX_S2IDIR  | `string` | `/tmp`                 | Destination path to the application pushed via s2i process     |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/nodejs`
2. Build the container using `docker build -t startx-nodejs .`
3. Run this container
   - Interactively with `docker run -it startx-nodejs`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d -p 9221:8080 startx-nodejs`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/nodejs`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
