#!/bin/bash
docker run -d -p 80:80 --name="centos7-apache" startx/sv-apache:centos7
docker run -d -p 3306:3306 --name="centos7-mariadb" startx/sv-mariadb:centos7
docker run -d -p 11211:11211 --name="centos7-memcache" startx/sv-memcache:centos7
docker run -d -p 27017:27017 --name="centos7-mongo" startx/sv-mongo:centos7
docker run -d -p 8000:8000 --name="centos7-nodejs" startx/sv-nodejs:centos7
docker run -d -p 82:80 --name="centos7-php" startx/sv-php:centos7
docker run -d -p 5432:5432 --name="centos7-postgres" startx/sv-postgres:centos7
docker run -d -p 2002:2002 --name="centos7-ooconv" startx/sv-ooconv:centos7
docker run -d -p 22022:22 --name="centos7-ssh" startx/sv-ssh:centos7