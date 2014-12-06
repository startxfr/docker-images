#!/bin/bash
docker build -t sv-apache:fc21 Services/apache/
docker build -t sv-mariadb:fc21 Services/mariadb/
docker build -t sv-memcache:fc21 Services/memcache/
docker build -t sv-mongo:fc21 Services/mongo/
docker build -t sv-nodejs:fc21 Services/nodejs/
docker build -t sv-php:fc21 Services/php/
docker build -t sv-postgres:fc21 Services/postgres/
docker build -t sv-ssh:fc21 Services/ssh/