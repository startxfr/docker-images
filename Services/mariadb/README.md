# STARTX Services docker-images : MariaDB Server

Container running mysqld daemon under a fedora server

## Running from docker registry

	docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb
        # when used with a volume container (run data container, then run service)
	docker run -d -v /var/lib/mysql -v /var/logs/mysql --name mariadb-data startx/sv-mariadb  echo "Data container for mariadb"
	docker run -d -p 3306:3306 --volumes-from mariadb-data --name="mariadb" startx/sv-mariadb
	# when used in a linked container
	docker run -d --name="mariadb" startx/sv-mariadb
	docker run -d --name="php" --link mariadb:mariadb startx/sv-php

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. See sx/mariadb_run.sh to perform some usefull task against the database, especially importing sql script, adding users and changing passwords. See also example.sql for injecting sql content when creating container.

Build the container

	docker build -t sv-mariadb Services/mariadb/

### Running local image

	docker run -d -p 3306:3306 --name="mariadb" sv-mariadb

## Accessing server
get connection information's, use docker logs to see result and connection details

	docker logs mariadb

access to the running database

	mysql -h localhost -p 3306

access to the container itself

	docker exec -it mariadb /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/mariadb)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-mariadb/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
* [Fedora-files mariadb container](https://github.com/fedora-cloud/Fedora-Dockerfiles/tree/master/mariadb)
* [Tutum mariadb container](https://registry.hub.docker.com/u/tutum/mariadb/)
* [Tutum mariadb github](https://github.com/tutumcloud/tutum-docker-mariadb)
* [Dylan Lindgren mariadb container](https://registry.hub.docker.com/u/dylanlindgren/docker-mariadb/)