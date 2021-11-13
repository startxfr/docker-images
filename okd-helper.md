[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true)](https://gitlab.com/startx1/containers)

# STARTX OKD Helper

This script will help you load and run startx docker images in an OKD cluster

## Requirements

This script assume :

- You have an openshift cluster running
- You have installed openshift client v3.11 minimum
- You are logged to you openshift cluster (oc login)
- You have cloned this repository content (git clone https://gitlab.com/startx1/containers)
- You are in the root directory of your cloned copy of this repository

## Setup project and flavour

```bash
# setup project
./okd-helper.sh setup project fedora

# setup flavour (alpine3, ubi8, centos8, centos7, centos6, fc35, fc34, fc33, fc32, fc31, fc30, fc29 or fc28)
./okd-helper.sh setup flavour latest

# setup stage
./okd-helper.sh setup stage test
```

## Loading templates and images streams

### Loading all templates and images streams

```bash
# Load all images streams and all templates
./okd-helper.sh load
```

### Loading single image streams

```bash
# Load apache image streams
./okd-helper.sh load-is apache
```

### Loading single template

```bash
# Load apache deploy template
./okd-helper.sh load-deploy apache

# Load apache build template
./okd-helper.sh load-build apache
```

## Testing templates

### Testing single template

```bash
# Testing deploy template for apache
./okd-helper.sh test-deploy apache

# Testing build templates for apache
./okd-helper.sh test-build apache
```

### Testing all templates

```bash
# Testing deploy templates
./okd-helper.sh test-deploy all
# Testing build templates
./okd-helper.sh test-build all
```

## Full test sequence

### Test all in one project

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

### Test in individuals project

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
