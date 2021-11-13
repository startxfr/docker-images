# STARTX Application docker-images : Rockmongo

Container running rockmongo under a alpine server.

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
