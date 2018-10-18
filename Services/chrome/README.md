<img align="right" height="50" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true">

# Docker OS Images : Chrome

Simple container used to server VNC based chrome browser.
Run [chrome browser application](https://httpd.chrome.org/) under a container 
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-chrome.svg)](https://hub.docker.com/r/startx/sv-chrome) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/chrome/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core 29 + Chrome 50.0.2661.102
* `:fc28` : Fedora core 28 + Chrome 50.0.2661.102
* `:centos7` : CentOS 7 + Chrome 
* `:alpine3` : Alpine 3.7 + Chrome 50.0.2661.102

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-chrome" startx/sv-chrome` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-chrome:latest
  container_name: "service-chrome"
  volumes:
    - "/tmp/container/logs/chrome:/logs:z"
    - "/tmp/container/chrome:/home/chrome:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-template.json
oc process startx-sv-chrome-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/chrome/openshift-template-build.json
oc process startx-sv-chrome-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-chrome startx/sv-chrome test-chrome
docker run --rm -i -t test-chrome
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-chrome:latest
  container_name: "service-chrome"
  ports:
    - "1000:5900"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-chrome:latest
  container_name: "service-chrome"
  expose:
    - "5900"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/fedora:latest
  container_name: "service-chrome-data"
service:
  image: startx/sv-chrome:latest
  container_name: "service-chrome"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-chrome:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)
| SERVER_NAME               | `string` | `no`      | Server name for this container. If no name localhost will be assigned
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| APP_PATH                  | `auto`   | `auto`    | default set to /data and used as a volume mountpoint
| SX_CHROME_SCREEN_RES_X          | `1024x768x24`| `auto`    | Define the screen resolution for X server
| SX_CHROME_SCREEN_RES_CHROME         |`1024,768`| `auto`    | Define the screen resolution for Chrome GUI window

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 5900  | standard httpd network port used for non encrypted http traffic

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and chrome logs
| /home/chrome         | data directory served by chrome. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running Browser with your favorites vnc client `vinagre vnc://localhost:5900`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/chrome`
2. Build the container using `docker build -t sv-chrome .`
3. Run this container 
  1. Interactively with `docker run -p 5900:5900 -v /data:/home/chrome -it sv-chrome`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 5900:5900 -v /data:/home/chrome -d sv-chrome`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/chrome`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
