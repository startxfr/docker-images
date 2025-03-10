<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/sv-nodejs.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# Image NODEJS

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/Services/nodejs/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-nodejs.svg)](https://hub.docker.com/r/startx/sv-nodejs) [![Docker nodejs pulls](https://img.shields.io/docker/pulls/startx/sv-nodejs)](https://hub.docker.com/r/startx/sv-nodejs) [![Docker Repository on Quay](https://quay.io/repository/startx/nodejs/status "Docker Repository on Quay")](https://quay.io/repository/startx/nodejs)

Startx nodejs is a base container used for web services and applications published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Nodejs + npm + express webserver and fundamentals modules (nodejs release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Nodejs image in many ways :

- [Image NODEJS](#image-nodejs)
  - [Container flavours](#container-flavours)
  - [Running this image](#running-this-image)
    - [Running using docker](#running-using-docker)
    - [Running using docker-compose](#running-using-docker-compose)
    - [Using this image as Openshift Build image](#using-this-image-as-openshift-build-image)
      - [Openshift images streams](#openshift-images-streams)
      - [Openshift builder template](#openshift-builder-template)
      - [Openshift deploy template](#openshift-deploy-template)
    - [Using this image as S2I builder](#using-this-image-as-s2i-builder)
    - [Using this image as base container](#using-this-image-as-base-container)
  - [Environment variable](#environment-variable)
  - [For advanced users](#for-advanced-users)
    - [Build & run a container using `docker`](#build--run-a-container-using-docker)
    - [Build & run a container using `docker-compose`](#build--run-a-container-using-docker-compose)

See more applications builders and sample on [startx docker images repository](https://gitlab.com/startx1/containers/blob/master)

## Container flavours

| Docker Hub repository                                                   | Content             | Node    | NPM     |
| ----------------------------------------------------------------------- | ------------------- | ------- | ------- |
| [`startx/sv-nodejs:latest`](https://hub.docker.com/r/startx/sv-nodejs)  | Fedora core rawhide | 14.17.0 | 6.14.13 |
| [`startx/sv-nodejs:35`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 35      | 14.17.0 | 6.14.13 |
| [`startx/sv-nodejs:34`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 34      | 14.17.0 | 6.14.13 |
| [`startx/sv-nodejs:33`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 33      | 14.16.1 | 6.14.12 |
| [`startx/sv-nodejs:32`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 32      |         |         |
| [`startx/sv-nodejs:31`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 31      | 12.19.0 | 6.14.8  |
| [`startx/sv-nodejs:30`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 30      |         |         |
| [`startx/sv-nodejs:29`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 29      |         |         |
| [`startx/sv-nodejs:28`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 28      |         |         |
| [`startx/sv-nodejs:27`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 27      |         |         |
| [`startx/sv-nodejs:26`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 26      |         |         |
| [`startx/sv-nodejs:23`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 23      |         |         |
| [`startx/sv-nodejs:22`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 22      |         |         |
| [`startx/sv-nodejs:21`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 21      |         |         |
| [`startx/sv-nodejs:20`](https://hub.docker.com/r/startx/sv-nodejs)      | Fedora core 20      |         |         |
| [`startx/sv-nodejs:alma8`](https://hub.docker.com/r/startx/sv-nodejs)   | Alma 8              | 10.24.0 | 6.14.11 |
| [`startx/sv-nodejs:rocky8`](https://hub.docker.com/r/startx/sv-nodejs)  | Rocky 8             | 10.24.0 | 6.14.11 |
| [`startx/sv-nodejs:centos9`](https://hub.docker.com/r/startx/sv-nodejs) | Centos 9            | 10.24.0 | 6.14.11 |
| [`startx/sv-nodejs:centos8`](https://hub.docker.com/r/startx/sv-nodejs) | Centos 8            | 10.24.0 | 6.14.11 |
| [`startx/sv-nodejs:centos7`](https://hub.docker.com/r/startx/sv-nodejs) | Centos 7            | 6.17.1  | 3.10.10 |
| [`startx/sv-nodejs:centos6`](https://hub.docker.com/r/startx/sv-nodejs) | Centos 6            | 0.10.48 | 1.3.6   |
| [`startx/sv-nodejs:ubi8`](https://hub.docker.com/r/startx/sv-nodejs)    | RedHat UBI 8        | 10.24.0 | 6.14.11 |
| [`startx/sv-nodejs:alpine3`](https://hub.docker.com/r/startx/sv-nodejs) | Alpine 3.12         | 12.22.1 | 6.14.12 |

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
docker run -it -p 9221:8080 --name="example-nodejs" startx/sv-nodejs
```

- Connect to your local application

```bash
firefox http://localhost:9221
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
nodejs:
  image: startx/sv-nodejs:latest
  container_name: "example-nodejs"
  ports:
    - "9221:8080"
```

- Execute the following command

```bash
docker-compose up -d
docker-compose logs
```

- Connect to your local application

```bash
firefox http://localhost:9221
```

### Using this image as Openshift Build image

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-imageStreams.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-imageStreams.yml
```

#### Openshift builder template

Openshift cluster administrator can add a build and deploy template to their consumers.
As an administrator, you can import our [openshift builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-template-build.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-template-build.yml
```

You can then build an application

```bash
# create an example project
oc new-project example
# start a new application
oc process -f startx-nodejs-build-template \
    -p APP_NAME=myapp \
| oc create -f -
```

#### Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-template-deploy.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/nodejs/openshift-template-deploy.yml
```

You can then deploy an application

```bash
# create a example project
oc new-project example
# start a new application
oc process -f startx-nodejs-deploy-template \
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
var http = require('http');
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("My application is " + process.env.SX_SUMMARY + "\n");
});
server.listen(8080);
console.log("Server is running " + process.env.SX_ID + ":" + process.env.SX_VERSION);
EOF > app.js
```

Then you can use this image as an s2i builder image

```bash
# With your current directory application code
s2i build . startx/sv-nodejs:latest startx-nodejs-myapp
docker run --rm -d -p 9221:8080 startx-nodejs-myapp
# With startx application sample code repository
s2i build https://gitlab.com/startx1/containers-example-nodejs startx/sv-nodejs startx-nodejs-sample
docker run --rm -d -p 9221:8080 startx-nodejs-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM quay.io/startx/nodejs:latest
#... your container specifications
```

## Environment variable

| Variable   | Type     | Default            | Description                                                    |
| ---------- | -------- | ------------------ | -------------------------------------------------------------- |
| SX_VERSION | `string` | `latest`           | container version                                              |
| SX_TYPE    | `string` | `service`          | Container family (os, service, application). could be enhanced |
| SX_SERVICE | `string` | `nodejs`           | Define the type of service or application provided             |
| SX_ID      | `auto`   | `startx/sv-nodejs` | Container ID coresponding to the image repository              |
| SX_NAME    | `auto`   | `yes`              | Container name                                                 |
| SX_SUMMARY | `auto`   | `yes`              | Container purpose description                                  |
| SX_VERBOSE | `bool`   | `no`               | Display information about the execution                        |
| SX_DEBUG   | `bool`   | `no`               | Display debug informations during execution                    |
| APP_PATH   | `string` | `/app`             | Path to the application                                        |
| LOG_PATH   | `string` | `/var/log/httpd`   | Destination path to the log produced by the webserver          |
| DATA_PATH  | `string` | `/data`            | Destination path to the data manipulated by the application    |
| APP_MAIN   | `string` | `/app/app.js`      | Main application entrypoint                                    |
| SX_S2IDIR  | `string` | `/tmp`             | Destination path to the application pushed via s2i process     |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://gitlab.com/startx1/containers#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/nodejs`
2. Build the container using `docker build -t startx-nodejs .`
3. Run this container
   - Interactively with `docker run -it startx-nodejs`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d -p 9221:8080 startx-nodejs`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/nodejs`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
