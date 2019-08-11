[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : OOCONV on Fedora 27

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc27/Services/ooconv/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc27)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)
 
[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-ooconv.svg)](https://hub.docker.com/r/startx/sv-ooconv) [![Docker ooconv pulls](https://img.shields.io/docker/pulls/startx/sv-ooconv)](https://hub.docker.com/r/startx/sv-ooconv) [![Docker Repository on Quay](https://quay.io/repository/startx/ooconv/status "Docker Repository on Quay")](https://quay.io/repository/startx/ooconv)


Simple container used to document convertion and manipulation tools
Run [libreoffice](https://www.libreoffice.org/) as a daemon using [dagwieers unoconv](https://github.com/dagwieers/unoconv) under a container 
based on [startx/fedora:27 container](https://hub.docker.com/r/startx/fedora)

## Available flavours

* `:latest` : Fedora core rawhide + unoconv 0.7 + LibreOffice 6.2.4.2.0
* `:fc31` : Fedora core 31 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc30` : Fedora core 30 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc29` : Fedora core 29 + unoconv 0.7 + LibreOffice 6.1.6.3
* `:fc28` : Fedora core 28 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc27` : Fedora core 27 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc26` : Fedora core 26 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc23` : Fedora core 23 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc22` : Fedora core 22 + unoconv 
* `:fc21` : Fedora core 21 + unoconv 
* `:centos8` : CentOS 8 + unoconv 
* `:centos7` : CentOS 7 + unoconv 
* `:centos6` : Centos 6 + unoconv 
* `:alpine3` : Alpine 3.10 + unoconv 0.8 + LibreOffice 5.4.5.1
* `:ubi8` : RedHat UBI 8 + unoconv 

## Running from dockerhub registry

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
 [podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
 [s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
 [dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
 [kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
 [openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

* with `docker` you can run `docker run -it --name="service-ooconv" startx/sv-ooconv` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-ooconv:fc27
  container_name: "fc27-service-ooconv"
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
s2i build https://github.com/startxfr/docker-images-example-ooconv startx/sv-ooconv test-ooconv
docker run --rm -i -t test-ooconv
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-ooconv:fc27
  container_name: "service-ooconv-fc27"
  ports:
    - "1000:2002"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-ooconv:fc27
  container_name: "service-ooconv-fc27"
  expose:
    - "2002"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-ooconv:fc27
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/fc27/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/fc27/OS#environment-variable)
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /var/log/ooconv and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 2002  | network port used to communicate with unoconv service

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and ooconv logs

## Testing the service

access to the running unoconv service with unoconv client `unoconv -s localhost -p 2002`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/ooconv`
3. Build the container using `docker build -t sv-ooconv .`
4. Run this container 
  1. Interactively with `docker run -p 2002:2002 -v /logs -it sv-ooconv`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 2002:2002 -v /logs -d sv-ooconv`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/ooconv`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
