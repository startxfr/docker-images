# Develop image

You you want to use this repository and code to build and create locally theses containers. You can follow theses instructions to setup and working environment.

This section is usefull if you want :

- Get latest version of embedded services, applications and underlying OS
- Enhance container content by adding instruction into container(s) Dockefile before the build process
- Use this set of container and flavour to benchmark application performance

## Setup your working environment (mandatory)

If you want to be guided on setting-up and installing various containers engines
([docker](https://github.com/startxfr/containers-engines/blob/master/Docker.md),
[podman](https://github.com/startxfr/containers-engines/blob/master/Podman.md),
[s2i](https://github.com/startxfr/containers-engines/blob/master/S2I.md),
[dockerEE](https://github.com/startxfr/containers-engines/blob/master/DockerEE.md),
[kubernetes](https://github.com/startxfr/containers-engines/blob/master/Kubernetes.md),
[openshift](https://github.com/startxfr/containers-engines/blob/master/Openshift.md))
you can [read ours containers engines guidelines](https://github.com/startxfr/containers-engines).

1. **Install docker and docker-compose on your environment**
1. Check if you have a running docker daemon using `docker --version` If not try to run it using `sudo docker --daemon`. If docker is not installed, follow [docker installation guidelines](https://docs.docker.com/v1.8/installation/)
1. Check if you have docker-compose installed using `docker-compose --version`. If docker-compose is not installed, follow [docker-compose installation guidelines](https://docs.docker.com/compose/install/)
1. Check if you have git installed using `git --version`. If git is not installed, execute `sudo dnf install -yq git`
1. **Copy repository source locally**
1. Setup a working directory with `mkdir startx-docker-images; cd startx-docker-images;`
1. Clone source repository with `git clone https://gitlab.com/startx1/containers.git .`

## Build all containers using `docker-compose`

If you want to build and run locally all the images provided in this repository, you can follow this instructions

1. Choose your flavour with `git checkout ≤flavour_name>`. You can use every flavour available in this repository. Default is set to master branch related to the `:latest` flavour
2. Create host directory to store container content with `mkdir /tmp/container`.
3. Start building all containers with `docker-compose build`. You should be on top of your working directory to run this command. It will use the docker-compose.yml file located into this directory.
4. Wait... (could take some time as you are building the complete list of services
5. Run your multi-container with `docker-compose up -d`
6. Look at your containers startup with `docker-compose logs`. You can add a service name to get logs about this specific container. You can also monitor /tmp/container/logs to see logs comming from all containers
7. Monitor containers with `docker-compose ps`.

## Run a single container

## Build & run a container using `docker`

1. Build the container using `docker build -t <image_name> <path_to_Dockerfile>` where _image-name_ is the name of your future local image and_path_to_Dockerfile_ should point to the targeted service or application directory, not including the Dockefile filename
2. Run this container
3. Interactively with `docker run -it <image_name>` where _image_name_ is the name of your previously created image name. If you add a second parameter, you can run a particular command instead of the default entrypoint. Could be usefull when you add `/bin/bash` to get a shell running into the container
4. As a daemon with `docker run -d <image_name>` where _image_name_ is the name of your previously created image name.

## Build & run a container using `docker-compose`

1. Jump into the container directory you wan to build with `cd <path_to_service>` where _path_to_service_ is the targeted service or application directory, not including the docker-compose.yml filename
2. Run this container
3. Interactively with `docker-compose up`. You should see container startup logs and escaping this command will stop the container
4. As a daemon with `docker-compose up -d`. You can look at your container startup and behaviour with `docker-compose logs`
