#!/bin/bash
docker build -t sv-apache Services/apache/
docker build -t sv-mariadb Services/mariadb/
docker build -t sv-memcache Services/memcache/
docker build -t sv-mongo Services/mongo/
docker build -t sv-nodejs Services/nodejs/
docker build -t sv-php Services/php/
docker build -t sv-postgres Services/postgres/
docker build -t sv-ooconv Services/ooconv/
docker build -t sv-ssh Services/ssh/