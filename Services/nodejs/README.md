# Docker OS Images : NODEJS on Fedora 22

Simple container used to run server side executed javascript content. include all nodejs and npm dependency.
Run [nodejs main app.js](https://www.nodejs.org/) under a container 
based on [startx/fedora:22 container](https://hub.docker.com/r/startx/fedora). 
Could use various network protocol (like http, websocket, smtp, telnet) according to the content of the running app.

Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or **[other nodejs flavours](https://github.com/startxfr/docker-images/Services/nodejs/#available-flavours)**

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx/sv-nodejs/) | [Sources](https://github.com/startxfr/docker-images/Services/nodejs)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|----------------------------------------------------------------------------------|-----------------------------------------------|

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-nodejs" startx/sv-nodejs` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```
service:
  image: startx/sv-nodejs:fc22
  container_name: "service-nodejs-fc22"
  environment:
    CONTAINER_TYPE: "service"
    CONTAINER_SERVICE: "nodejs"
    CONTAINER_INSTANCE: "service-nodejs-fc22"
  volumes:
    - "/tmp/container-fc22/logs/nodejs:/logs"
    - "/tmp/container-fc22/nodejs:/data"
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```
service:
  image: startx/sv-nodejs:fc22
  container_name: "service-nodejs-fc22"
  environment:
    CONTAINER_INSTANCE: "service-nodejs-fc22"
  ports:
    - "1000:8000"
```
* sample docker-compose.yml with port exposed only to linked services
```
service:
  image: startx/sv-nodejs:fc22
  container_name: "service-nodejs-fc22"
  environment:
    CONTAINER_INSTANCE: "service-nodejs-fc22"
  expose:
    - "8000"
```
* sample docker-compose.yml using data container
```
data:
  image: startx/fedora:fc22
  container_name: "service-nodejs-data-fc22"
  environment:
    CONTAINER_INSTANCE: "service-nodejs-data-fc22"
service:
  image: startx/sv-nodejs:fc22
  container_name: "service-nodejs-fc22"
  environment:
    CONTAINER_INSTANCE: "service-nodejs-fc22"
  volume_from:
    - data:rw
```

## Using this image in your own container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
 ```
FROM startx/sv-nodejs:fc22
#... your container specifications
CMD ["/bin/run.sh"]
```

## Environment variable

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| APP_MAIN                  | `string` | `yes`     | Path to the application entrypoint. default is /data/nodejs/app.js
| CONTAINER_INSTANCE        | `string` | `yes`     | Container name. Should be uning to get fine grained log and application reporting
| CONTAINER_TYPE            | `string` | `no`      | Container family (os, service, application. could be enhanced 
| CONTAINER_SERVICE         | `string` | `no`      | Define the type of service or application provided
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| APP_PATH                  | `auto`   | `auto`    | default set to /data and used as a volume mountpoint
| TMP_APP_PATH              | `auto`   | `auto`    | default set to /tmp/nodejs and used to hold app content and copy to $APP_PATH on startup (if $APP_PATH is empty)

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 8000  | network port used to communicate with the running application. Network protocol depend on the running app content.

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

1. Switch to the flavour branch with `git branch fc22`
2. Jump into the container directory with `cd Services/nodejs`
3. Build the container using `docker build -t sv-nodejs .`
4. Run this container 
  1. Interactively with `docker run -p 8000:8000 -v /logs -it sv-nodejs`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 8000:8000 -v /logs -d sv-nodejs`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc22`
2. Jump into the container directory with `cd Services/nodejs`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
