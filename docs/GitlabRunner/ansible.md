<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/runner-ansible.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image runner-Ansible

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/GitlabRunner/ansible/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-ansible.svg)](https://hub.docker.com/r/startx/runner-ansible) [![Docker ansible pulls](https://img.shields.io/docker/pulls/startx/runner-ansible)](https://hub.docker.com/r/startx/runner-ansible) [![Docker Repository on Quay](https://quay.io/repository/startx/ansible/status "Docker Repository on Quay")](https://quay.io/repository/startx/ansible)

Simple container used to build & test ansible playbooks, using gitlabCI runner, under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

| Docker Hub repository                                                             | Content             | Ansible | Python | Make  |
| --------------------------------------------------------------------------------- | ------------------- | ------- | ------ | ----- |
| [`startx/runner-ansible:latest`](https://hub.docker.com/r/startx/runner-ansible)  | Fedora core rawhide | 2.9.21  | 3.9.5  | 4.3   |
| [`startx/runner-ansible:35`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 35      | 2.9.21  | 3.9.5  | 4.3   |
| [`startx/runner-ansible:34`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 34      | 2.9.21  | 3.9.5  | 4.3   |
| [`startx/runner-ansible:33`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 33      |         |        | 4.3   |
| [`startx/runner-ansible:32`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 32      | 2.9.21  | 3.9.5  | 4.3   |
| [`startx/runner-ansible:31`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 31      | 2.9.14  | 3.7.9  | 4.2.1 |
| [`startx/runner-ansible:30`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 30      |         |        |       |
| [`startx/runner-ansible:29`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 29      |         |        |       |
| [`startx/runner-ansible:28`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 28      |         |        |       |
| [`startx/runner-ansible:27`](https://hub.docker.com/r/startx/runner-ansible)      | Fedora core 27      |         |        |       |
| [`startx/runner-ansible:alma8`](https://hub.docker.com/r/startx/runner-ansible)   | Alma 8              | 2.9.21  | 3.6.8  | 4.2.1 |
| [`startx/runner-ansible:rocky8`](https://hub.docker.com/r/startx/runner-ansible)  | Rocky 8             | 2.9.21  | 3.6.8  | 4.2.1 |
| [`startx/runner-ansible:centos9`](https://hub.docker.com/r/startx/runner-ansible) | Centos 9            | 2.9.21  | 3.6.8  | 4.2.1 |
| [`startx/runner-ansible:centos8`](https://hub.docker.com/r/startx/runner-ansible) | Centos 8            | 2.9.21  | 3.6.8  | 4.2.1 |
| [`startx/runner-ansible:centos7`](https://hub.docker.com/r/startx/runner-ansible) | Centos 7            | 2.9.21  | 2.7.5  | 3.82  |
| [`startx/runner-ansible:ubi8`](https://hub.docker.com/r/startx/runner-ansible)    | RedHat UBI 8        |         |        | 4.3   |
| [`startx/runner-ansible:alpine3`](https://hub.docker.com/r/startx/runner-ansible) | Alpine 3.12         | 2.9.14  | 3.8.10 | 4.3   |

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

- with `docker` you can run `docker run -it --name="service-ansible" startx/runner-ansible` from any docker host
- with `docker-compose` you can create a docker-compose.yml file with the following content

```YAML
service:
  image: startx/runner-ansible:latest
  container_name: "service-ansible"
  volumes:
    - "/tmp/container/ansible/logs:/logs:z"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/runner-ansible:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with
some [additional environment variable](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable)

| Variable                       | Type   | Mandatory | Description                                                                                            |
| ------------------------------ | ------ | --------- | ------------------------------------------------------------------------------------------------------ |
| <i>base image environement</i> |        |           | [see environment list](https://docker-images.readthedocs.io/en/latest/OS/fedora/#environment-variable) |
| HOSTNAME                       | `auto` | `auto`    | Container unique id automatically assigned by docker daemon at startup                                 |
| LOG_PATH                       | `auto` | `auto`    | default set to /var/log/ansible and used as a volume mountpoint                                        |

## Exposed port

_no exposed port_

## Exposed volumes

| Container directory | Description                                             |
| ------------------- | ------------------------------------------------------- |
| /logs               | log directory used to record container and ansible logs |

## Testing the service

access to the runner with `docker logs service-ansible`.

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/ansible`
2. Build the container using `docker build -t runner-ansible .`
3. Run this container
4. Interactively with `docker run -v /logs -it runner-ansible`. If you add a second parameter (like `/bin/ansible`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/ansible`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -v /logs -d runner-ansible sleep infinity`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/ansible`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

