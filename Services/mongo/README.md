[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : MONGO on Fedora 28

Simple container used to deliver document-oriented database
Run [mongodb daemon](https://www.mongodb.org/) under a container 
based on [startx/fedora:28 container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-mongo.svg)](https://hub.docker.com/r/startx/sv-mongo) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc28)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc28/Services/mongo/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core rawhide + MongoDB 4.1.13
* `:fc31` : Fedora core 31 + MongoDB 4.1.13
* `:fc30` : Fedora core 30 + MongoDB 4.0.3
* `:fc29` : Fedora core 29 + MongoDB 4.0.3
* `:fc28` : Fedora core 28 + MongoDB 3.6
* `:fc27` : Fedora core 27 + MongoDB 3.4
* `:fc26` : Fedora core 26 + MongoDB 3.4
* `:fc23` : Fedora core 23 + MongoDB 3.0.7  
* `:fc22` : Fedora core 22 + MongoDB 
* `:fc21` : Fedora core 21 + MongoDB 
* `:centos8` : CentOS 8 + MongoDB 4.1
* `:centos7` : CentOS 7 + MongoDB 4.1
* `:centos6` : Centos 6 + MongoDB 3.7
* `:alpine3` : Alpine 3.10 + MongoDB 4.1
* `:ubi8` : RedHat UBI 8 + MongoDB 4.1

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-mongo" startx/sv-mongo` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-mongo:fc28
  container_name: "fc28-service-mongo"
  volumes:
    - "/tmp/container/mongo/logs:/logs:z"
    - "/tmp/container/mongo/data:/data:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-imageStreams.yml)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-template-deploy.yml)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-template-build.yml)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-imageStreams.yml
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-template-deploy.yml
oc process startx-mongo-deploy-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mongo/openshift-template-build.yml
oc process startx-mongo-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-mongo startx/sv-mongo test-mongo
docker run --rm -i -t test-mongo
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-mongo:fc28
  container_name: "service-mongo-fc28"
  ports:
    - "1000:27017"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-mongo:fc28
  container_name: "service-mongo-fc28"
  expose:
    - "27017"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/fedora:28
  container_name: "service-mongo-data-fc28"
service:
  image: startx/sv-mongo:fc28
  container_name: "service-mongo-fc28"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-mongo:fc28
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
| LOG_PATH                  | `auto`   | `auto`    | default set to /var/log/mongodb and used as a volume mountpoint
| DATA_PATH                 | `auto`   | `auto`    | default set to /data and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 27017 | standard mongodb network port used for non encrypted traffic

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and mongo logs
| /data                | data directory served by mongo. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running webserver with your favorites browser `mongo localhost:27017`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc28`
2. Jump into the container directory with `cd Services/mongo`
3. Build the container using `docker build -t sv-mongo .`
4. Run this container 
  1. Interactively with `docker run -p 27017:27017 -v /logs -it sv-mongo`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 27017:27017 -v /logs -d sv-mongo`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc28`
2. Jump into the container directory with `cd Services/mongo`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
