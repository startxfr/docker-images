<img align="right" height="50" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true">

# Docker OS Images : APACHE on CentOS 7

Simple container used to deliver static http content include all apache's modules but no external languages engines (like php). For dynamic content, you should use our [sv-php service container](https://hub.docker.com/r/startx/sv-php)
Run [apache httpd daemon](https://httpd.apache.org/) under a container 
based on [startx/centos:7 container](https://hub.docker.com/r/startx/centos)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-apache.svg)](https://hub.docker.com/r/startx/sv-apache) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/apache/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : CentOS 7 + Apache 
* `:centos7` : CentOS 7 + Apache 
* `:centos6` : Centos 6 + Apache 

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-apache-centos7" startx/sv-apache:centos7` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-apache:centos7
  container_name: "service-apache"
  volumes:
    - "/tmp/container-centos7/logs/apache:/logs:z"
    - "/tmp/container-centos7/apache:/data:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template.json
oc process startx-sv-apache-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/apache/openshift-template-build.json
oc process startx-sv-apache-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-apache startx/sv-apache test-apache
docker run --rm -i -t test-apache
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-apache:centos7
  container_name: "service-apache-centos7"
  ports:
    - "1000:8080"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-apache:centos7
  container_name: "service-apache-centos7"
  expose:
    - "8080"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/centos:7
  container_name: "service-apache-data-centos7"
service:
  image: startx/sv-apache:centos7
  container_name: "service-apache-centos7"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-apache:centos7
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx centos container](https://hub.docker.com/r/startx/centos) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)
| SERVER_NAME               | `string` | `no`      | Server name for this container. If no name localhost will be assigned
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| APP_PATH                  | `auto`   | `auto`    | default set to /data and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 8080  | standard httpd network port used for non encrypted http traffic

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and apache logs
| /data                | data directory served by apache. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running webserver with your favorites browser `firefox http://localhost:8080`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch centos7`
2. Jump into the container directory with `cd Services/apache`
3. Build the container using `docker build -t sv-apache-centos7 .`
4. Run this container 
  1. Interactively with `docker run -p 80:80 -v /logs -it sv-apache-centos7`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 80:80 -v /logs -d sv-apache-centos7`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch centos7`
2. Jump into the container directory with `cd Services/apache`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping