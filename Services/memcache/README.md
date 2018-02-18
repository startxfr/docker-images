# Docker OS Images : MEMCACHE on Fedora 27

Simple container used to deliver distributed memory object caching system
Run [memcached daemon](https://www.memcached.org/) under a container 
based on [startx/fedora:27 container](https://hub.docker.com/r/startx/fedora)

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or **[other memcache flavours](https://github.com/startxfr/docker-images/Services/memcache/#available-flavours)**

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc27)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-memcache/) | [Sources](https://github.com/startxfr/docker-images/tree/fc27/Services/memcache)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------------|-----------------------------------------------|

## Available flavours

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-memcache-fc27" startx/sv-memcache:fc27` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-memcache:fc27
  container_name: "service-memcache-fc27"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "memcache"
    CONTAINER_INSTANCE: "service-memcache-fc27"
  volumes:
    - "/tmp/container-fc27/logs/memcache:/logs"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```
service:
  image: startx/sv-memcache:fc27
  container_name: "service-memcache-fc27"
  environment:
    CONTAINER_INSTANCE: "service-memcache-fc27"
  ports:
    - "1000:11211"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-memcache:fc27
  container_name: "service-memcache-fc27"
  environment:
    CONTAINER_INSTANCE: "service-memcache-fc27"
  expose:
    - "11211"
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-memcache:fc27
#... your container specifications
CMD ["/bin/run.sh"]
```

## Environment variable

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| CONTAINER_INSTANCE        | `string` | `yes`     | Container name. Should be uning to get fine grained log and application reporting
| CONTAINER_TYPE            | `string` | `no`      | Container family (os, service, application. could be enhanced 
| CONTAINER_SERVICE         | `string` | `no`      | Define the type of service or application provided
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 11211 | standard memcached network port used for key/value recovery

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and memcache logs
| /data                | data directory served by memcache. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running memcached daemon with `telnet localhost 11211; stats`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/memcache`
3. Build the container using `docker build -t sv-memcache .`
4. Run this container 
  1. Interactively with `docker run -p 11211:11211 -v /logs -it sv-memcache`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 11211:11211 -v /logs -d sv-memcache`

### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/memcache`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
