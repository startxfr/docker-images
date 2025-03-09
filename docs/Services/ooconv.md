<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/sv-ooconv.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image OOCONV

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/Services/ooconv/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-ooconv.svg)](https://hub.docker.com/r/startx/sv-ooconv) [![Docker ooconv pulls](https://img.shields.io/docker/pulls/startx/sv-ooconv)](https://hub.docker.com/r/startx/sv-ooconv) [![Docker Repository on Quay](https://quay.io/repository/startx/ooconv/status "Docker Repository on Quay")](https://quay.io/repository/startx/ooconv)

Simple container used to document convertion and manipulation tools
Run [libreoffice](https://www.libreoffice.org/) as a daemon using [dagwieers unoconv](https://github.com/dagwieers/unoconv) under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

| Docker Hub repository                                                   | Content             | Libreoffice | Unoconv |
| ----------------------------------------------------------------------- | ------------------- | ----------- | ------- |
| [`startx/sv-ooconv:latest`](https://hub.docker.com/r/startx/sv-ooconv)  | Fedora core rawhide | 7.1.3.2     | 0.7     |
| [`startx/sv-ooconv:35`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 35      | 7.1.3.2     | 0.7     |
| [`startx/sv-ooconv:34`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 34      | 7.1.3.2     | 0.7     |
| [`startx/sv-ooconv:33`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 33      | 7.0.5.2     | 0.7     |
| [`startx/sv-ooconv:32`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 32      | 6.2.4.2.0   | 0.7     |
| [`startx/sv-ooconv:31`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 31      | 6.3.6.2     | 0.7     |
| [`startx/sv-ooconv:30`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 30      | 6.1.6.3     | 0.7     |
| [`startx/sv-ooconv:29`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 29      | 6.1.6.3     | 0.7     |
| [`startx/sv-ooconv:28`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 28      | 5.0.3.2     | 0.7     |
| [`startx/sv-ooconv:27`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 27      | 5.0.3.2     | 0.7     |
| [`startx/sv-ooconv:26`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 26      | 5.0.3.2     | 0.7     |
| [`startx/sv-ooconv:23`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 23      | 5.0.3.2     | 0.7     |
| [`startx/sv-ooconv:22`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 22      |             |         |
| [`startx/sv-ooconv:21`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 21      |             |         |
| [`startx/sv-ooconv:20`](https://hub.docker.com/r/startx/sv-ooconv)      | Fedora core 20      |             |         |
| [`startx/sv-ooconv:alma8`](https://hub.docker.com/r/startx/sv-ooconv)   | Alma 8              | 6.3.6.2     | 0.7     |
| [`startx/sv-ooconv:rocky8`](https://hub.docker.com/r/startx/sv-ooconv)  | Rocky 8             | 6.3.6.2     | 0.7     |
| [`startx/sv-ooconv:centos9`](https://hub.docker.com/r/startx/sv-ooconv) | Centos 6            | 6.3.6.2     | 0.7     |
| [`startx/sv-ooconv:centos8`](https://hub.docker.com/r/startx/sv-ooconv) | Centos 8            | 6.3.6.2     | 0.7     |
| [`startx/sv-ooconv:centos7`](https://hub.docker.com/r/startx/sv-ooconv) | Centos 7            | 5.3         | 0.7     |
| [`startx/sv-ooconv:centos6`](https://hub.docker.com/r/startx/sv-ooconv) | Centos 6            | 4.3.7.2     |         |
| [`startx/sv-ooconv:ubi8`](https://hub.docker.com/r/startx/sv-ooconv)    | RedHat UBI 8        |             | 0.7     |
| [`startx/sv-ooconv:alpine3`](https://hub.docker.com/r/startx/sv-ooconv) | Alpine 3.12         | 6.2.7.1     | 0.8     |

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="service-ooconv" startx/sv-ooconv` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/sv-ooconv:latest
  container_name: "service-ooconv"
  volumes:
    - "/tmp/container/ooconv/logs:/logs:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-imageStreams.yml)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-template-deploy.yml)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-template-build.yml)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-imageStreams.yml
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-template-deploy.yml
oc process startx-ooconv-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/ooconv/openshift-template-build.yml
oc process startx-ooconv-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image.

```bash
s2i build https://gitlab.com/startx1/containers-example-ooconv startx/sv-ooconv test-ooconv
docker run --rm -i -t test-ooconv
```

## Docker-compose in various situations

- sample docker-compose.yml linked to host port 1000

```YAML
service:
  image: startx/sv-ooconv:latest
  container_name: "service-ooconv"
  ports:
    - "1000:2002"
```

- sample docker-compose.yml with port exposed only to linked services

```YAML
service:
  image: startx/sv-ooconv:latest
  container_name: "service-ooconv"
  expose:
    - "2002"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/ooconv:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [additional environment variable](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable)

| Variable                       | Type   | Mandatory | Description                                                                                       |
| ------------------------------ | ------ | --------- | ------------------------------------------------------------------------------------------------- |
| <i>base image environement</i> |        |           | [see environment list](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable) |
| HOSTNAME                       | `auto` | `auto`    | Container unique id automatically assigned by docker daemon at startup                            |
| LOG_PATH                       | `auto` | `auto`    | default set to /var/log/ooconv and used as a volume mountpoint                                    |

## Exposed port

| Port | Description                                           |
| ---- | ----------------------------------------------------- |
| 2002 | network port used to communicate with unoconv service |

## Exposed volumes

| Container directory | Description                                            |
| ------------------- | ------------------------------------------------------ |
| /logs               | log directory used to record container and ooconv logs |

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/ooconv`
2. Build the container using `docker build -t sv-ooconv .`
3. Run this container
4. Interactively with `docker run -p 2002:2002 -v /logs -it sv-ooconv`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 2002:2002 -v /logs -d sv-ooconv`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/ooconv`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
