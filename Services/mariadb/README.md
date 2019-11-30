<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# Docker OS Images : MARIADB on Fedora 31

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/fc32/Services/mariadb/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc32)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

[![Dockerhub Registry](https://img.shields.io/docker/build/startx/sv-mariadb.svg)](https://hub.docker.com/r/startx/sv-mariadb) [![Docker mariadb pulls](https://img.shields.io/docker/pulls/startx/sv-mariadb)](https://hub.docker.com/r/startx/sv-mariadb) [![Docker Repository on Quay](https://quay.io/repository/startx/mariadb/status "Docker Repository on Quay")](https://quay.io/repository/startx/mariadb)

Startx mariadb is a base container used for database services published in [Dockerhub registry](https://hub.docker.com/u/startx).
This container contain :

- fedora system envelope
- core OS rpm (kernel, libs) updated every week
- fundamentals tools (ex: pwgen, tar, zip) updated every week
- Mariadb SQL server and fundamentals modules (mariadb release depend on the flavour you use, read down for more information)
- usefull tools (psmisc, procps, coreutils, findutils, wget, curl, vi, bash-completion) only for the `:latest` and `:devel` flavour.

You can use Startx Mariadb image in many ways :

- Build container based image database with [s2i builder technology](#using-this-image-as-s2i-builder)
- Build container based image database with [openshift builder image capacity](#using-this-image-as-openshift-build-image)
- Build personalized base image [with docker tools](#using-this-image-as-base-container)
- Run as simple and lightweiht database [with docker daemon](#running-using-docker)
- Run a minimal container database [with docker-compose](#running-using-docker-compose)
- Enrich you openshift service catalog with [flavoured images streams](#openshift-images-streams)
- Add to your openshift service catalog a [database builder template](#openshift-builder-template)
- Add to your openshift service catalog a [database deployement template](#openshift-deploy-template)

See more databases builders and sample on [startx docker images repository](https://github.com/startxfr/docker-images/blob/master)

## Container flavours

| Docker Hub repository                                                     | Openshift                                                                                                                                                                                                                                                                                                                                                                              | Docker-compose                                                                                                   | Fedora distribution                                       |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| [`startx/sv-mariadb:latest`](https://hub.docker.com/r/startx/sv-mariadb)  | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core rawhide + MariaDB 10.3.16 (compat mysql 15.1) |
| [`startx/sv-mariadb:31`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 31 + MariaDB 10.3.16 (compat mysql 15.1)      |
| [`startx/sv-mariadb:30`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 30 + MariaDB 10.3.12 (compat mysql 15.1)      |
| [`startx/sv-mariadb:29`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 29 + MariaDB 10.3.12 (compat mysql 15.1)      |
| [`startx/sv-mariadb:28`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 28 + MariaDB 10.0.21 (compat mysql 15.1)      |
| [`startx/sv-mariadb:27`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 27 + MariaDB 10.0.21 (compat mysql 15.1)      |
| [`startx/sv-mariadb:26`](https://hub.docker.com/r/startx/sv-mariadb)      | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Fedora core 26 + MariaDB 10.0.21 (compat mysql 15.1)      |
| [`startx/sv-mariadb:23`](https://hub.docker.com/r/startx/sv-mariadb)      | **N/A**                                                                                                                                                                                                                                                                                                                                                                                | **N/A**                                                                                                          | Fedora 23                                                 |
| [`startx/sv-mariadb:22`](https://hub.docker.com/r/startx/sv-mariadb)      | **N/A**                                                                                                                                                                                                                                                                                                                                                                                | **N/A**                                                                                                          | Fedora 22                                                 |
| [`startx/sv-mariadb:21`](https://hub.docker.com/r/startx/sv-mariadb)      | **N/A**                                                                                                                                                                                                                                                                                                                                                                                | **N/A**                                                                                                          | Fedora 21                                                 |
| [`startx/sv-mariadb:20`](https://hub.docker.com/r/startx/sv-mariadb)      | **N/A**                                                                                                                                                                                                                                                                                                                                                                                | **N/A**                                                                                                          | Fedora 20                                                 |
| [`startx/sv-mariadb:centos8`](https://hub.docker.com/r/startx/sv-mariadb) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Centos 8                                                  |
| [`startx/sv-mariadb:centos7`](https://hub.docker.com/r/startx/sv-mariadb) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Centos 7                                                  |
| [`startx/sv-mariadb:centos6`](https://hub.docker.com/r/startx/sv-mariadb) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Centos 6                                                  |
| [`startx/sv-mariadb:alpine3`](https://hub.docker.com/r/startx/sv-mariadb) | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | Alpine 3.10 + MariaDB 10.2.14                             |
| [`startx/sv-mariadb:ubi8`](https://hub.docker.com/r/startx/sv-mariadb)    | [`imageStreams`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml) [`build`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml) [`deployement`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml) | [`compose`](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/docker-compose.yml) | RedHat UBI 8                                              |

## Running this image

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

### Running using docker

```bash
docker run -it -p 9231:3306 --name="example-mariadb" startx/sv-mariadb:fc32
```

- Connect to your local database

```bash
mysql -h localhost -P 9231
```

### Running using docker-compose

- Create a `docker-compose.yml` file with the following content

```yaml
mariadb:
  image: startx/sv-mariadb:fc32
  container_name: "example-mariadb"
```

- Connect to your local database

```bash
mysql -h localhost -P 9231
```

- Execute the following command

```bash
docker-compose up -d
docker-compose logs
```

### Using this image as Openshift Build image

#### Openshift images streams

Openshift cluster administrator can offer this image and all its flavour to all consumers.
You can import our [openshift images stream](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add image streams to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-imageStreams.yml
```

#### Openshift builder template

Openshift cluster administrator can add 2 build and deploy template to their consumers.
As an administrator, you can import our [openshift ephemeral builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml)
as well as our [openshift persistent builder template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build-persistent.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this ephemeral template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build.yml
# Add this persistent template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-build-persistent.yml
```

You can then build a database

```bash
# create an example project
oc new-project example
# start a new ephemeral database
oc process -f startx-mariadb-build-template \
    -p APP_NAME=mydb-e \
| oc create -f -
# start a new persistent database
oc process -f startx-mariadb-build-persist-template \
    -p APP_NAME=mydb-p \
| oc create -f -
```

#### Openshift deploy template

Openshift cluster administrator can add a deploy template to their consumers.
As an administrator, you can import our [openshift deploy template](https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml)
in your `openshift` project.

You must be cluster-admin to add this image to the `openshift` project. If not, you can add it to your own
project (skip the `oc project openshift` command in the next script)

```bash
# swith to the openshift project
oc project openshift
# Add this ephemeral template to the service catalog (project or cluster-wide scope)
oc create -f https://raw.githubusercontent.com/startxfr/docker-images/master/Services/mariadb/openshift-template-deploy.yml
```

You can then deploy a database

```bash
# create a example project
oc new-project example
# start a new ephemeral database
oc process -f startx-mariadb-deploy-template \
    -p APP_NAME=mydb-e \
| oc create -f -
# start a new persistent database
oc process -f startx-mariadb-deploy-persist-template \
    -p APP_NAME=mydb-p \
| oc create -f -
```

### Using this image as S2I builder

Create your local project (skip if you already are in a project diretory with a `run` bash script)

```bash
# Create a project directory
mkdir example-project
cd example-project
# create a run script
cat << "EOF"
DROP TABLE IF EXISTS `sample`;
CREATE TABLE `sample` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(128) NOT NULL DEFAULT '',
  `val` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sample` VALUES (1,'version','0.0.1');
EOF > schema-sample.sql
```

Then you can use this image as an s2i builder image

```bash
# With your current directory database code
s2i build . startx/sv-mariadb:fc32 startx-mariadb-mydb
docker run --rm -d -p 9231:3306 startx-mariadb-mydb
# With startx database sample code repository
s2i build https://github.com/startxfr/docker-images-example-mariadb startx/sv-mariadb:fc32 startx-mariadb-sample
docker run --rm -d -p 9231:3306 startx-mariadb-sample
```

### Using this image as base container

You can use this Dockerfile template to start a new personalized container based on this container. Create a file named `Dockerfile` in your project directory and copy this content inside. See [docker guide](http://docs.docker.com/engine/reference/builder/) for instructions on how to use this file.

```Dockerfile
FROM startx/sv-mariadb:fc32
#... your container specifications
```

## Environment variable

| Variable     | Type     | Default             | Description                                                    |
| ------------ | -------- | ------------------- | -------------------------------------------------------------- |
| SX_VERSION   | `string` | `latest`            | container version                                              |
| SX_TYPE      | `string` | `service`           | Container family (os, service, application). could be enhanced |
| SX_SERVICE   | `string` | `mariadb`           | Define the type of service or application provided             |
| SX_ID        | `auto`   | `startx/sv-mariadb` | Container ID coresponding to the image repository              |
| SX_NAME      | `auto`   | `yes`               | Container name                                                 |
| SX_SUMMARY   | `auto`   | `yes`               | Container purpose description                                  |
| SX_VERBOSE   | `bool`   | `no`                | Display information about the execution                        |
| SX_DEBUG     | `bool`   | `no`                | Display debug informations during execution                    |
| APP_PATH     | `string` | `/app`              | Path to the application                                        |
| LOG_PATH     | `string` | `/var/log/httpd`    | Destination path to the log produced by the webserver          |
| LOADSQL_PATH | `string` | `/tmp/sql`          | Path for sql script to use when initializing database          |
| SX_S2IDIR    | `string` | `/tmp`              | Destination path to the application pushed via s2i process     |

## For advanced users

You can contribute or start this container initiative locally.
[Follow theses instructions](https://github.com/startxfr/docker-images#setup-your-working-environment-mandatory) to setup a working environment.

This section will help you if you want to :

- Get latest version of this container Service source code
- Enhance and share your container improvement by adding instruction in Dockefile

### Build & run a container using `docker`

1. Jump into the container directory with `cd Services/mariadb`
2. Build the container using `docker build -t startx-mariadb .`
3. Run this container
   - Interactively with `docker run -it startx-mariadb`. If you add a second parameter (like `/bin/bash`) to will run this command instead of the default entrypoint. Usefull to interact with this container (ex: `/bin/bash`, `/bin/ps -a`, `/bin/df -h`,...)
   - As a daemon with `docker run -d -p 9231:3306 startx-mariadb`

### Build & run a container using `docker-compose`

1. Jump into the container directory with `cd Services/mariadb`
2. Run this container
   - Interactively with `docker-compose up` Startup logs appears and escaping this command stop the container
   - As a daemon with `docker-compose up -d`. Container startup logs can be read using `docker-compose logs`
