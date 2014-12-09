# STARTX Services docker-images : PostgreSQL Server

Container running postgres daemon under a centos server. 

## Running from docker registry

	docker run -d -p 5432:5432 --name="postgres" startx/sv-postgres:centos6
        # when used with a volume container (run data container, then run service)
	docker run -d -v /var/log/pgsql -v /var/lib/pgsql --name postgres-data startx/sv-postgres:centos6  echo "Data container for postgresql"
	docker run -d -p 5432:5432 --volumes-from postgres-data --name="postgres" startx/sv-postgres:centos6
	when linked to another container
	docker run -d --name="postgres" startx/sv-postgres:centos6
	docker run -d --name="php" --link postgres:postgres startx/sv-php:centos6

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t sv-postgres:centos6 Services/postgres/

### Running local image

	docker run -d -p 5432:5432 --name="postgres" sv-postgres:centos6

## Accessing server
access to the running database

	psql -U postgres -h localhost -p 5432

access to the container itself

	docker exec -it mongo bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/postgres)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-postgres/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
