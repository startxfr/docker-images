# Docker OS Images : COUCHBASE on CentOS 7

Simple container used to deliver distributed and low latency document oriented database
Run [couchbase daemon](https://www.couchbase.org/) under a container 
based on [startx/centos:7 container](https://hub.docker.com/r/startx/centos)

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or **[other postgres flavours](https://github.com/startxfr/docker-images/Services/postgres/#available-flavours)**

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=centos7)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-couchbase/) | [Sources](https://github.com/startxfr/docker-images/Services/couchbase)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------------|-----------------------------------------------|

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-couchbase" startx/sv-couchbase` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-couchbase:centos7
  container_name: "centos7-service-couchbase"
  ports:
    - "8091:8091"
    - "8092:8092"
    - "8093:8093"
    - "11207:11207"
    - "11210:11210"
    - "11211:11211"
    - "18091:18091"
    - "18092:18092"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "couchbase"
    CONTAINER_INSTANCE: "centos7-service-couchbase"
  volumes:
    - "/tmp/container-centos7/logs/couchbase:/logs"
    - "/tmp/container-centos7/couchbase:/data"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000 to 1007
```
service:
  image: startx/sv-couchbase:centos7
  container_name: "centos7-service-couchbase"
  environment:
    CONTAINER_INSTANCE: "centos7-service-couchbase"
  ports:
    - "1000:8091"
    - "1001:8092"
    - "1002:8093"
    - "1003:11207"
    - "1004:11210"
    - "1005:11211"
    - "1006:18091"
    - "1007:18092"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-couchbase:centos7
  container_name: "centos7-service-couchbase"
  environment:
    CONTAINER_INSTANCE: "centos7-service-couchbase"
  expose:
    - "8091"
    - "8092"
    - "8093"
    - "11207"
    - "11210"
    - "11211"
    - "18091"
    - "18092"
```
* sample docker-compose.yml using data container
```
data:
  image: startx/centos:7
  container_name: "centos7-service-couchbase-data"
  environment:
    CONTAINER_INSTANCE: "centos7-service-couchbase-data"
service:
  image: startx/sv-couchbase:centos7
  container_name: "centos7-service-couchbase"
  environment:
    CONTAINER_INSTANCE: "centos7-service-couchbase"
  volume_from:
    - data:rw
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-couchbase:centos7
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
| 8091  | Web Administration Port
| 8092  | Couchbase API Port
| 8093  | N1QL Query
| 11207 | Internal/External Bucket Port for SSL
| 11210 | Internal/External Bucket Port
| 11211 | Client interface (proxy)
| 18091 | Internal REST HTTPS for SSL
| 18092 | Internal CAPI HTTPS for SSL

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and couchbase logs
| /data                | data directory served by couchbase. If empty will be filled with app on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running couchbase daemon with `firefox http://localhost:8091; stats`. Change port and hostname according to your current configuration

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
  1. Interactively with `docker run -p 11211:11211 -p 8091:8091 -v /logs -it sv-couchbase`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 11211:11211 -p 8091:8091 -v /logs -d sv-couchbase`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/couchbase`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
