<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/alpine/travis/logo-small.svg?sanitize=true">

# Docker OS Images : alpine 3.10

Startx Alpine is a minimal base container used for all startx services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx). 
This container contain :
- alpine system envelope
- core OS apk (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week

You can use Startx Alpine image in many ways :
- Build container based image application with [s2i builder technology](#using-this-image-as-s2i-builder)
- Build container based image application with [openshift builder image capacity](#using-this-image-as-openshift-build-image)
- Build personalized base image [with docker tools](#using-this-image-as-base-container)
- Run as simple and lightweiht OS container [with docker daemon](#running-using-docker)
- Run a minimal container app  [with docker-compose](#running-using-docker-compose)
- Enrich you openshift service catalog with [flavoured images streams](#openshift-images-streams)
- Add to your openshift service catalog an [application builder template](#openshift-builder-template)
- Add to your openshift service catalog an [application deployement template](#openshift-deploy-template)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/alpine.svg)](https://hub.docker.com/r/startx/alpine) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=alpine)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/alpine/OS/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Container flavours

| Docker Hub repository                                             | Openshift                                                                                                                                                                                                                                                                                                                                     | Docker-compose                                                                                     | Alpine distribution                        
|-------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|---------------------
| [`startx/fedora:latest`](https://hub.docker.com/r/startx/fedora)  | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora rawhide + bash 5.0.7
| [`startx/fedora:31`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 31 + bash 5.0.7
| [`startx/fedora:30`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 30 + bash 5.0.7 
| [`startx/fedora:29`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 29 + bash 4.4.23
| [`startx/fedora:28`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 28 + bash 4.3.12
| [`startx/fedora:27`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 27 + bash 4.2.4
| [`startx/fedora:26`](https://hub.docker.com/r/startx/fedora)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/OS/docker-compose.yml)  | Fedora 26 + bash 4.0.9
| [`startx/fedora:23`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 23
| [`startx/fedora:22`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 22
| [`startx/fedora:21`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 21
| [`startx/fedora:20`](https://hub.docker.com/r/startx/fedora)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 20

## Running this image

### Running using docker

```bash
docker run -it --name="example-alpine" startx/alpine
```

### Running using docker-compose

* Create a `docker-compose.yml` file with the following content
```yaml
alpine:
  image: startx/alpine:latest
  container_name: "example-alpine"
```
* Execute the following command
```bash
docker-compose up -d
docker-compose logs
```

### Using this image as Openshift Build image

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
s2i build . startx/alpine:3 startx-bash-myapp
docker run --rm -i -t startx-bash-myapp
# With startx application sample code repository
s2i build https://github.com/startxfr/docker-images-example-bash startx/alpine:3 startx-bash-sample
docker run --rm -i -t startx-bash-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/alpine:3
#... your container specifications
```

## Environment variable

| Variable                  | Type     | Default         | Description                                                              |
|---------------------------|----------|-----------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `3.10`          | container version
| SX_TYPE                   | `string` | `OS`            | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `alpine`        | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/alpine` | Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`           | Container name
| SX_SUMMARY                | `auto`   | `yes`           | Container purpose description
| SX_VERBOSE                | `bool`   | `no`            | Display information about the execution
| SX_DEBUG                  | `bool`   | `no`            | Display debug informations during execution
| APP_PATH                  | `string` | `/app`          | Path to the application
| SX_S2IDIR                 | `string` | `/tmp`          | Destination path to the application pushed via s2i process
| DAEMON_STOP_TIMEOUT       | `int`    | 3               | Number of second before stopping when smooth shutdown signal is received
| DAEMON_START_INTERVAL     | `int`    | 10              | Hearthbeat rythm (in second) for the startx default daemeon


## For advanced users

You can contribute or start this container initiative locally. 
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :
* Get latest version of this container OS source code
* Enhance and share your container improvement by adding instruction in Dockefile


### Build & run a container using `docker`

1. Jump into the container directory with `cd OS`
2. Build the container using `docker build -t startx-alpine .`
3. Run this container 
   - Interactively with `docker run -it startx-alpine`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
   - As a daemon with `docker run -d startx-alpine`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd OS`
2. Run this container 
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

