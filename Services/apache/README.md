<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker OS Images : APACHE

Startx apache is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx). 
This container contain :
- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Apache webserver and fundamentals modules (apache release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Apache image in many ways :
- Build container based image application with [s2i builder technology](#using-this-image-as-s2i-builder)
- Build container based image application with [openshift builder image capacity](#using-this-image-as-openshift-build-image)
- Build personalized base image [with docker tools](#using-this-image-as-base-container)
- Run as simple and lightweiht webserver [with docker daemon](#running-using-docker)
- Run a minimal container app  [with docker-compose](#running-using-docker-compose)
- Enrich you openshift service catalog with [flavoured images streams](#openshift-images-streams)
- Add to your openshift service catalog an [application builder template](#openshift-builder-template)
- Add to your openshift service catalog an [application deployement template](#openshift-deploy-template)

See more applications builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-apache.svg)](https://hub.docker.com/r/startx/sv-apache) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/apache/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Container flavours

| Docker Hub repository                                                   | Openshift                                                                                                                                                                                                                                                                                                                                     | Docker-compose                                                                                     | Fedora distribution                        
|-------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|---------------------
| [`startx/sv-apache:latest`](https://hub.docker.com/r/startx/sv-apache)  | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 30 + Apache 2.4.37
| [`startx/sv-apache:30`](https://hub.docker.com/r/startx/sv-apache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 30 + Apache 2.4.37
| [`startx/sv-apache:29`](https://hub.docker.com/r/startx/sv-apache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 29 + Apache 2.4.37
| [`startx/sv-apache:28`](https://hub.docker.com/r/startx/sv-apache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 28 + Apache 2.4.17
| [`startx/sv-apache:27`](https://hub.docker.com/r/startx/sv-apache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 27 + Apache 2.4.17
| [`startx/sv-apache:26`](https://hub.docker.com/r/startx/sv-apache)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Fedora core 26 + Apache 2.4.17
| [`startx/sv-apache:23`](https://hub.docker.com/r/startx/sv-apache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 23
| [`startx/sv-apache:22`](https://hub.docker.com/r/startx/sv-apache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 22
| [`startx/sv-apache:21`](https://hub.docker.com/r/startx/sv-apache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 21
| [`startx/sv-apache:20`](https://hub.docker.com/r/startx/sv-apache)      | **N/A**                                                                                                                                                                                                                                                                                                                                       | **N/A**                                                                                            | Fedora 20
| [`startx/sv-apache:centos7`](https://hub.docker.com/r/startx/sv-apache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Centos 7
| [`startx/sv-apache:centos6`](https://hub.docker.com/r/startx/sv-apache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Centos 6
| [`startx/sv-apache:alpine3`](https://hub.docker.com/r/startx/sv-apache) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-deploy.yml)  | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/docker-compose.yml) | Alpine 3.7 + Apache 2.4.33

## Running this image

### Running using docker

```bash
docker run -it -p 9201:8080 --name="example-apache" startx/sv-apache
```

* Connect to your local application
```bash
firefox http://localhost:9201
```

### Running using docker-compose

* Create a `docker-compose.yml` file with the following content
```yaml
apache:
  image: startx/sv-apache:latest
  container_name: "example-apache"
  ports:
    - "9201:8080"
```

* Execute the following command
```bash
docker-compose up -d
docker-compose logs
```

* Connect to your local application
```bash
firefox http://localhost:9201
```

### Using this image as Openshift Build image

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift builder stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.yml) 
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
oc process -f startx-sv-apache-build-template \
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
oc process -f startx-sv-apache-deploy-template \
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
FROM startx/sv-apache:latest
#... your container specifications
```

## Environment variable

| Variable                  | Type     | Default            | Description                                                              |
|---------------------------|----------|--------------------|--------------------------------------------------------------------------|
| SX_VERSION                | `string` | `latest`           | container version
| SX_TYPE                   | `string` | `service`          | Container family (os, service, application). could be enhanced 
| SX_SERVICE                | `string` | `apache`           | Define the type of service or application provided
| SX_ID                     | `auto`   | `startx/sv-apache` | Container ID coresponding to the image repository 
| SX_NAME                   | `auto`   | `yes`              | Container name
| SX_SUMMARY                | `auto`   | `yes`              | Container purpose description
| SX_VERBOSE                | `bool`   | `no`               | Display information about the execution
| SX_DEBUG                  | `bool`   | `no`               | Display debug informations during execution
| APP_PATH                  | `string` | `/app`             | Path to the application
| LOG_PATH                  | `string` | `/var/log/httpd`   | Destination path to the log produced by the webserver
| SX_S2IDIR                 | `string` | `/tmp`             | Destination path to the application pushed via s2i process

## For advanced users

You can contribute or start this container initiative locally. 
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :
* Get latest version of this container Service source code
* Enhance and share your container improvement by adding instruction in Dockefile


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

