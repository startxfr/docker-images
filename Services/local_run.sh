#!/bin/bash
docker run -d -p 81:80 --name="centos7-lbapache" sv-apache:centos7
docker run -d -p 3307:3306 --name="centos7-lbmariadb" sv-mariadb:centos7
docker run -d -p 11212:11211 --name="centos7-lbmemcache" sv-memcache:centos7
docker run -d -p 27018:27017 --name="centos7-lbmongo" sv-mongo:centos7
docker run -d -p 8001:8000 --name="centos7-lbnodejs" sv-nodejs:centos7
docker run -d -p 83:80 --name="centos7-lbphp" sv-php:centos7
docker run -d -p 5433:5432 --name="centos7-lbpostgres" sv-postgres:centos7
docker run -d -p 2002:2002 --name="centos7-lbooconv" sv-ooconv:centos7
docker run -d -p 22023:22 --name="centos7-lbssh" sv-ssh:centos7

