[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true)](https://gitlab.com/startx1/containers)

# Image runner-Bash

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/GitlabRunner/bash/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-bash.svg)](https://hub.docker.com/r/startx/runner-bash) [![Docker bash pulls](https://img.shields.io/docker/pulls/startx/runner-bash)](https://hub.docker.com/r/startx/runner-bash) [![Docker Repository on Quay](https://quay.io/repository/startx/bash/status "Docker Repository on Quay")](https://quay.io/repository/startx/bash)

Simple container used to build & test bash scripts, using gitlabCI runner, under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

| Docker Hub repository                                                       | Content             | Bash   | Make  |
| --------------------------------------------------------------------------- | ------------------- | ------ | ----- |
| [`startx/runner-bash:latest`](https://hub.docker.com/r/startx/runner-bash)  | Fedora core rawhide | 5.1.4  | 4.3   |
| [`startx/runner-bash:35`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 35      | 5.1.4  | 4.3   |
| [`startx/runner-bash:34`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 34      | 5.1.4  | 4.3   |
| [`startx/runner-bash:33`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 33      | 5.0.17 | 4.3   |
| [`startx/runner-bash:32`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 32      |        |       |
| [`startx/runner-bash:31`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 31      | 5.0.17 | 4.2.1 |
| [`startx/runner-bash:30`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 30      |        |       |
| [`startx/runner-bash:29`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 29      |        |       |
| [`startx/runner-bash:28`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 28      |        |       |
| [`startx/runner-bash:27`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 27      |        |       |
| [`startx/runner-bash:26`](https://hub.docker.com/r/startx/runner-bash)      | Fedora core 26      |        |       |
| [`startx/runner-bash:alma8`](https://hub.docker.com/r/startx/runner-bash)   | Alma 8              | 4.4.19 | 4.2.1 |
| [`startx/runner-bash:rocky8`](https://hub.docker.com/r/startx/runner-bash)  | Rocky 8             | 4.4.19 | 4.2.1 |
| [`startx/runner-bash:centos8`](https://hub.docker.com/r/startx/runner-bash) | Centos 8            | 4.4.19 | 4.2.1 |
| [`startx/runner-bash:centos7`](https://hub.docker.com/r/startx/runner-bash) | Centos 7            | 4.2.46 | 3.82  |
| [`startx/runner-bash:ubi8`](https://hub.docker.com/r/startx/runner-bash)    | RedHat UBI 8        | 4.4.20 | 4.3   |
| [`startx/runner-bash:alpine3`](https://hub.docker.com/r/startx/runner-bash) | Alpine 3.12         | 5.0.17 | 4.3   |

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="service-bash" startx/runner-bash` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/runner-bash:latest
  container_name: "service-bash"
  volumes:
    - "/tmp/container/bash/logs:/logs:z"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/runner-bash:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [additional environment variable](https://gitlab.com/startx1/containers/tree/master/OS#environment-variable)

| Variable                       | Type   | Mandatory | Description                                                                                       |
| ------------------------------ | ------ | --------- | ------------------------------------------------------------------------------------------------- |
| <i>base image environement</i> |        |           | [see environment list](https://gitlab.com/startx1/containers/tree/master/OS#environment-variable) |
| HOSTNAME                       | `auto` | `auto`    | Container unique id automatically assigned by docker daemon at startup                            |
| LOG_PATH                       | `auto` | `auto`    | default set to /var/log/bash and used as a volume mountpoint                                      |

## Exposed port

| Port | Description                                           |
| ---- | ----------------------------------------------------- |
| 2002 | network port used to communicate with unoconv service |

## Exposed volumes

| Container directory | Description                                          |
| ------------------- | ---------------------------------------------------- |
| /logs               | log directory used to record container and bash logs |

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/bash`
2. Build the container using `docker build -t runner-bash .`
3. Run this container
4. Interactively with `docker run -p 2002:2002 -v /logs -it runner-bash`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 2002:2002 -v /logs -d runner-bash`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/bash`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
