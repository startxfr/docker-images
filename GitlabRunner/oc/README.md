[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker gitlab runner : Openshift Client

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/GitlabRunner/oc/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-oc.svg)](https://hub.docker.com/r/startx/runner-oc) [![Docker oc pulls](https://img.shields.io/docker/pulls/startx/runner-oc)](https://hub.docker.com/r/startx/runner-oc) [![Docker Repository on Quay](https://quay.io/repository/startx/oc/status "Docker Repository on Quay")](https://quay.io/repository/startx/oc)

Simple container used to build & test openshift and kubernetes scripts, using gitlabCI runner, under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

- `:latest` : Fedora core rawhide + oc + kubectl + tools
- `:fc32` : Fedora core 32 + oc + kubectl + tools
- `:fc31` : Fedora core 31 + oc + kubectl + tools
- `:fc30` : Fedora core 30 + oc + kubectl + tools
- `:fc29` : Fedora core 29 + oc + kubectl + tools
- `:fc28` : Fedora core 28 + oc + kubectl + tools
- `:fc27` : Fedora core 27 + oc + kubectl + tools
- `:centos8` : CentOS 8 + oc + kubectl + tools
- `:centos7` : CentOS 7 + oc + kubectl + tools
- `:centos6` : Centos 6 + oc + kubectl + tools
- `:alpine3` : Alpine 3.12 + oc + kubectl + tools
- `:ubi8` : RedHat UBI 8 + oc + kubectl + tools

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="service-oc" startx/runner-oc` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/runner-oc:latest
  container_name: "service-oc"
  volumes:
    - "/tmp/container/oc/logs:/logs:z"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/runner-oc:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [additional environment variable](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)

| Variable                       | Type   | Mandatory | Description                                                                                           |
| ------------------------------ | ------ | --------- | ----------------------------------------------------------------------------------------------------- |
| <i>base image environement</i> |        |           | [see environment list](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable) |
| HOSTNAME                       | `auto` | `auto`    | Container unique id automatically assigned by docker daemon at startup                                |
| LOG_PATH                       | `auto` | `auto`    | default set to /var/log/oc and used as a volume mountpoint                                          |

## Exposed port

| Port | Description                                           |
| ---- | ----------------------------------------------------- |
| 2002 | network port used to communicate with unoconv service |

## Exposed volumes

| Container directory | Description                                          |
| ------------------- | ---------------------------------------------------- |
| /logs               | log directory used to record container and oc logs |

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/oc`
2. Build the container using `docker build -t runner-oc .`
3. Run this container
4. Interactively with `docker run -p 2002:2002 -v /logs -it runner-oc`. If you add a second parameter (like `/usr/bin/oc`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/usr/bin/oc`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 2002:2002 -v /logs -d runner-oc`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/oc`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
