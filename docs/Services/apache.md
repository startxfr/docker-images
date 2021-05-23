<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Image APACHE

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/apache/)

[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-apache.svg)](https://hub.docker.com/r/startx/sv-apache) [![Docker apache pulls](https://img.shields.io/docker/pulls/startx/sv-apache)](https://hub.docker.com/r/startx/sv-apache) [![Docker Repository on Quay](https://quay.io/repository/startx/apache/status "Docker Repository on Quay")](https://quay.io/repository/startx/apache)

Startx apache is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx)
and [Quay registry](https://quay.io/user/startx).
This container contain :

- fedora / centos /alpine /ubi operating system
- core OS packages (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` flavour.
- Apache webserver and fundamentals modules (apache release depend on the flavour you use, see [container flavours](#container-flavours)
  for more information)

You can use Startx Apache image in many ways :

- [Image APACHE](#image-apache)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Running using Openshift](#running-using-openshift)
      - [Openshift images streams](#openshift-images-streams)
      - [Openshift builder template](#openshift-builder-template)
      - [Openshift deploy template](#openshift-deploy-template)
    - [Using this image as S2I builder](#using-this-image-as-s2i-builder)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Environment variable](#environment-variable)
  - [Container command](#container-command)
  - [For advanced users](#for-advanced-users)
    - [Build & run a container using `docker`](#build--run-a-container-using-docker)
    - [Build & run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

## Container flavours

| Docker Hub repository                                                   | Content             | Apache |
| ----------------------------------------------------------------------- | ------------------- | ------ |
| [`startx/sv-apache:latest`](https://hub.docker.com/r/startx/sv-apache)  | Fedora core rawhide | 2.4.46 |
| [`startx/sv-apache:34`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 34      | 2.4.46 |
| [`startx/sv-apache:33`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 33      | 2.4.46 |
| [`startx/sv-apache:32`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 32      | 2.4.43 |
| [`startx/sv-apache:31`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 31      | 2.4.43 |
| [`startx/sv-apache:30`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 30      | 2.4.41 |
| [`startx/sv-apache:29`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 29      | 2.4.41 |
| [`startx/sv-apache:28`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 28      | 2.4.39 |
| [`startx/sv-apache:27`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 27      | 2.4.34 |
| [`startx/sv-apache:26`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 26      | 2.4.33 |
| [`startx/sv-apache:23`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 23      | 2.4.23 |
| [`startx/sv-apache:22`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 22      | 2.4.18 |
| [`startx/sv-apache:21`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 21      |        |
| [`startx/sv-apache:20`](https://hub.docker.com/r/startx/sv-apache)      | Fedora core 20      |        |
| [`startx/sv-apache:centos8`](https://hub.docker.com/r/startx/sv-apache) | Centos 8            | 2.4.37 |
| [`startx/sv-apache:centos7`](https://hub.docker.com/r/startx/sv-apache) | Centos 7            | 2.4.6  |
| [`startx/sv-apache:centos6`](https://hub.docker.com/r/startx/sv-apache) | Centos 6            | 2.2.15 |
| [`startx/sv-apache:ubi8`](https://hub.docker.com/r/startx/sv-apache)    | RedHat UBI 8        | 2.4.37 |
| [`startx/sv-apache:alpine3`](https://hub.docker.com/r/startx/sv-apache) | Alpine 3.12         | 2.4.46 |

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
docker run -it -p 9201:8080 --name="example-apache" startx/sv-apache
```

- Connect to your local application

```bash
firefox http://localhost:9201
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
apache:
  image: startx/sv-apache:latest
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

### Running using Openshift

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml
```

#### Openshift builder template

Openshift cluster administrator can add a build and deploy template to their consumers.
As an administrator, you can import our [openshift builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml
```

You can then build an application

```bash
# create an example project
oc new-project example
# start a new application
oc process -f startx-apache-build-template \
    -p APP_NAME=myapp \
| oc create -f -
```

#### Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml
```

You can then deploy an application

```bash
# create a example project
oc new-project example
# start a new application
oc process -f startx-apache-deploy-template \
    -p APP_NAME=myapp \
| oc create -f -
```

### Using this image as S2I builder

Create your local project (skip if you already are in a project diretory with a `run` bash script)

```bash
# Create a project directory
mkdir example-project
cd example-project
# create a run script
cat << "EOF"
<html><head></head><body><h1>My Web Application</h1></body></html>
EOF > index.html
```

Then you can use this image as an s2i builder image

```bash
# With your current directory application code
s2i build . startx/sv-apache:latest startx-apache-myapp
docker run --rm -d -p 9201:8080 startx-apache-myapp
# With startx application sample code repository
s2i build https://github.com/startxfr/docker-images-example-apache startx/sv-apache startx-apache-sample
docker run --rm -d -p 9201:8080 startx-apache-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/apache:latest
#... your container specifications
```

## Environment variable

| Variable   | Type     | Default            | Description                                                    |
| ---------- | -------- | ------------------ | -------------------------------------------------------------- |
| SX_VERSION | `string` | `latest`           | container version                                              |
| SX_TYPE    | `string` | `service`          | Container family (os, service, application). could be enhanced |
| SX_SERVICE | `string` | `apache`           | Define the type of service or application provided             |
| SX_ID      | `auto`   | `startx/sv-apache` | Container ID coresponding to the image repository              |
| SX_NAME    | `auto`   | `yes`              | Container name                                                 |
| SX_SUMMARY | `auto`   | `yes`              | Container purpose description                                  |
| SX_VERBOSE | `bool`   | `no`               | Display information about the execution                        |
| SX_DEBUG   | `bool`   | `no`               | Display debug informations during execution                    |
| APP_PATH   | `string` | `/app`             | Path to the application                                        |
| APP_PORT   | `string` | `8080`             | Port to the application                                        |
| LOG_PATH   | `string` | `/var/log/httpd`   | Destination path to the log produced by the webserver          |
| SX_S2IDIR  | `string` | `/tmp`             | Destination path to the application pushed via s2i process     |

## Container command

| Variable    | Description                                        |
| ----------- | -------------------------------------------------- |
| assemble    | Execute the build script on \$APP_PATH application |
| post-build  | Execute the post-build script                      |
| pre-deploy  | Execute the pre-deployment script                  |
| post-deploy | Execute the post-deployment script                 |
| run         | Start the application                              |
| isLive      | Execute the liveness-probe script                  |
| isReady     | Execute the readyness-probe script                 |
| info        | Get information about the sx-apache script         |
| usage       | Get the usage message                              |
| version     | Get information about the sx-apache version        |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/apache`
2. Build the container using `docker build -t startx-apache .`
3. Run this container
   - Interactively with `docker run -it startx-apache`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d -p 9201:8080 startx-apache`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/apache`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
