STARTX docker-images - MongoDB
==============================

**Description**  
Based on the docker [default mongo](https://registry.hub.docker.com/_/mongo/) Dockerfile

**Usage**  

          docker run --name="test-mongo" -d startx/sv-mongo
          docker run -d -p 27017:27017 startx/sv-mongo
          docker run -d -p 27017:27017 --name="test-mongo" startx/sv-mongo

          docker run -d --name="test-mongo" startx/sv-mongo // linked to another container
          docker run -d --name="test-www" --link test-mongo:mongo startx/sv-php
