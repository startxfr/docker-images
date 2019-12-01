<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# STARTX Docker-Images GitlabRunner Repository

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/)

[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

This directory host various Open Source gitlab runner into docker containers based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry
or as a parent container in your own container's.
Each container is provided with various underlying OS version based on CentOS or
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, GitlabRunner, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in
your project and start using stable or experimental gitlab-runner's in your pipeline

## Available services

| Service     | Docker.io                                                                 | Quay.io                                                                     | Docs                        |
| ----------- | ------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------- |
| **Ansible** | [`startx/runner-ansible`](https://hub.docker.com/r/startx/runner-ansible) | [`startx/runner-ansible`](https://quay.io/repository/startx/runner-ansible) | [manual](ansible/README.md) |
| **Apache**  | [`startx/runner-apache`](https://hub.docker.com/r/startx/runner-apache)   | [`startx/runner-apache`](https://quay.io/repository/startx/runner-apache)   | [manual](apache/README.md)  |
| **bash**    | [`startx/runner-bash`](https://hub.docker.com/r/startx/runner-bash)       | [`startx/runner-bash`](https://quay.io/repository/startx/runner-bash)       | [manual](bash/README.md)    |
| **nodejs**  | [`startx/runner-nodejs`](https://hub.docker.com/r/startx/runner-nodejs)   | [`startx/runner-nodejs`](https://quay.io/repository/startx/runner-nodejs)   | [manual](nodejs/README.md)  |
| **php**     | [`startx/runner-php`](https://hub.docker.com/r/startx/runner-php)         | [`startx/runner-php`](https://quay.io/repository/startx/runner-php)         | [manual](php/README.md)     |

## Available Flavours

| Service     | Fedora flavours                           | CentOS flavours                  | Alpine     | UBI     |
| ----------- | ----------------------------------------- | -------------------------------- | ---------- | ------- |
| **Ansible** | `:latest` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **Apache**  | `:latest` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **bash**    | `:latest` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **nodejs**  | `:latest` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **php**     | `:latest` `:fc29` `:fc30` `:fc31` `:fc32` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |

## Running from dockerhub registry

| Runner      | Command                                                                  |
| ----------- | ------------------------------------------------------------------------ |
| **Ansible** | `docker run -d -p 80:80 --name="runner-ansible" startx/runner-apache`    |
| **Apache**  | `docker run -d -p 80:80 --name="runner-apache" startx/runner-apache`     |
| **bash**    | `docker run -d -p XXX:XXX --name="runner-bash" startx/runner-bash`       |
| **nodejs**  | `docker run -d -p 8000:8000 --name="runner-nodejs" startx/runner-nodejs` |
| **php**     | `docker run -d -p 80:80 --name="runner-php" startx/runner-php`           |
