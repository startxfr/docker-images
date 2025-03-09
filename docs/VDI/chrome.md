<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/vdi-chrome.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image Chrome

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/VDI/chrome/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/vdi-chrome.svg)](https://hub.docker.com/r/startx/vdi-chrome) [![Docker chrome pulls](https://img.shields.io/docker/pulls/startx/vdi-chrome)](https://hub.docker.com/r/startx/vdi-chrome) [![Docker Repository on Quay](https://quay.io/repository/startx/chrome/status "Docker Repository on Quay")](https://quay.io/repository/startx/chrome)

Simple container used to server VNC based chrome browser.
Run [chrome browser application](https://httpd.chrome.org/) under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

| Docker Hub repository                                                     | Content             | Firefox       |
| ------------------------------------------------------------------------- | ------------------- | ------------- |
| [`startx/vdi-chrome:latest`](https://hub.docker.com/r/startx/vdi-chrome)  | Fedora core rawhide | 90.0.4430.212 |
| [`startx/vdi-chrome:fc41`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 41      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc40`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 40      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc39`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 39      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc38`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 38      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc37`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 37      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc36`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 36      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc35`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 35      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc34`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 34      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc33`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 33      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc32`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 32      |               |
| [`startx/vdi-chrome:fc31`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 31      | 90.0.4430.212 |
| [`startx/vdi-chrome:fc30`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 30      |               |
| [`startx/vdi-chrome:fc29`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 29      | 70.0.3538.77  |
| [`startx/vdi-chrome:fc28`](https://hub.docker.com/r/startx/vdi-chrome)    | Fedora core 28      | 50.0.2661.102 |
| [`startx/vdi-chrome:alma8`](https://hub.docker.com/r/startx/vdi-chrome)   | Alma 8              | 90.0.4430.212 |
| [`startx/vdi-chrome:rocky8`](https://hub.docker.com/r/startx/vdi-chrome)  | Rocky 8             | 90.0.4430.212 |
| [`startx/vdi-chrome:centos9`](https://hub.docker.com/r/startx/vdi-chrome) | Centos 9            | 90.0.4430.212 |
| [`startx/vdi-chrome:centos8`](https://hub.docker.com/r/startx/vdi-chrome) | Centos 8            | 90.0.4430.212 |
| [`startx/vdi-chrome:centos7`](https://hub.docker.com/r/startx/vdi-chrome) | Centos 7            | 90.0.4430.212 |
| [`startx/vdi-chrome:alpine3`](https://hub.docker.com/r/startx/vdi-chrome) | Alpine 3.12         |               |

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="vdi-chrome" startx/vdi-chrome` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/vdi-chrome:latest
  container_name: "vdi-chrome"
  volumes:
    - "/tmp/container/chrome/logs:/logs:z"
    - "/tmp/container/chrome/data:/home/chrome:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-imageStreams.yml)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-template-deploy.yml)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-template-build.yml)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-imageStreams.yml
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-template-deploy.yml
oc process startx-chrome-deploy-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/chrome/openshift-template-build.yml
oc process startx-vdi-chrome-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image.

```bash
s2i build https://gitlab.com/startx1/containers-example-chrome startx/vdi-chrome test-chrome
docker run --rm -i -t test-chrome
```

## Docker-compose in various situations

- sample docker-compose.yml linked to host port 1000

```YAML
service:
  image: startx/vdi-chrome:latest
  container_name: "vdi-chrome"
  ports:
    - "1000:5900"
```

- sample docker-compose.yml with port exposed only to linked VDI

```YAML
service:
  image: startx/vdi-chrome:latest
  container_name: "vdi-chrome"
  expose:
    - "5900"
```

- sample docker-compose.yml using data container

```YAML
data:
  image: startx/fedora:latest
  container_name: "vdi-chrome-data"
service:
  image: startx/vdi-chrome:latest
  container_name: "vdi-chrome"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/vdi-chrome:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [additional environment variable](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable)

| Variable                       | Type          | Mandatory | Description                                                                                       |
| ------------------------------ | ------------- | --------- | ------------------------------------------------------------------------------------------------- |
| <i>base image environement</i> |               |           | [see environment list](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable) |
| SERVER_NAME                    | `string`      | `no`      | Server name for this container. If no name localhost will be assigned                             |
| HOSTNAME                       | `auto`        | `auto`    | Container unique id automatically assigned by docker daemon at startup                            |
| LOG_PATH                       | `auto`        | `auto`    | default set to /var/log/chrome and used as a volume mountpoint                                    |
| APP_PATH                       | `auto`        | `auto`    | default set to /data and used as a volume mountpoint                                              |
| SX_CHROME_SCREEN_RES_X         | `1024x768x24` | `auto`    | Define the screen resolution for X server                                                         |
| SX_CHROME_SCREEN_RES_CHROME    | `1024,768`    | `auto`    | Define the screen resolution for Chrome GUI window                                                |

## Exposed port

| Port | Description                                                     |
| ---- | --------------------------------------------------------------- |
| 5900 | standard httpd network port used for non encrypted http traffic |

## Exposed volumes

| Container directory | Description                                                                                                                             |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| /logs               | log directory used to record container and chrome logs                                                                                  |
| /home/chrome        | data directory served by chrome. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes |

## Testing the desktop application

access to the running Browser with your favorites vnc client `vinagre vnc://localhost:5900`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this desktop container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd VDI/chrome`
2. Build the container using `docker build -t vdi-chrome .`
3. Run this container
4. Interactively with `docker run -p 5900:5900 -v /data:/home/chrome -it vdi-chrome`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 5900:5900 -v /data:/home/chrome -d vdi-chrome`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd VDI/chrome`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
