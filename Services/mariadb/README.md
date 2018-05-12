<img align="right" height="50" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo.svg?sanitize=true">

# Docker OS Images : MARIADB

Simple container used to deliver simple and easy to use transactional database using mysql like database provided by [mariadb open-source project](https://mariadb.org/).
Run [mariadb daemon](https://mariadb.org/) under a container 
based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-mariadb.svg)](https://hub.docker.com/r/startx/sv-mariadb) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/Services/mariadb/) [![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) 

## Available flavours

* `:latest` : Fedora core 29 + MariaDB 10.0.21 (compat mysql  15.1)
* `:fc28` : Fedora core 28 + MariaDB 10.0.21 (compat mysql  15.1)
* `:fc27` : Fedora core 27 + MariaDB 10.0.21 (compat mysql  15.1)
* `:fc26` : Fedora core 26 + MariaDB 10.0.21 (compat mysql  15.1)
* `:fc23` : Fedora core 23 + MariaDB 10.0.21 (compat mysql  15.1)
* `:fc22` : Fedora core 22 + MariaDB 
* `:fc21` : Fedora core 21 + MariaDB 
* `:centos7` : CentOS 7 + MariaDB 
* `:centos6` : Centos 6 + MariaDB
* `:alpine3` : Alpine 3.7 + MariaDB 10.2.14

## Running from dockerhub registry

* with `docker` you can run `docker run -it --name="service-mariadb" startx/sv-mariadb` from any docker host
* with `docker-compose` you can create a docker-compose.yml file with the following content
```YAML
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  ports:
    - "3306:3306"
  environment:
    MYSQL_ROOT_PASSWORD: "rootpassword"
    MYSQL_USER: "user-test"
    MYSQL_PASSWORD: "pwd-test"
    MYSQL_DATABASE: "db_test"
  volumes:
    - "/tmp/container/logs/mariadb:/logs"
    - "/tmp/container/mariadb:/data"
```

### Using this image as Openshift Build image

You can use this public image as a base image in your openshift build strategy. You can first import
our [openshift image stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.json)
and automatically add them in your service catalog. You can also test our [deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template.json)
or our [build and deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.json)

```bash
# import image streams
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.json
# import deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template.json
oc process startx-sv-mariadb-template | oc create -f -
# import build and deploy template and start a sample application
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.json
oc process startx-sv-mariadb-build-template | oc create -f -
```

### Using this image as S2I builder

You can use this image as an s2i builder image. 
```bash
s2i build https://github.com/startxfr/docker-images-example-mariadb startx/sv-mariadb test-mariadb
docker run --rm -i -t test-mariadb
```

## Docker-compose in various situations

* sample docker-compose.yml linked to host port 1000
```YAML
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  ports:
    - "1001:3306"
```
* sample docker-compose.yml with port exposed only to linked services
```YAML
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  expose:
    - "3306"
```
* sample docker-compose.yml using data container
```YAML
data:
  image: startx/fedora:latest
  container_name: "service-mariadb-data"
service:
  image: startx/sv-mariadb:latest
  container_name: "service-mariadb"
  volume_from:
    - data:rw
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named Dockerfile in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.
```Dockerfile
FROM startx/sv-mariadb:latest
#... your container specifications
CMD ["/bin/sx", "run"]
```

## Environment variable

This container is based on [startx fedora container](https://hub.docker.com/r/startx/fedora) who came with 
some [additional environment variable](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)

| Variable                  | Type     | Mandatory | Description                                                              |
|---------------------------|----------|-----------|--------------------------------------------------------------------------|
| <i>base image environement</i> |          |           | [see environment list](https://github.com/startxfr/docker-images/tree/master/OS#environment-variable)
| MYSQL_ROOT_PASSWORD       | `string` | `no`      | Root password used for this instance. Default will use an auto generated password displayed on startup
| MYSQL_USER                | `string` | `no`      | If present, add a new user with this name
| MYSQL_PASSWORD            | `string` | `no`      | Password associated to the new user declared with $MYSQL_USER
| MYSQL_DATABASE            | `string` | `no`      | If present, add a new database with this name
| LOADSQL_PATH              | `string` | `auto`    | Path used to find sql dump to import at startup
| HOSTNAME                  | `auto`   | `auto`    | Container unique id automatically assigned by docker daemon at startup
| LOG_PATH                  | `auto`   | `auto`    | default set to /logs and used as a volume mountpoint
| DATA_PATH                 | `auto`   | `auto`    | default set to /data and used as a volume mountpoint

## Exposed port

| Port  | Description                                                              |
|-------|--------------------------------------------------------------------------|
| 3306  | standard mariadb network port used for sql communication

## Exposed volumes

| Container directory  | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| /logs                | log directory used to record container and mariadb logs
| /data                | data directory served by mariadb. If empty will be filled with database files on startup. In other case use content from mountpoint or data volumes

## Testing the service

access to the running service with mysql terminal `mysql --host=localhost --port=3306 --user=<MYSQL_USER> --password=<MYSQL_PASSWORD>`. Change port and hostname according to your current configuration

## For advanced users

You want to use this container and code to build and create locally this container, follow theses instructions.

This section will help you if you want to :
* Get latest version of this service container
* Enhance container content by adding instruction in Dockefile before build step

You must have a working environment with the source code of this repository. Read and follow [how to setup your working environment](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to get a working directory. The following instructions assume you are at the top level of your working directory.

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/mariadb`
2. Build the container using `docker build -t sv-mariadb .`
3. Run this container 
  1. Interactively with `docker run -p 3306:3306 -v /logs -it sv-mariadb`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...) 
  2. As a daemon with `docker run -p 3306:3306 -v /logs -d sv-mariadb`


### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/mariadb`
2. Run this container 
  1. Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
  2. As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`

If you experience trouble with port already used, edit docker-compose.yml file and change port mapping
