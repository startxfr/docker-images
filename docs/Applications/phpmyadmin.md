<img align="left" src="https://raw.githubusercontent.com/startxfr/docker-images/master/docs/img/app-phpmyadmin.svg?sanitize=true">
<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true">

# STARTX Application docker-images : PHPMyAdmin

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/Services/phpmyadmin/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/app-phpmyadmin.svg)](https://hub.docker.com/r/startx/app-phpmyadmin) [![Docker phpmyadmin pulls](https://img.shields.io/docker/pulls/startx/app-phpmyadmin)](https://hub.docker.com/r/startx/app-phpmyadmin) [![Docker Repository on Quay](https://quay.io/repository/startx/phpmyadmin/status "Docker Repository on Quay")](https://quay.io/repository/startx/phpmyadmin)

Container running phpMyAdmin under a fedora server.

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

## Running from docker registry

    docker run -d -p 80:80 --name="pma" startx/app-pma
    when linked to another container
    docker run -d --name="mariadb" startx/sv-mariadb
    docker run -d -p 80:80 --name="pma" --link mariadb:mariadb startx/app-pma

## Build and run from local Dockerfile

### Building docker image

Copy sources in your docker host

    mkdir startx-docker-images;
    cd startx-docker-images;
    git clone https://gitlab.com/startx1/containers.git .

Build the container

    docker build -t startx/app-pma Applications/phpmyadmin/

### Running local image

    docker run -d -p 80:80 --name="pma" startx/app-pma

## Accessing server

access to the running webserver

    firefox http://localhost:80/pma

access to the container itself

    docker exec -it pma bash

## Related Resources

- [Sources files](https://gitlab.com/startx1/containers/tree/master/Applications/phpmyadmin)
- [Github STARTX profile](https://gitlab.com/startx1/containers)
- [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-phpmyadmin/)
- [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
