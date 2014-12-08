#!/bin/bash
docker build -t sv-apache:centos7 Services/apache/
docker build -t sv-mariadb:centos7 Services/mariadb/
docker build -t sv-memcache:centos7 Services/memcache/
docker build -t sv-mongo:centos7 Services/mongo/
docker build -t sv-:centos7 Services/nodejs/
docker build -t sv-php:centos7 Services/php/
docker build -t sv-postgres:centos7 Services/postgres/
docker build -t sv-ooconv:centos7 Services/ooconv/
docker build -t sv-ssh:centos7 Services/ssh/