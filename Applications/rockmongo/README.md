STARTX docker-images - RockMongo
================================

**Description**  
Based on the [maxexcloo rockmongo](https://github.com/maxexcloo/Docker) Dockerfile

**Usage**  

          docker run --name="test-rockmongo" -p 81:80 -d -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/pma
          docker run --name="test-rockmongo" -d --link test-mongo:test-mongo -e VIRTUAL_HOST=rm.project.dev.startx.fr startx/app-rockmongo
