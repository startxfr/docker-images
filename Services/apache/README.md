# Docker OS Images : APACHE on Fedora 27

Simple container used to deliver static http content include all apache's modules but no external languages engines (like php). For dynamic content, you should use our [sv-php service container](https://hub.docker.com/r/startx/sv-php)
Run [apache httpd daemon](https://httpd.apache.org/) under a container 
based on [startx/fedora:27 container](https://hub.docker.com/r/startx/fedora)

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or **[other apache flavours](https://github.com/startxfr/docker-images/Services/apache/#available-flavours)**

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc27)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-apache/) | [Sources](https://github.com/startxfr/docker-images/tree/fc27/Services/apache)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|----------------------------------------------------------------------------------|-----------------------------------------------|

## Available flavours

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="fc27-service-apache" startx/sv-apache:fc27` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-apache:fc27
  container_name: "fc27-service-apache"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "apache"
    CONTAINER_INSTANCE: "fc27-service-apache"
    SERVER_NAME: "localhost"
  volumes:
    - "/tmp/container-fc27/logs/apache:/logs"
    - "/tmp/container-fc27/apache:/data"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```
service:
  image: startx/sv-apache:fc27
  container_name: "fc27-service-apache"
  environment:
    CONTAINER_INSTANCE: "fc27-service-apache"
  ports:
    - "1000:8080"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-apache:fc27
  container_name: "fc27-service-apache"
  environment:
    CONTAINER_INSTANCE: "fc27-service-apache"
  expose:
    - "8080"
```
* sample docker-compose.yml using data container
```
data:
  image: startx/fedora:27
  container_name: "fc27-service-apache-data"
  environment:
    CONTAINER_INSTANCE: "fc27-service-apache-data"
service:
  image: startx/sv-apache:fc27
  container_name: "fc27-service-apache"
  environment:
    CONTAINER_INSTANCE: "fc27-service-apache"
  volume_from:
    - data:rw
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-apache:fc27
#... your container specifications
CMD ["/bin/run.sh"]
```

## Environment variable

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| CONTAINER_INSTANCE        | `string` | `yes`     | Container name. Should be uning to get fine grained log and application reporting
| CONTAINER_TYPE            | `string` | `no`      | Container family (os, service, application. could be enhanced 
| CONTAINER_SERVICE         | `string` | `no`      | Define the type of service or application provided
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

0. Switch to the flavour branch with `git branch fc27`
1. Jump into the container directory with `cd Services/apache`
2. Build the container using `docker build -t sv-apache-fc27 .`
3. Run this container 
  1. Interactively with `docker run -p 8080:8080 -v /logs -it sv-apache-fc27`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 8080:8080 -v /logs -d sv-apache-fc27`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/apache`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
