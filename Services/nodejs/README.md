[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# Docker OS Images : NODEJS on alpine 3.8

Simple container used to run server side executed javascript content. include all nodejs and npm dependency.
Run [nodejs main app.js](https://www.nodejs.org/) under a container 
based on [startx/alpine:3 container](https://hub.docker.com/r/startx/alpine). 
Could use various network protocol (like http, websocket, smtp, telnet) according to the content of the running app.

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-nodejs.svg)](https://hub.docker.com/r/startx/sv-nodejs) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=alpine)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/alpine/Services/nodejs/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core 30 + NodeJS v0.10.36
* `:fc29` : Fedora core 29 + NodeJS v10.15.0
* `:fc28` : Fedora core 28 + NodeJS v0.10.36
* `:fc27` : Fedora core 27 + NodeJS v0.10.36
* `:fc26` : Fedora core 26 + NodeJS v0.10.36
* `:fc23` : Fedora core 23 + NodeJS v0.10.36
* `:fc22` : Fedora core 22 + NodeJS 
* `:fc21` : Fedora core 21 + NodeJS 
* `:centos7` : CentOS 7 + NodeJS 
* `:centos6` : Centos 6 + NodeJS 
* `:alpine3` : Alpine 3.8 + NodeJS 8.11.1

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-nodejs" startx/sv-nodejs` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-nodejs:alpine3
  container_name: "service-nodejs-alpine3"
  volumes:
    - "/tmp/container/nodejs/logs:/logs:z"
    - "/tmp/container/nodejs/data:/data:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-template.json
oc process startx-sv-nodejs-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/alpine/Services/nodejs/openshift-template-build.json
oc process startx-sv-nodejs-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-nodejs startx/sv-nodejs test-nodejs
docker run --rm -i -t test-nodejs
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-nodejs:alpine3
  container_name: "service-nodejs-alpine3"
  ports:
    - "1000:8080"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-nodejs:alpine3
  container_name: "service-nodejs-alpine3"
  expose:
    - "8080"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/alpine:latest
  container_name: "service-nodejs-data-alpine3"
service:
  image: startx/sv-nodejs:alpine3
  container_name: "service-nodejs-alpine3"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-nodejs:alpine3
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx alpine container](https://hub.docker.com/r/startx/alpine) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/alpine/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/alpine/OS#environment-variable)
| APP_MAIN                  | `string` | `yes`     | Path to the application entrypoint. default is /data/nodejs/app.js
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| APP_PATH                  | `auto`   | `auto`    | default set to /data and used as a volume mountpoint
| TMP_APP_PATH              | `auto`   | `auto`    | default set to /tmp/nodejs and used to hold app content and copy to $APP_PATH on startup (if $APP_PATH is empty)

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 8080  | network port used to communicate with the running application. Network protocol depend on the running app content.

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and nodejs logs
| /data                | data directory served by nodejs. If empty will be filled with app on startup. In other case use content from $TMP_APP_PATH directory

## Testing the service

access to the running application accoridn to the protocol(s) used in your application. For webcontent, you can use `firefox http://localhost:8000`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch alpine3`
2. Jump into the container directory with `cd Services/nodejs`
3. Build the container using `docker build -t sv-nodejs .`
4. Run this container 
  1. Interactively with `docker run -p 8080:8080 -v /logs -it sv-nodejs`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 8080:8080 -v /logs -d sv-nodejs`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch alpine3`
2. Jump into the container directory with `cd Services/nodejs`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
