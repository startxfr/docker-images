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

1. Build the container using `docker build -t <image_name> <path_to_Dockerfile>` where _image-name_ is the name of your future local image and*path_to_Dockerfile* should point to the targeted service or application directory, not including the Dockefile filename
2. Run this container
3. Interactively with `docker run -it <image_name>` where _image_name_ is the name of your previously created image name. If you add a second parameter, you can run a particular command instead of the default entrypoint. Could be usefull when you add `/bin/bash` to get a shell running into the container
4. As a daemon with `docker run -d <image_name>` where _image_name_ is the name of your previously created image name.

## Build & run a container using `docker-compose`

1. Jump into the container directory you wan to build with `cd <path_to_service>` where _path_to_service_ is the targeted service or application directory, not including the docker-compose.yml filename
2. Run this container
3. Interactively with `docker-compose up`. You should see container startup logs and escaping this command will stop the container
4. As a daemon with `docker-compose up -d`. You can look at your container startup and behaviour with `docker-compose logs`

## masterToBranch Helper

This script will help you propagate updates from master branch to a distribution relase branch.

### Requirements

This script assume :

- You have a Centos/RHEL 8 environment running with all updates applied
- You have installed git
- You have cloned this repository content (git clone https://gitlab.com/startx1/containers)
- You are in the root directory of your cloned copy of this repository

### simulate a merge

```bash
# simulate merge from master to  fc34 branch (default)
./masterToBranch.sh  fc34

# simulate merge from master to centos8 branch with specified command
./masterToBranch.sh  fc34 simulate
```

### execute a merge

```bash
# execute a merge from master to  fc34 branch
./masterToBranch.sh  fc34 run
```

## OKD Helper

This script will help you load and run startx docker images in an OKD cluster

### Openshift requirements

This script assume :

- You have an openshift cluster running
- You have installed openshift client v3.11 minimum
- You are logged to you openshift cluster (oc login)
- You have cloned this repository content (git clone https://gitlab.com/startx1/containers)
- You are in the root directory of your cloned copy of this repository

### Setup project and flavour with openshift

```bash
# setup project
./okd-helper.sh setup project fedora

# setup flavour (alpine3, ubi8, centos8, centos7, centos6,
    - fc36, fc35, fc34, fc33, fc32, fc31, fc30, fc29 or fc28)
./okd-helper.sh setup flavour latest

# setup stage
./okd-helper.sh setup stage test
```

### Loading templates and images streams with openshift

#### Loading all templates and images streams with openshift

```bash
# Load all images streams and all templates
./okd-helper.sh load
```

#### Loading single image streams with openshift

```bash
# Load apache image streams
./okd-helper.sh load-is apache
```

#### Loading single template with openshift

```bash
# Load apache deploy template
./okd-helper.sh load-deploy apache

# Load apache build template
./okd-helper.sh load-build apache
```

### Testing templates with openshift

#### Testing single template with openshift

```bash
# Testing deploy template for apache
./okd-helper.sh test-deploy apache

# Testing build templates for apache
./okd-helper.sh test-build apache
```

#### Testing all templates with openshift

```bash
# Testing deploy templates
./okd-helper.sh test-deploy all
# Testing build templates
./okd-helper.sh test-build all
```

### Full test sequence with openshift

#### Test all in one project with openshift

```bash
# setup common stage and project
./okd-helper.sh setup stage mytest
./okd-helper.sh setup project myproject
# Start full test for fedora rawhide containers
./okd-helper.sh setup flavour fedora latest
./okd-helper.sh test
# Start full test for centos 8 containers
./okd-helper.sh setup flavour centos8
./okd-helper.sh test
# Start full test for centos 7 containers
./okd-helper.sh setup flavour centos7
./okd-helper.sh test
# Start full test for centos 6 containers
./okd-helper.sh setup flavour centos6
./okd-helper.sh test
# Start full test for fedora 36 containers
./okd-helper.sh setup flavour fc36
./okd-helper.sh test
# Start full test for fedora 35 containers
./okd-helper.sh setup flavour fc35
./okd-helper.sh test
# Start full test for fedora 34 containers
./okd-helper.sh setup flavour fc34
./okd-helper.sh test
# Start full test for fedora 33 containers
./okd-helper.sh setup flavour fc33
./okd-helper.sh test
# Start full test for fedora 32 containers
./okd-helper.sh setup flavour fc32
./okd-helper.sh test
# Start full test for fedora 31 containers
./okd-helper.sh setup flavour fc31
./okd-helper.sh test
# Start full test for fedora 30 containers
./okd-helper.sh setup flavour fc30
./okd-helper.sh test
# Start full test for fedora 29 containers
./okd-helper.sh setup flavour fc29
./okd-helper.sh test
# Start full test for alpine 3 containers
./okd-helper.sh setup flavour alpine3
./okd-helper.sh test
# Start full test for RedHat UBI 8 containers
./okd-helper.sh setup flavour ubi8
./okd-helper.sh test
```

#### Test in individuals project with openshift

```bash
# setup common stage
./okd-helper.sh setup stage mytest
# Start full test for fedora rawhide containers (dedicated project)
./okd-helper.sh setup project fedora-latest
./okd-helper.sh setup flavour latest
./okd-helper.sh test
# Start full test for centos 8 containers (dedicated project)
./okd-helper.sh setup project centos-8
./okd-helper.sh setup flavour centos8
./okd-helper.sh test
# Start full test for centos 7 containers (dedicated project)
./okd-helper.sh setup project centos-7
./okd-helper.sh setup flavour centos7
./okd-helper.sh test
# Start full test for centos 6 containers (dedicated project)
./okd-helper.sh setup project centos-6
./okd-helper.sh setup flavour centos6
./okd-helper.sh test
# Start full test for fedora 36 containers (dedicated project)
./okd-helper.sh setup project fedora-36
./okd-helper.sh setup flavour fc36
./okd-helper.sh test
# Start full test for fedora 35 containers (dedicated project)
./okd-helper.sh setup project fedora-35
./okd-helper.sh setup flavour fc35
./okd-helper.sh test
# Start full test for fedora 34 containers (dedicated project)
./okd-helper.sh setup project fedora-34
./okd-helper.sh setup flavour fc34
./okd-helper.sh test
# Start full test for fedora 33 containers (dedicated project)
./okd-helper.sh setup project fedora-33
./okd-helper.sh setup flavour fc33
./okd-helper.sh test
# Start full test for fedora 32 containers (dedicated project)
./okd-helper.sh setup project fedora-32
./okd-helper.sh setup flavour fc32
./okd-helper.sh test
# Start full test for fedora 31 containers (dedicated project)
./okd-helper.sh setup project fedora-31
./okd-helper.sh setup flavour fc31
./okd-helper.sh test
# Start full test for fedora 30 containers (dedicated project)
./okd-helper.sh setup project fedora-30
./okd-helper.sh setup flavour fc30
./okd-helper.sh test
# Start full test for fedora 29 containers (dedicated project)
./okd-helper.sh setup project fedora-29
./okd-helper.sh setup flavour fc29
./okd-helper.sh test
# Start full test for alpine 3 containers (dedicated project)
./okd-helper.sh setup project alpine-3
./okd-helper.sh setup flavour alpine3
./okd-helper.sh test
# Start full test for RedHat UBI 8 containers (dedicated project)
./okd-helper.sh setup project ubi-8
./okd-helper.sh setup flavour ubi8
./okd-helper.sh test
```

## Podman Helper

This script will help you load and run startx docker images on a local host (using Podman).

### Podman requirements

This script assume :

- You have a Centos/RHEL 8 environment running with all updates applied
- You have installed docker package (alias for podman, buildhah and much more)
- You have cloned this repository content (git clone https://gitlab.com/startx1/containers)
- You are in the root directory of your cloned copy of this repository

### Setup project and flavour with podman

```bash
# setup project
./podman-helper.sh setup project startx

# setup flavour (alpine3, ubi8, centos8, centos7, centos6, fc36, fc35, fc34, fc33, fc32, fc31, fc30, fc29 or fc28)
./podman-helper.sh setup flavour latest
```

### Building images with podman

#### Build image with podman

```bash
# build apache image
./podman-helper.sh build apache
```

#### Building all images with podman

```bash
# build all images
./podman-helper.sh build all
```

### Deploying images with podman

#### Deploy image with podman

```bash
# build apache image
./podman-helper.sh run apache
```

#### Deploying all images with podman

```bash
# build all images
./podman-helper.sh run all
```

### Full build & run sequence with podman

#### Start all in one project with podman

```bash
# setup common project
./podman-helper.sh setup project test
# Start full test for fedora rawhide containers
./podman-helper.sh setup flavour latest
./podman-helper.sh buildrun
# Start full test for centos 8 containers
./podman-helper.sh setup flavour centos8
./podman-helper.sh buildrun
# Start full test for centos 7 containers
./podman-helper.sh setup flavour centos7
./podman-helper.sh buildrun
# Start full test for centos 6 containers
./podman-helper.sh setup flavour centos6
./podman-helper.sh buildrun
# Start full test for fedora 36 containers
./podman-helper.sh setup flavour fc36
./podman-helper.sh buildrun
# Start full test for fedora 35 containers
./podman-helper.sh setup flavour fc35
./podman-helper.sh buildrun
# Start full test for fedora 34 containers
./podman-helper.sh setup flavour fc34
./podman-helper.sh buildrun
# Start full test for fedora 33 containers
./podman-helper.sh setup flavour fc33
./podman-helper.sh buildrun
# Start full test for fedora 32 containers
./podman-helper.sh setup flavour fc32
./podman-helper.sh buildrun
# Start full test for fedora 31 containers
./podman-helper.sh setup flavour fc31
./podman-helper.sh buildrun
# Start full test for fedora 30 containers
./podman-helper.sh setup flavour fc30
./podman-helper.sh buildrun
# Start full test for fedora 29 containers
./podman-helper.sh setup flavour fc29
./podman-helper.sh buildrun
# Start full test for alpine 3 containers
./podman-helper.sh setup flavour alpine3
./podman-helper.sh buildrun
# Start full test for RedHat UBI 8 containers
./podman-helper.sh setup flavour ubi8
./podman-helper.sh buildrun
```

#### Test in individuals project with podman

```bash
# setup common stage
# Start full test for fedora rawhide containers (dedicated project)
./podman-helper.sh setup project fedora-latest
./podman-helper.sh setup flavour latest
./podman-helper.sh buildrun
# Start full test for centos 8 containers (dedicated project)
./podman-helper.sh setup project centos-8
./podman-helper.sh setup flavour centos8
./podman-helper.sh buildrun
# Start full test for centos 7 containers (dedicated project)
./podman-helper.sh setup project centos-7
./podman-helper.sh setup flavour centos7
./podman-helper.sh buildrun
# Start full test for centos 6 containers (dedicated project)
./podman-helper.sh setup project centos-6
./podman-helper.sh setup flavour centos6
./podman-helper.sh buildrun
# Start full test for fedora 36 containers (dedicated project)
./podman-helper.sh setup project fedora-36
./podman-helper.sh setup flavour fc36
./podman-helper.sh buildrun
# Start full test for fedora 35 containers (dedicated project)
./podman-helper.sh setup project fedora-35
./podman-helper.sh setup flavour fc35
./podman-helper.sh buildrun
# Start full test for fedora 34 containers (dedicated project)
./podman-helper.sh setup project fedora-34
./podman-helper.sh setup flavour fc34
./podman-helper.sh buildrun
# Start full test for fedora 33 containers (dedicated project)
./podman-helper.sh setup project fedora-33
./podman-helper.sh setup flavour fc33
./podman-helper.sh buildrun
# Start full test for fedora 32 containers (dedicated project)
./podman-helper.sh setup project fedora-32
./podman-helper.sh setup flavour fc32
./podman-helper.sh buildrun
# Start full test for fedora 31 containers (dedicated project)
./podman-helper.sh setup project fedora-31
./podman-helper.sh setup flavour fc31
./podman-helper.sh buildrun
# Start full test for fedora 30 containers (dedicated project)
./podman-helper.sh setup project fedora-30
./podman-helper.sh setup flavour fc30
./podman-helper.sh buildrun
# Start full test for fedora 29 containers (dedicated project)
./podman-helper.sh setup project fedora-29
./podman-helper.sh setup flavour fc29
./podman-helper.sh buildrun
# Start full test for alpine 3 containers (dedicated project)
./podman-helper.sh setup project alpine-3
./podman-helper.sh setup flavour alpine3
./podman-helper.sh buildrun
# Start full test for RedHat UBI 8 containers (dedicated project)
./podman-helper.sh setup project ubi-8
./podman-helper.sh setup flavour ubi8
./podman-helper.sh buildrun
```
