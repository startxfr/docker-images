[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : COUCHBASE on Fedora 28

Simple container used to deliver distributed and low latency document oriented database
Run [couchbase daemon](https://www.couchbase.org/) under a container 
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-couchbase.svg)](https://hub.docker.com/r/startx/sv-couchbase) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc28)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc28/Services/couchbase/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora rawhide + Couchbase Server 5.5.0-2036
* `:fc29` : Fedora 29 + Couchbase Server 5.5.0-2036
* `:fc28` : Fedora 28 + Couchbase Server 5.5.0-Mar (beta)
* `:centos7` : Centos 7 + Couchbase Server 5.5.0-Mar (beta)

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-couchbase" startx/sv-couchbase` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "fc28-service-couchbase"
  volumes:
    - "/tmp/container/couchbase/logs:/logs:z"
    - "/tmp/container/couchbase/data:/data:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-template.json
oc process startx-sv-couchbase-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc28/Services/couchbase/openshift-template-build.json
oc process startx-sv-couchbase-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-couchbase startx/sv-couchbase test-couchbase
docker run --rm -i -t test-couchbase
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "service-couchbase-fc28"
  ports:
    - "1000:11211"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-couchbase:fc28
  container_name: "service-couchbase-fc28"
  expose:
    - "11211"
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-couchbase:fc28
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
| LOG_PATH                  | `auto`   | `auto`    | default set to /var/log/couchbase and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 11211 | standard couchbase network port used for key/value recovery

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and couchbase logs
| /data                | data directory served by couchbase. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running couchbase daemon with `telnet localhost 11211; stats`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/couchbase`
2. Build the container using `docker build -t sv-couchbase .`
3. Run this container 
  1. Interactively with `docker run -p 11211:11211 -v /logs -it sv-couchbase`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 11211:11211 -v /logs -d sv-couchbase`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/couchbase`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
