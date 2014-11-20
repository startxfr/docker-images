# STARTX Services docker-images : SSH Server
This container run sshd on fedora server. You can overwrite /root/.ssh/autorized_keys with your own list of autorized keys.

## Running from docker registry

	docker run -d -p 22022:22 --name="ssh" startx/sv-ssh

## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 

        mkdir startx-docker-images; 
        cd startx-docker-images;
        git clone https://github.com/startxfr/docker-images.git .

and build the container

        docker build -t sv-ssh Services/ssh/

### Running local image

	docker run -d -p 22022:22 --name="ssh" sv-ssh

## Accessing server

	ssh -p 22022 root@<containerId>

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/ssh)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-ssh/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
