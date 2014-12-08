#!/bin/bash
docker run -d -p 85:80 --name="apache" startx/sv-apache:centos6
docker run -d -p 3311:3306 --name="mariadb" startx/sv-mariadb:centos6
docker run -d -p 11216:11211 --name="memcache" startx/sv-memcache:centos6
docker run -d -p 27023:27017 --name="mongo" startx/sv-mongo:centos6
docker run -d -p 8005:8000 --name="nodejs" startx/sv-nodejs:centos6
docker run -d -p 87:80 --name="php" startx/sv-php:centos6
docker run -d -p 5437:5432 --name="postgres" startx/sv-postgres:centos6
docker run -d -p 2007:2002 --name="ooconv" startx/sv-ooconv:centos6
docker run -d -p 22027:22 --name="ssh" startx/sv-ssh:centos6