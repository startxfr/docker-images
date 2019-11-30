[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX Docker-Images GitlabRunner Repository

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

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/) | [STARTX Profile](https://github.com/startxfr) |
| ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------- |


## Available runner's

| Runner  | Docker Hub repository                                                     | Fedora flavours                                                                           | CentOS flavours                  | Doc                         |
| ------- | ------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------------------------------- | --------------------------- |
| Ansible | [`startx/runner-ansible`](https://hub.docker.com/r/startx/runner-ansible) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` | `:centos6` `:centos7` `:centos8` | [manual](ansible/README.md) |
| Apache  | [`startx/runner-apache`](https://hub.docker.com/r/startx/runner-apache)   | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` | `:centos6` `:centos7` `:centos8` | [manual](apache/README.md)  |
| nodejs  | [`startx/runner-nodejs`](https://hub.docker.com/r/startx/runner-nodejs)   | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31`         | `:centos6` `:centos7` `:centos8` | [manual](nodejs/README.md)  |
| bash    | [`startx/runner-bash`](https://hub.docker.com/r/startx/runner-bash)       | `:latest` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31`         | `:centos6` `:centos7` `:centos8` | [manual](bash/README.md)    |
| php     | [`startx/runner-php`](https://hub.docker.com/r/startx/runner-php)         | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` | `:centos6` `:centos7` `:centos8` | [manual](php/README.md)     |

## Running from dockerhub registry

| Runner      | Command                                                                  |
| ----------- | ------------------------------------------------------------------------ |
| **Ansible** | `docker run -d -p 80:80 --name="runner-ansible" startx/runner-apache`    |
| **Apache**  | `docker run -d -p 80:80 --name="runner-apache" startx/runner-apache`     |
| **nodejs**  | `docker run -d -p 8000:8000 --name="runner-nodejs" startx/runner-nodejs` |
| **bash**    | `docker run -d -p XXX:XXX --name="runner-bash" startx/runner-bash`       |
| **php**     | `docker run -d -p 80:80 --name="runner-php" startx/runner-php`           |
