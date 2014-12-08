#!/bin/bash
docker run -d -p 85:80 --name="centos6-apache" startx/sv-apache:centos6
docker run -d -p 3311:3306 --name="centos6-mariadb" startx/sv-mariadb:centos6
docker run -d -p 11216:11211 --name="centos6-memcache" startx/sv-memcache:centos6
docker run -d -p 27023:27017 --name="centos6-mongo" startx/sv-mongo:centos6
docker run -d -p 8005:8000 --name="centos6-nodejs" startx/sv-nodejs:centos6
docker run -d -p 87:80 --name="centos6-php" startx/sv-php:centos6
docker run -d -p 5437:5432 --name="centos6-postgres" startx/sv-postgres:centos6
docker run -d -p 2007:2002 --name="centos6-ooconv" startx/sv-ooconv:centos6
docker run -d -p 22027:22 --name="centos6-ssh" startx/sv-ssh:centos6