#!/bin/bash
docker run -d -p 80:80 --name="fc21-apache" startx/sv-apache:fc21
docker run -d -p 3306:3306 --name="fc21-mariadb" startx/sv-mariadb:fc21
docker run -d -p 11211:11211 --name="fc21-memcache" startx/sv-memcache:fc21
docker run -d -p 27017:27017 --name="fc21-mongo" startx/sv-mongo:fc21
docker run -d -p 8000:8000 --name="fc21-nodejs" startx/sv-nodejs:fc21
docker run -d -p 82:80 --name="fc21-php" startx/sv-php:fc21
docker run -d -p 5432:5432 --name="fc21-postgres" startx/sv-postgres:fc21
docker run -d -p 22022:22 --name="fc21-ssh" startx/sv-ssh:fc21