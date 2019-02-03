[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : OOCONV on Fedora 30

Simple container used to document convertion and manipulation tools
Run [libreoffice](https://www.libreoffice.org/) as a daemon using [dagwieers unoconv](https://github.com/dagwieers/unoconv) under a container 
based on [startx/fedora:28 container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-ooconv.svg)](https://hub.docker.com/r/startx/sv-ooconv) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc28)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc28/Services/ooconv/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core 30 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc28` : Fedora core 28 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc27` : Fedora core 27 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc26` : Fedora core 26 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc23` : Fedora core 23 + unoconv 0.7 + LibreOffice 5.0.3.2
* `:fc22` : Fedora core 22 + unoconv 
* `:fc21` : Fedora core 21 + unoconv 
* `:centos7` : CentOS 7 + unoconv 
* `:centos6` : Centos 6 + unoconv 
* `:alpine3` : Alpine 3.7 + unoconv 0.8 + LibreOffice 5.4.5.1

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-ooconv" startx/sv-ooconv` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-ooconv:fc28
  container_name: "fc28-service-ooconv"
  volumes:
    - "/tmp/container/ooconv/logs:/logs:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-template.json
oc process startx-sv-ooconv-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/ooconv/openshift-template-build.json
oc process startx-sv-ooconv-build-template | oc create -f -
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
  image: startx/sv-ooconv:fc28
  container_name: "service-ooconv-fc28"
  ports:
    - "1000:2002"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-ooconv:fc28
  container_name: "service-ooconv-fc28"
  expose:
    - "2002"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-ooconv:fc28
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/fc28/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/fc28/OS#environment-variable)
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

1. Switch to the flavour branch with `git branch fc28`
2. Jump into the container directory with `cd Services/ooconv`
3. Build the container using `docker build -t sv-ooconv .`
4. Run this container 
  1. Interactively with `docker run -p 2002:2002 -v /logs -it sv-ooconv`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 2002:2002 -v /logs -d sv-ooconv`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc28`
2. Jump into the container directory with `cd Services/ooconv`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
