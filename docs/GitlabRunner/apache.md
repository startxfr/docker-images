<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker gitlab runner : Apache

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/GitlabRunner/apache/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-apache.svg)](https://hub.docker.com/r/startx/runner-apache) [![Docker apache pulls](https://img.shields.io/docker/pulls/startx/runner-apache)](https://hub.docker.com/r/startx/runner-apache) [![Docker Repository on Quay](https://quay.io/repository/startx/apache/status "Docker Repository on Quay")](https://quay.io/repository/startx/apache)

Startx apache is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Apache webserver and fundamentals modules (apache release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Apache image in many ways :

- Build personalized base image [with docker tools](#using-this-image-as-base-container)
- Run as simple and lightweiht webserver [with docker daemon](#running-using-docker)
- Run a minimal container app [with docker-compose](#running-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

## Container flavours

| Docker Hub repository                                                           | Content             | Ansible | Apache |
| ------------------------------------------------------------------------------- | ------------------- | ------- | ------ |
| [`startx/runner-apache:latest`](https://hub.docker.com/r/startx/runner-apache)  | Fedora core rawhide |         | 2.4.46 |
| [`startx/runner-apache:34`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 34      |         |        |
| [`startx/runner-apache:33`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 33      |         |        |
| [`startx/runner-apache:32`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 32      |         | 2.4.39 |
| [`startx/runner-apache:31`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 31      |         | 2.4.39 |
| [`startx/runner-apache:30`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 30      |         | 2.4.39 |
| [`startx/runner-apache:29`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 29      |         | 2.4.39 |
| [`startx/runner-apache:28`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 28      |         | 2.4.17 |
| [`startx/runner-apache:27`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 27      |         | 2.4.17 |
| [`startx/runner-apache:26`](https://hub.docker.com/r/startx/runner-apache)      | Fedora core 26      |         | 2.4.17 |
| [`startx/runner-apache:centos8`](https://hub.docker.com/r/startx/runner-apache) | Centos 8            |         |        |
| [`startx/runner-apache:centos7`](https://hub.docker.com/r/startx/runner-apache) | Centos 7            |         |        |
| [`startx/runner-apache:centos6`](https://hub.docker.com/r/startx/runner-apache) | Centos 6            |         |        |
| [`startx/runner-apache:ubi8`](https://hub.docker.com/r/startx/runner-apache)    | RedHat UBI 8        |         | 2.4.33 |
| [`startx/runner-apache:alpine3`](https://hub.docker.com/r/startx/runner-apache) | Alpine 3.12         |         | 2.4.33 |

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
docker run -it -p 9201:8080 --name="example-apache" startx/runner-apache
```

- Connect to your local application

```bash
firefox http://localhost:9201
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
apache:
  image: startx/runner-apache:latest
  container_name: "example-apache"
  ports:
    - "9201:8080"
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

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/runner-apache:latest
#... your container specifications
```

## Environment variable

| Variable   | Type     | Default                | Description                                                    |
| ---------- | -------- | ---------------------- | -------------------------------------------------------------- |
| SX_VERSION | `string` | `latest`               | container version                                              |
| SX_TYPE    | `string` | `service`              | Container family (os, service, application). could be enhanced |
| SX_SERVICE | `string` | `apache`               | Define the type of service or application provided             |
| SX_ID      | `auto`   | `startx/runner-apache` | Container ID coresponding to the image repository              |
| SX_NAME    | `auto`   | `yes`                  | Container name                                                 |
| SX_SUMMARY | `auto`   | `yes`                  | Container purpose description                                  |
| SX_VERBOSE | `bool`   | `no`                   | Display information about the execution                        |
| SX_DEBUG   | `bool`   | `no`                   | Display debug informations during execution                    |
| APP_PATH   | `string` | `/app`                 | Path to the application                                        |
| APP_PORT   | `string` | `8080`                 | Port to the application                                        |
| LOG_PATH   | `string` | `/var/log/httpd`       | Destination path to the log produced by the webserver          |
| SX_S2IDIR  | `string` | `/tmp`                 | Destination path to the application pushed via s2i process     |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/apache`
2. Build the container using `docker build -t startx-apache .`
3. Run this container
   - Interactively with `docker run -it startx-apache`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d -p 9201:8080 startx-apache`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/apache`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
