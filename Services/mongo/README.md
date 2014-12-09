# STARTX Services docker-images : MongoDB Server

Container running mongod daemon under a fedora server

## Running from docker registry

	docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo:fc21
        # when used with a volume container (run data container, then run service)
	docker run -d -v /var/lib/mongodb -v /var/log/mongodb --name mongo-data startx/sv-mongo:fc21  echo "Data container for mongodb"
	docker run -d -p 27017:27017 --volumes-from mongo-data --name="mongo" startx/sv-mongo:fc21
	when linked to another container
	docker run -d --name="mongo" startx/sv-mongo:fc21
	docker run -d -p 80:80 --name="php" --link mongo:mongo startx/sv-php:fc21

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. See sx/mongod_run.sh to perform some usefull task against the database, especially importing sql script, adding users and changing passwords. See also mongodb.conf for configuring the mongo server running in the container.

Build the container

	docker build -t sv-mongo:fc21 Services/mongo/

### Running local image

	docker run -d -p 27017:27017 --name="mongo" sv-mongo:fc21

## Accessing server
access to the running database

	mongo -h localhost -p 27017

access to the container itself

	docker exec -it mongo /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/mongo)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-mongo/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)

