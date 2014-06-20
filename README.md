docker-images
=============

**Description**  
This repository contains a collection of Docker configurations used in STARTX IS.

**Usage**  
The following commands can be used to deploy some of the services offered by the Docker containers in this repository.

- **Applications (app)**

  - **phpmyadmin**
Based on the [maxexcloo phpmyadmin|https://github.com/maxexcloo/Docker] Dockerfile

          docker run --name="app-pma" -p 81:80 -d -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/pma
          docker run --name="app-pma" -d --link mariadb:mariadb -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/app-phpmyadmin

  - **rockmongo**
Based on the [maxexcloo phpmyadmin|https://github.com/maxexcloo/Docker] Dockerfile

          docker run --name="app-rm" -p 82:80 -d -e VIRTUAL_HOST=rm.project.dev.startx.fr startx/rockmongo
          docker run --name="app-rm" -d --link mongodb:mongodb -e VIRTUAL_HOST=mongo.project.dev.startx.fr startx/app-rockmongo

- **Services (sv)**

  - **php**
	
          docker run --name="sv-php" -d -e VIRTUAL_HOST=php.project.dev.startx.fr startx/sv-php

  - **mariadb**
	
          docker run --name="sv-mariadb" -d startx/sv-mariadb
	
  - **mongodb** 
	
          docker run --name="sv-mongodb" -d startx/sv-mongodb
	
  - **mysqldb**
	
          docker run --name="sv-mysqldb" -d startx/sv-mysqldb

