#!/bin/bash
docker build -t sv-apache:centos6 Services/apache/
docker build -t sv-mariadb:centos6 Services/mariadb/
docker build -t sv-memcache:centos6 Services/memcache/
docker build -t sv-mongo:centos6 Services/mongo/
docker build -t sv-nodejs:centos6 Services/nodejs/
docker build -t sv-php:centos6 Services/php/
docker build -t sv-postgres:centos6 Services/postgres/
docker build -t sv-ooconv:centos6 Services/ooconv/
docker build -t sv-ssh:centos6 Services/ssh/