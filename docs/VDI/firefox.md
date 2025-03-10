<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/vdi-firefox.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image Firefox

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/VDI/firefox/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/vdi-firefox.svg)](https://hub.docker.com/r/startx/vdi-firefox) [![Docker firefox pulls](https://img.shields.io/docker/pulls/startx/vdi-firefox)](https://hub.docker.com/r/startx/vdi-firefox) [![Docker Repository on Quay](https://quay.io/repository/startx/firefox/status "Docker Repository on Quay")](https://quay.io/repository/startx/firefox)

Simple container used to server VNC based firefox browser.
Run [firefox browser application](https://httpd.firefox.org/) under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

| Docker Hub repository                                                       | Content             | Firefox    |
| --------------------------------------------------------------------------- | ------------------- | ---------- |
| [`startx/vdi-firefox:latest`](https://hub.docker.com/r/startx/vdi-firefox)  | Fedora core rawhide | 88.0       |
| [`startx/vdi-firefox:fc41`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 41      | 88.0       |
| [`startx/vdi-firefox:fc40`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 40      | 88.0       |
| [`startx/vdi-firefox:fc39`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 39      | 88.0       |
| [`startx/vdi-firefox:fc38`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 38      | 88.0       |
| [`startx/vdi-firefox:fc37`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 37      | 88.0       |
| [`startx/vdi-firefox:fc36`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 36      | 88.0       |
| [`startx/vdi-firefox:fc35`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 35      | 88.0       |
| [`startx/vdi-firefox:fc34`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 34      | 88.0.1     |
| [`startx/vdi-firefox:fc33`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 33      | 88.0.1     |
| [`startx/vdi-firefox:fc32`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 32      |            |
| [`startx/vdi-firefox:fc31`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 31      | 82.0.2     |
| [`startx/vdi-firefox:fc30`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 30      |            |
| [`startx/vdi-firefox:fc29`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 29      |            |
| [`startx/vdi-firefox:fc28`](https://hub.docker.com/r/startx/vdi-firefox)    | Fedora core 28      |            |
| [`startx/vdi-firefox:alma8`](https://hub.docker.com/r/startx/vdi-firefox)   | Alma 8              | 78.10.0esr |
| [`startx/vdi-firefox:rocky8`](https://hub.docker.com/r/startx/vdi-firefox)  | Rocky 8             | 78.10.0esr |
| [`startx/vdi-firefox:centos9`](https://hub.docker.com/r/startx/vdi-firefox) | Centos 9            | 78.10.0esr |
| [`startx/vdi-firefox:centos8`](https://hub.docker.com/r/startx/vdi-firefox) | Centos 8            | 78.10.0esr |
| [`startx/vdi-firefox:centos7`](https://hub.docker.com/r/startx/vdi-firefox) | Centos 7            | 78.10.0esr |
| [`startx/vdi-firefox:alpine3`](https://hub.docker.com/r/startx/vdi-firefox) | Alpine 3.12         | 88.0.1     |

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="vdi-firefox" startx/vdi-firefox` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/vdi-firefox:latest
  container_name: "vdi-firefox"
  volumes:
    - "/tmp/container/firefox/logs:/logs:z"
    - "/tmp/container/firefox/data:/home/firefox:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-imageStreams.yml)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-template-deploy.yml)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-template-build.yml)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-imageStreams.yml
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-template-deploy.yml
oc process startx-firefox-deploy-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/VDI/firefox/openshift-template-build.yml
oc process startx-vdi-firefox-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image.

```bash
s2i build https://gitlab.com/startx1/containers-example-firefox startx/vdi-firefox test-firefox
docker run --rm -i -t test-firefox
```

## Docker-compose in various situations

- sample docker-compose.yml linked to host port 1000

```YAML
service:
  image: startx/vdi-firefox:latest
  container_name: "vdi-firefox"
  ports:
    - "1000:5900"
```

- sample docker-compose.yml with port exposed only to linked VDI

```YAML
service:
  image: startx/vdi-firefox:latest
  container_name: "vdi-firefox"
  expose:
    - "5900"
```

- sample docker-compose.yml using data container

```YAML
data:
  image: startx/fedora:latest
  container_name: "vdi-firefox-data"
service:
  image: startx/vdi-firefox:latest
  container_name: "vdi-firefox"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/vdi-firefox:latest
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
| LOG_PATH                       | `auto`        | `auto`    | default set to /var/log/firefox and used as a volume mountpoint                                   |
| APP_PATH                       | `auto`        | `auto`    | default set to /data and used as a volume mountpoint                                              |
| SX_FIREFOX_SCREEN_RES_X        | `1024x768x24` | `auto`    | Define the screen resolution for X server                                                         |
| SX_FIREFOX_SCREEN_RES_FIREFOX  | `1024,768`    | `auto`    | Define the screen resolution for Firefox GUI window                                               |

## Exposed port

| Port | Description                                                     |
| ---- | --------------------------------------------------------------- |
| 5900 | standard httpd network port used for non encrypted http traffic |

## Exposed volumes

| Container directory | Description                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| /logs               | log directory used to record container and firefox logs                                                                                  |
| /home/firefox       | data directory served by firefox. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes |

## Testing the desktop application

access to the running Browser with your favorites vnc client `vinagre vnc://localhost:5900`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this desktop container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd VDI/firefox`
2. Build the container using `docker build -t vdi-firefox .`
3. Run this container
4. Interactively with `docker run -p 5900:5900 -v /data:/home/firefox -it vdi-firefox`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 5900:5900 -v /data:/home/firefox -d vdi-firefox`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd VDI/firefox`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
