docker-images
=============

**Description**  
This repository contains a collection of Docker configurations used in STARTX IS.

**Usage**  
The following commands can be used to deploy some of the services offered by the Docker containers in this repository.

- **Applications (app)**

  - **phpmyadmin**
Based on the [maxexcloo phpmyadmin](https://github.com/maxexcloo/Docker) Dockerfile

          docker run --name="test-phpmyadmin" -p 81:80 -d -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/pma
          docker run --name="test-phpmyadmin" -d --link maria:maria -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/app-phpmyadmin

  - **rockmongo**
Based on the [maxexcloo phpmyadmin](https://github.com/maxexcloo/Docker) Dockerfile

          docker run --name="test-rockmongo" -p 82:80 -d -e VIRTUAL_HOST=rm.project.dev.startx.fr startx/rockmongo
          docker run --name="test-rockmongo" -d --link mongo:mongo -e VIRTUAL_HOST=mongo.project.dev.startx.fr startx/app-rockmongo

- **Services (sv)**

  - **php**
Based on the [tutum php](https://registry.hub.docker.com/u/tutum/apache-php) Dockerfile
	
          docker run --name="test-web" -d -e VIRTUAL_HOST=web.project.dev.startx.fr startx/sv-php

  - **mariadb**
	
          docker run --name="test-maria" -d startx/sv-maria
	
  - **mongodb** 
	
          docker run --name="test-mongo" -d startx/sv-mongo
	
  - **mysqldb**
	
          docker run --name="test-mysql" -d startx/sv-mysql

  - **postgres**
	
          docker run --name="test-postgres" -d startx/sv-postgres

  - **ooconv**
	
          docker run --name="test-ooconv" -d startx/sv-ooconv

