#!/bin/bash
docker build -t sv-apache:fc20 Services/apache/
docker build -t sv-mariadb:fc20 Services/mariadb/
docker build -t sv-memcache:fc20 Services/memcache/
docker build -t sv-mongo:fc20 Services/mongo/
docker build -t sv-nodejs:fc20 Services/nodejs/
docker build -t sv-php:fc20 Services/php/
docker build -t sv-postgres:fc20 Services/postgres/
docker build -t sv-ooconv:fc20 Services/ooconv/
docker build -t sv-ssh:fc20 Services/ssh/