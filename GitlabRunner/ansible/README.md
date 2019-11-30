[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker gitlab runner : Ansible

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/GitlabRunner/ansible/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/runner-ansible.svg)](https://hub.docker.com/r/startx/runner-ansible) [![Docker ansible pulls](https://img.shields.io/docker/pulls/startx/runner-ansible)](https://hub.docker.com/r/startx/runner-ansible) [![Docker Repository on Quay](https://quay.io/repository/startx/ansible/status "Docker Repository on Quay")](https://quay.io/repository/startx/ansible)

Simple container used to build & test ansible playbooks, using gitlabCI runner, under a container
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

## Available flavours

- `:latest` : Fedora core rawhide + ansible + make
- `:fc32` : Fedora core 32 + ansible + make
- `:fc30` : Fedora core 30 + ansible + make
- `:fc29` : Fedora core 29 + ansible + make
- `:fc28` : Fedora core 28 + ansible + make
- `:fc27` : Fedora core 27 + ansible + make
- `:centos8` : CentOS 8 + ansible + make
- `:centos7` : CentOS 7 + ansible + make
- `:centos6` : Centos 6 + ansible + make
- `:alpine3` : Alpine 3.10 + ansible + make
- `:ubi8` : RedHat UBI 8 + ansible + make

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
FROM startx/runner-ansible:latest
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
| LOG_PATH                       | `auto` | `auto`    | default set to /var/log/ansible and used as a volume mountpoint                                       |

## Exposed port

| Port | Description                                           |
| ---- | ----------------------------------------------------- |
| 2002 | network port used to communicate with unoconv service |

## Exposed volumes

| Container directory | Description                                             |
| ------------------- | ------------------------------------------------------- |
| /logs               | log directory used to record container and ansible logs |

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :

- Get latest version of this service container
- Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd GitlabRunner/ansible`
2. Build the container using `docker build -t runner-ansible .`
3. Run this container
4. Interactively with `docker run -p 2002:2002 -v /logs -it runner-ansible`. If you add a second parameter (like `/bin/ansible`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/ansible`, `/bin/ps -a`, `/bin/df -h`,...)
5. As a daemon with `docker run -p 2002:2002 -v /logs -d runner-ansible`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd GitlabRunner/ansible`
2. Run this container
3. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
4. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
