<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/runner-nodejs.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image runner-NodeJS

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/GitlabRunner/nodejs/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-nodejs.svg)](https://hub.docker.com/r/startx/runner-nodejs) [![Docker nodejs pulls](https://img.shields.io/docker/pulls/startx/runner-nodejs)](https://hub.docker.com/r/startx/runner-nodejs) [![Docker Repository on Quay](https://quay.io/repository/startx/nodejs/status "Docker Repository on Quay")](https://quay.io/repository/startx/nodejs)

Startx nodejs is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Nodejs + npm + express webserver and fundamentals modules (nodejs release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Nodejs image in many ways :

- [Image runner-NodeJS](#image-runner-nodejs)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Environment variable](#environment-variable)
  - [Exposed port](#exposed-port)
  - [Exposed volumes](#exposed-volumes)
  - [Testing the service](#testing-the-service)
  - [For advanced users](#for-advanced-users)
    - [Build \& run a container using `docker`](#build--run-a-container-using-docker)
    - [Build \& run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://gitlab.com/startx1/containers/blob/master)

## Container flavours

| Docker Hub repository                                                           | Content             | NodeJS  | NPM     | Make  |
| ------------------------------------------------------------------------------- | ------------------- | ------- | ------- | ----- |
| [`startx/runner-nodejs:latest`](https://hub.docker.com/r/startx/runner-nodejs)  | Fedora core rawhide | 14.17.0 | 6.14.13 | 4.3   |
| [`startx/runner-nodejs:35`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 35      | 14.17.0 | 6.14.13 | 4.3   |
| [`startx/runner-nodejs:34`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 34      | 14.17.0 | 6.14.13 | 4.3   |
| [`startx/runner-nodejs:33`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 33      | 14.16.1 | 6.14.12 | 4.3   |
| [`startx/runner-nodejs:32`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 32      | 12.4.0  |         |       |
| [`startx/runner-nodejs:31`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 31      | 12.19.0 | 6.14.8  | 4.2.1 |
| [`startx/runner-nodejs:30`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 30      | 10.15.0 |         |       |
| [`startx/runner-nodejs:29`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 29      | 10.16.0 |         |       |
| [`startx/runner-nodejs:28`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 28      | 0.10.36 |         |       |
| [`startx/runner-nodejs:27`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 27      | 0.10.36 |         |       |
| [`startx/runner-nodejs:26`](https://hub.docker.com/r/startx/runner-nodejs)      | Fedora core 26      |         |         |       |
| [`startx/runner-nodejs:alma8`](https://hub.docker.com/r/startx/runner-nodejs)   | Alma 8              | 10.24.0 | 6.14.11 | 4.2.1 |
| [`startx/runner-nodejs:rocky8`](https://hub.docker.com/r/startx/runner-nodejs)  | Rocky 8             | 10.24.0 | 6.14.11 | 4.2.1 |
| [`startx/runner-nodejs:centos9`](https://hub.docker.com/r/startx/runner-nodejs) | Centos 9           | 10.24.0 | 6.14.11 | 4.2.1 |
| [`startx/runner-nodejs:centos8`](https://hub.docker.com/r/startx/runner-nodejs) | Centos 8            | 10.24.0 | 6.14.11 | 4.2.1 |
| [`startx/runner-nodejs:centos7`](https://hub.docker.com/r/startx/runner-nodejs) | Centos 7            | 3.10.10 | 6.17.1  | 3.82  |
| [`startx/runner-nodejs:ubi8`](https://hub.docker.com/r/startx/runner-nodejs)    | RedHat UBI 8        |         |         |       |
| [`startx/runner-nodejs:alpine3`](https://hub.docker.com/r/startx/runner-nodejs) | Alpine 3.12         | 12.22.1 | 6.14.12 | 4.3   |

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

```nodejs
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

This container is based on [startx nodejs container](https://hub.docker.com/r/startx/sv-nodejs) who came with
some [additional environment variable](https://docker-images.readthedocs.io/en/latest/Services/nodejs/#environment-variable)

| Variable                       | Type     | Default                | Description                                                                                                  |
| ------------------------------ | -------- | ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| <i>base image environement</i> |          |                        | [see environment list](https://docker-images.readthedocs.io/en/latest/Services/nodejs/#environment-variable) |
| SX_VERSION                     | `string` | `latest`               | container version                                                                                            |
| SX_TYPE                        | `string` | `service`              | Container family (os, service, application). could be enhanced                                               |
| SX_SERVICE                     | `string` | `nodejs`               | Define the type of service or application provided                                                           |
| SX_ID                          | `auto`   | `startx/runner-nodejs` | Container ID coresponding to the image repository                                                            |
| SX_NAME                        | `auto`   | `yes`                  | Container name                                                                                               |
| SX_SUMMARY                     | `auto`   | `yes`                  | Container purpose description                                                                                |
| SX_VERBOSE                     | `bool`   | `no`                   | Display information about the execution                                                                      |
| SX_DEBUG                       | `bool`   | `no`                   | Display debug informations during execution                                                                  |
| APP_PATH                       | `string` | `/app`                 | Path to the application                                                                                      |
| LOG_PATH                       | `string` | `/var/log/httpd`       | Destination path to the log produced by the webserver                                                        |
| DATA_PATH                      | `string` | `/data`                | Destination path to the data manipulated by the application                                                  |
| APP_MAIN                       | `string` | `/app/app.js`          | Main application entrypoint                                                                                  |
| SX_S2IDIR                      | `string` | `/tmp`                 | Destination path to the application pushed via s2i process                                                   |

## Exposed port

| Port | Description                                                     |
| ---- | --------------------------------------------------------------- |
| 8080 | network port used to communicate with nodejs service using http |

## Exposed volumes

| Container directory | Description                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------- |
| /var/log/httpd      | log directory used to record container and nodejs logs                                   |
| /data               | Destination path to the data manipulated by the application                              |
| /app                | Main application components (already defined, use volume to overwrite full nodejs stack) |

## Testing the service

access to the running nodejs service with http client `curl -k -I http://localhost:9221`. Change port and hostname according to your current configuration

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to setup a working environment.

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
