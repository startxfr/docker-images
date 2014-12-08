# STARTX Services docker-images : SSH Server
This container run sshd on fedora server. You can overwrite /root/.ssh/autorized_keys with your own list of autorized keys.

## Running from docker registry

	docker run -d -p 22022:22 --name="ssh" startx/sv-ssh:fc20

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t sv-ssh:fc20 Services/ssh/

### Running local image

	docker run -d -p 22022:22 --name="ssh" sv-ssh:fc20

## Accessing server
access to the running server

	ssh -p 22022 root@localhost

access to the container itself

	docker exec -it ssh /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/ssh)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-ssh/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
