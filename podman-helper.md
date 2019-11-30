[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Podman Helper

This script will help you load and run startx docker images on a local host (using Podman).

## Requirements

This script assume :

- You have a Centos/RHEL 8 environment running with all updates applied
- You have installed docker package (alias for podman, buildhah and much more)
- You have cloned this repository content (git clone https://github.com/startxfr/docker-images)
- You are in the root directory of your cloned copy of this repository

## Setup project and flavour

```bash
# setup project
./podman-helper.sh setup project startx

# setup flavour (alpine3, ubi8, centos8, centos7, centos6, fc32, fc31, fc30, fc29 or fc28)
./podman-helper.sh setup flavour latest
```

## Building images

### Build image

```bash
# build apache image
./podman-helper.sh build apache
```

### Building all images

```bash
# build all images
./podman-helper.sh build all
```

## Deploying images

### Deploy image

```bash
# build apache image
./podman-helper.sh run apache
```

### Deploying all images

```bash
# build all images
./podman-helper.sh run all
```

## Full build & run sequence

### Start all in one project

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

### Test in individuals project

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
