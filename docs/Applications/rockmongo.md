[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://gitlab.com/startx1/containers)

# STARTX Application docker-images : Rockmongo

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://gitlab.com/startx1/containers/tree/master/Services/rockmongo/) [![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://gitlab.com/startx1/containers) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Dockerhub Registry](https://img.shields.io/docker/build/startx/app-rockmongo.svg)](https://hub.docker.com/r/startx/app-rockmongo) [![Docker rockmongo pulls](https://img.shields.io/docker/pulls/startx/app-rockmongo)](https://hub.docker.com/r/startx/app-rockmongo) [![Docker Repository on Quay](https://quay.io/repository/startx/rockmongo/status "Docker Repository on Quay")](https://quay.io/repository/startx/rockmongo)

Container running rockmongo under a fedora server.

## Running from docker registry

    docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo
    when linked to another container
    docker run -d --name="mongo" startx/sv-mongo
    docker run -d -p 80:80 --name="rockmongo" --link mongo:mongo startx/app-rockmongo

## Build and run from local Dockerfile

### Building docker image

Copy sources in your docker host

    mkdir startx-docker-images;
    cd startx-docker-images;
    git clone https://gitlab.com/startx1/containers.git .

Build the container

    docker build -t startx/app-rockmongo Applications/rockmongo/

### Running local image

    docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo

## Accessing server

access to the running webserver

    firefox http://localhost:80/rockmongo

access to the container itself

    docker exec -it rockmongo bash

## Related Resources

- [Sources files](https://gitlab.com/startx1/containers/tree/master/Applications/rockmongo)
- [Github STARTX profile](https://gitlab.com/startx1/containers)
- [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-rockmongo/)
- [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
