<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/os-alma.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image ALMA

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/OS/)

[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/alma.svg)](https://hub.docker.com/r/startx/alma) [![Docker apache pulls](https://img.shields.io/docker/pulls/startx/alma)](https://hub.docker.com/r/startx/alma) [![Docker Repository on Quay](https://quay.io/repository/startx/apache/status "Docker Repository on Quay")](https://quay.io/repository/startx/apache)

Startx alma is a base container used for all startx services and applications published in
[Dockerhub registry](https://hub.docker.com/u/startx) or [Quay registry](https://quay.io/user/startx).
This container contain :

- alma operating system
- core OS packages (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` flavour.

You can use Startx image in many ways :

- [Image ALMA](#image-alma)
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

See more applications builders and sample on [startx docker images repository](https://gitlab.com/startx1/containers/blob/master)

## Container flavours

| Docker Hub repository                                   | Distribution | Bash   | Kernel |
| ------------------------------------------------------- | ------------ | ------ | ------ |
| [`startx/alma:8`](https://hub.docker.com/r/startx/alma) | Alma 8       | 4.4.19 |        |

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
docker run -it --name="example-alma" startx/alma
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
alma:
  image: startx/alma:latest
  container_name: "example-alma"
```

- Execute the following command

```bash
docker-compose up -d
docker-compose logs
```

### Running using Openshift

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml
```

#### Openshift builder template

Openshift cluster administrator can add a build and deploy template to their consumers.
As an administrator, you can import our [openshift builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml
```

You can then build an application

```bash
# create a example project
oc new-project example
# start a new application
oc process -f startx-os-build-template \
    -p APP_NAME=myapp \
| oc create -f -
```

#### Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml
```

You can then deploy an application

```bash
# create a example project
oc new-project example
# start a new application
oc process -f startx-os-deploy-template \
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
#!/bin/bash -e
source $SX_LIBDIR/sx
startDaemon
EOF > run
chmod ug+x run
```

Then you can use this image as an s2i builder image

```bash
# With your current directory application code
s2i build . startx/alma:latest startx-bash-myapp
docker run --rm -i -t startx-bash-myapp
# With startx application sample code repository
s2i build https://gitlab.com/startx1/containers-example-bash startx/alma startx-bash-sample
docker run --rm -i -t startx-bash-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/alma:latest
#... your container specifications
```

## Environment variable

| Variable              | Type     | Default       | Description                                                              |
| --------------------- | -------- | ------------- | ------------------------------------------------------------------------ |
| SX_VERSION            | `string` | `latest`      | container version                                                        |
| SX_TYPE               | `string` | `OS`          | Container family (os, service, application). could be enhanced           |
| SX_SERVICE            | `string` | `alma`        | Define the type of service or application provided                       |
| SX_ID                 | `auto`   | `startx/alma` | Container ID coresponding to the image repository                        |
| SX_NAME               | `auto`   | `yes`         | Container name                                                           |
| SX_SUMMARY            | `auto`   | `yes`         | Container purpose description                                            |
| SX_VERBOSE            | `bool`   | `no`          | Display information about the execution                                  |
| SX_DEBUG              | `bool`   | `no`          | Display debug informations during execution                              |
| APP_PATH              | `string` | `/app`        | Path to the application                                                  |
| SX_S2IDIR             | `string` | `/tmp`        | Destination path to the application pushed via s2i process               |
| DAEMON_STOP_TIMEOUT   | `int`    | 3             | Number of second before stopping when smooth shutdown signal is received |
| DAEMON_START_INTERVAL | `int`    | 10            | Hearthbeat rythm (in second) for the startx default daemeon              |

## Container command

| Variable    | Description                                        |
| ----------- | -------------------------------------------------- |
| assemble    | Execute the build script on \$APP_PATH application |
| post-build  | Execute the post-build script                      |
| pre-deploy  | Execute the pre-deployment script                  |
| post-deploy | Execute the post-deployment script                 |
| run         | Start the application                              |
| daemon      | Start container as a daemon                        |
| isLive      | Execute the liveness-probe script                  |
| isReady     | Execute the readyness-probe script                 |
| info        | Get information about the sx-os script             |
| usage       | Get the usage message                              |
| version     | Get information about the sx-os version            |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container OS source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd OS`
2. Build the container using `docker build -t startx-alma .`
3. Run this container
   - Interactively with `docker run -it startx-alma`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d startx-alma`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd OS`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
