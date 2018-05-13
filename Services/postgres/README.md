<img align="right" height="50" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true">

# Docker OS Images : POSTGRESQL on Fedora 27

Simple container used to deliver highly reliable and configurable transactional database service using postgresql opensource project.
Run [postgres daemon](http://www.postgresql.org/) under a container 
based on [startx/fedora:27 container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-postgres.svg)](https://hub.docker.com/r/startx/sv-postgres) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc27)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc27/Services/postgres/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core 29 + PostgreSQL 9.4.5 
* `:fc28` : Fedora core 28 + PostgreSQL 9.4.5  
* `:fc27` : Fedora core 27 + PostgreSQL 9.4.5  
* `:fc26` : Fedora core 26 + PostgreSQL 9.4.5  
* `:fc23` : Fedora core 23 + PostgreSQL 9.4.5  
* `:fc22` : Fedora core 22 + PostgreSQL 
* `:fc21` : Fedora core 21 + PostgreSQL 
* `:centos7` : CentOS 7 + PostgreSQL 
* `:centos6` : Centos 6 + PostgreSQL 
* `:alpine3` : Alpine 3.7 + PostgreSQL 10.3

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-postgres" startx/sv-postgres` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-postgres:fc27
  container_name: "fc27-service-postgres"
  ports:
    - "5432:5432"
  environment:
    POSTGRESQL_ROOT_PASSWORD: "rootpassword"
    POSTGRESQL_USER: "user-test"
    POSTGRESQL_PASSWORD: "pwd-test"
    POSTGRESQL_DATABASE: "db_test"
  volumes:
    - "/tmp/container-fc27/logs/postgres:/logs:z"
    - "/tmp/container-fc27/postgres:/data:z"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-template.json
oc process startx-sv-postgres-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/fc27/Services/postgres/openshift-template-build.json
oc process startx-sv-postgres-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-postgres startx/sv-postgres test-postgres
docker run --rm -i -t test-postgres
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-postgres:fc27
  container_name: "service-postgres-fc27"
  ports:
    - "1001:5432"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-postgres:fc27
  container_name: "service-postgres-fc27"
  expose:
    - "5432"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/fedora:27
  container_name: "service-postgres-data-fc27"
service:
  image: startx/sv-postgres:fc27
  container_name: "service-postgres-fc27"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-postgres:fc27
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/fc27/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/fc27/OS#environment-variable)
| POSTGRESQL_ROOT_PASSWORD  | `string` | `no`      | Root password used for this instance. Default will use an auto generated password displayed on startup
| POSTGRESQL_USER           | `string` | `no`      | If present, add a new user with this name
| POSTGRESQL_PASSWORD       | `string` | `no`      | Password associated to the new user declared with $POSTGRESQL_USER
| POSTGRESQL_DATABASE       | `string` | `no`      | If present, add a new database with this name
| LOADSQL_PATH              | `string` | `auto`    | Path used to find sql dump to import at startup
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| DATA_PATH                 | `auto`   | `auto`    | default set to /data and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 5432  | standard postgres network port used for sql communication

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and postgres logs
| /data                | data directory served by postgres. If empty will be filled with database files on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running service with postgresql terminal `psql -h localhost -p 5432 -U <POSTGRESQL_USER>`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/postgres`
3. Build the container using `docker build -t sv-postgres .`
4. Run this container 
  1. Interactively with `docker run -p 5432:5432 -v /logs -it sv-postgres`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 5432:5432 -v /logs -d sv-postgres`


### Build & run a container using `docker-compose`

1. Switch to the flavour branch with `git branch fc27`
2. Jump into the container directory with `cd Services/postgres`
3. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
