docker-images
=============

**Description**  
This repository contains a collection of Docker configurations used in STARTX IS.

**Usage**  
The following commands can be used to deploy some of the services offered by the Docker containers in this repository.

- **Applications (app)**

  - **phpmyadmin**

          docker run --name="app-pma" -d --link mariadb:mariadb -e VIRTUAL_HOST=pma.project.dev.startx.fr startxfr/app-phpmyadmin

  - **rockmongo**

          docker run --name="app-rm" -d --link mongodb:mongodb -e VIRTUAL_HOST=mongo.project.dev.startx.fr startxfr/app-rockmongo

- **Services (sv)**

  - **php**
	
          docker run --name="sv-php" -d -e VIRTUAL_HOST=php.project.dev.startx.fr startxfr/sv-php

  - **mariadb**
	
          docker run --name="sv-mariadb" -d startxfr/sv-mariadb
	
  - **mongodb** 
	
          docker run --name="sv-mongodb" -d startxfr/sv-mongodb
	
  - **mysqldb**
	
          docker run --name="sv-mysqldb" -d startxfr/sv-mysqldb

