# STARTX docker-images repository

Docker container images all based on red hat like distributions. Actually you can find fedora and centos.

## Running container from docker registry images

* Operating Systems
  * **Fedora** `docker run -it --name="fedora" startx/fedora bash`
  * **CentOS** `docker run -it --name="centos" startx/centos bash`
* Services
  * **Apache** `docker run -d -p 80:80 --name="apache" startx/sv-apache`
  * **MariaDB** `docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb`
  * **Memcache** `docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache`
  * **MongoDB** `docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo`
  * **nodejs** `docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs`
  * **ooconv** `docker run -d -p XXX:XXX --name="ooconv" startx/sv-ooconv`
  * **php** `docker run -d -p 80:80 --name="php" startx/sv-php`
  * **postgreSQL** `docker run -d -p 5432:5432 --name="postgres" startx/sv-postgres`
  * **SSH** `docker run -d -p 22:22 --name="ssh" startx/sv-ssh`
* Applications
  * **PhpMyAdmin** `docker run -d -p 80:80 --name="pma" startx/app-pma`
  * **RockMongo** `docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo`

## Flavors (tags) for Red Hat like container's

This repository offer various flavour of Red Hat like distribution. Tag `:latest` is actually pointing to fedora core 20


| Service | Docker Hub repository | :latest | :fc20 | :fc21 | :centos6 | :centos7 |
|---------|-----------------------|---------|-------|-------|----------|----------|
| Apache | `startx/sv-apache` | :latest | :fc20 | :fc21 | :centos6 | :centos7 |


* Operating Systems
  * **Fedora** : `:latest` `:20` `:21`
  * **CentOS** : `:6` `:7`
* Services
  * **Apache** :  `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **MariaDB** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **Memcache** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **MongoDB** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **nodejs** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **ooconv** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **php** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **postgreSQL** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **SSH** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
* Applications
  * **PhpMyAdmin** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`
  * **RockMongo** : `:latest` `:fc20` `:fc21` `:centos6` `:centos7`

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host / build server

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t <tag_name> <path_to_Dockerfile>

### Running local image
Running an interactive image and get access to shell

	docker run -it <image_name> <cmd>

Running an image as a daemon

	docker run -d <image_name>
	docker exec -it <image_name> <cmd>

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)